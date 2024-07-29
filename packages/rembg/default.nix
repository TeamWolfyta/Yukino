{
  fetchFromGitHub,
  fetchurl,
  lib,
  namespace,
  pkgs,
  python3,
  runCommandLocal,
  symlinkJoin,
}:
let
  models =
    lib.mapAttrsToList
      (
        name: hash:
        fetchurl {
          inherit name hash;
          url = "https://github.com/danielgatis/rembg/releases/download/v0.0.0/${name}.onnx";
        }
      )
      {
        u2net = "sha256-jRDS87t1rjttUnx3lE/F59zZSymAnUenOaenKKkStJE=";
        u2netp = "sha256-MJyEaSWN2nQnk9zg6+qObdOTF0+Jk0cz7MixTHb03dg=";
        silueta = "sha256-ddpsjS+Alux0PQcZUb5ztKi8ez5R2aZiXWNkT5D/7ts=";
        isnet-general-use = "sha256-YJIOmcRUZPK6V77irQjJGaUrv4UnOelpR/u0NYwNlko=";
        isnet-anime = "sha256-8VYi2FPoJgFygStlcFNGDiCAbwS54FFH1Jr3vtMabpk=";
      };
  models_folder = symlinkJoin {
    name = "rembg-models";
    paths = map (
      model: runCommandLocal "rembg-models" { } "mkdir $out && ln -s ${model} $out/${model.name}.onnx"
    ) models;
  };
in
python3.pkgs.buildPythonApplication rec {
  pname = "rembg";
  version = "2.0.57";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "danielgatis";
    repo = "rembg";
    rev = "v${version}";
    hash = "sha256-71A46escxE8sType/3XSE8plHXNA7tKJ/Ltb0BwNcrs=";
  };

  nativeBuildInputs = with python3.pkgs; [
    setuptools
    wheel
  ];

  propagatedBuildInputs =
    with pkgs.${namespace};
    with python3.pkgs;
    [
      jsonschema
      numpy
      onnxruntime
      opencv4
      pillow
      pooch
      pymatting
      scikit-image
      scipy
      tqdm
      aiohttp
      asyncer
      click
      fastapi
      filetype
      gradio
      python-multipart
      uvicorn
      watchdog
    ];

  prePatch = ''
    substituteInPlace setup.py \
      --replace "opencv-python-headless" "opencv"
  '';

  preInstallCheck = ''
    export NUMBA_CACHE_DIR=$TMPDIR
  '';

  makeWrapperArgs = [
    "--prefix LD_LIBRARY_PATH : ${pkgs.onnxruntime}/lib"
    "--set U2NET_HOME ${models_folder}"
  ];

  meta = with lib; {
    description = "Rembg is a tool to remove images background";
    inherit (src.meta) homepage;
    license = licenses.mit;
    # maintainers = with maintainers; [ TeamWolfyta ]; # I'm not on the list. 😔
  };
}
