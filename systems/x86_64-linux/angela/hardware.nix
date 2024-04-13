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

  wsl =
    let
      name = config.yukino.user.name;
    in
    {
      enable = true;
      defaultUser = name;
      docker-desktop.enable = true;

      wslConf = {
        automount = {
          root = "/mnt";
        };

        network = {
          hostname = "angela";
        };

        user = {
          default = name;
        };
      };
    };
}
