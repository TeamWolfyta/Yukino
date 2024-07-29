{
  config,
  inputs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  imports = with inputs; [
    ./hardware.nix
    nixos-wsl.nixosModules.wsl
  ];

  networking.hostName = mkForce "angela";

  wsl =
    let
      _user = config.${namespace}.user;
    in
    {
      enable = true;
      defaultUser = _user.username;
      # Got new Nvidia GPU so this got added at a good time.
      useWindowsDriver = true;
      wslConf.user.default = _user.username;
    };

  yukino = {
    packages = {
      common = enabled;
      ffmpeg = enabled;
      gallery-dl = enabled;
      rembg = enabled;
    };
    programs = {
      eza = enabled;
      gh = enabled;
      git = enabled;
      nh = enabled;
      nix-ld = enabled;
      starship = enabled;
      zoxide = enabled;
      zsh = enabled;
    };
    security = {
      sudo = enabled;
    };
    services = {
      vscode-server = enabled;
    };
    suites = {
      development = {
        nix = enabled;
        typescript = enabled;
      };
      wsl = enabled;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
