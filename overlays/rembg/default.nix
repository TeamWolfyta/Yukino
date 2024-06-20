{ lib, ... }:
final: prev:
let
  models = lib.mapAttrsToList (name: hash:
    prev.fetchurl {
      inherit name hash;
      url =
        "https://github.com/danielgatis/rembg/releases/download/v0.0.0/${name}.onnx";
    }) { isnet-anime = "sha256-8VYi2FPoJgFygStlcFNGDiCAbwS54FFH1Jr3vtMabpk="; };
  U2NET_HOME = prev.symlinkJoin {
    name = "u2net-home";
    paths = map (x:
      prev.runCommandLocal "u2net_home" { }
      "mkdir $out && ln -s ${x} $out/${x.name}.onnx ") models;
  };
in {
  yukino = {
    rembg = prev.nur.repos.nagy.python3Packages.rembg.overrideAttrs (_: {
      makeWrapperArgs = [
        "--prefix LD_LIBRARY_PATH : ${prev.onnxruntime}/lib "
        "--set U2NET_HOME ${U2NET_HOME}"
      ];
    });
  };
}
