# Installing Nix

## Installing Nix on Unix-like / non-NixOS Linux Operating Systems

On non-NixOS Unix-like systems, it is recommended to use the [Determinate Systems](https://determinate.systems/nix/) nix installer.
This installer has many sensible defaults, including:

- Enabling the *unified CLI*, which is more robust than the default method of using Nix
- Enabling [Nix flakes](https://nixos.wiki/wiki/Flakes), which are disabled in new Nix installations by default 

See [this blogpost](https://determinate.systems/posts/determinate-nix-installer/) for more information about the installer.

## Running an AWS EC2 instance with NixOS

The NixOS website has [official instructions](https://nixos.org/download/#nixos-amazon) on how to run an AWS EC2 instance with NixOS installed on it.
This is the best option for low-stakes experimentation with Nix without any commitment locally (virtual machine disk space, dual-boot configuration, etc).

## Installing NixOS in a virtual machine / locally

Please see the [official documentation](https://nixos.org/download/#nixos-iso) on how to install NixOS from an ISO.