{
  config,
  inputs,
  modulesPath,
  ...
}:
{
  imports = with inputs; [
    "${modulesPath}/profiles/minimal.nix"
    inputs.nixos-wsl.nixosModules.wsl
    inputs.nixos-hardware.nixosModules.common-pc
  ];

  wsl = {
    docker-desktop.enable = true;
    wslConf.network = {
      hostname = "angela";
    };
  };
}
