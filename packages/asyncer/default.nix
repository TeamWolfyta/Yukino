{
  fetchPypi,
  lib,
  python3,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "asyncer";
  version = "0.0.7";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-1eVj+w9W64e5cleYRwNlik9bvbUv+FGz6O2GTMIAsdI=";
  };

  nativeBuildInputs = with python3.pkgs; [ pdm-backend ];

  propagatedBuildInputs = with python3.pkgs; [
    anyio
    typing-extensions
  ];

  pythonImportsCheck = [ "asyncer" ];

  meta = with lib; {
    description = "Asyncer, async and await, focused on developer experience";
    inherit (src.meta) homepage;
    license = licenses.mit;
    # maintainers = with maintainers; [ TeamWolfyta ]; # I'm not on the list. 😔
  };
}
