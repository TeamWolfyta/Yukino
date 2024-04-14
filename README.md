# Yukino

> Will write a README later..

## Usage

```nushell
sudo nixos-rebuild switch --flake github:TeamWolfyta/Yukino --option tarball-ttl 0
```

> [!IMPORTANT]
> The option `--option tarball-ttl 0` is used to prevent Nix from caching the GitHub repository, without this option I'm not sure it would ever actually check the GitHub repository to see if something changed.
