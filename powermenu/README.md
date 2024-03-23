# Power menu

Simple powermenu utility script with accompanying dmenu.

## Installation

### Manual

```bash
$ git clone https://github.com/ooks-io/scripts.git
$ cd scripts/powermenu
$ make
$ sudo make install

# Cleanup repo if you want.
$ cd -
$ rm -rf scripts
```

Optionally you can just copy the script to your $PATH

### Nix

Add flake as input:

```nix
# flake.nix
{
  inputs = {
    # your inputs ...
    ooks-scripts = {
      url = "github:ooks-io/scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

# ... rest of flake
```

Ensure inputs are being passed into your home-manager/nixos config:

```nix
# flake.nix
homeConfiguration = {
  "YOURHOMEHERE" = home-manager.lib.homeManagerConfiguration {
    #...config
    extraSpecialArgs = {inherit inputs;};
  };
};
```

```nix
#flake.nix
nixosConfiguration = {
  SYSTEMHERE = nixpkgs.lib.nixosSystem {
    #...config
    specialArgs = {inherit inputs;};
  };
};
```

Add the package to configuration:

```nix
#home.nix
{ pkgs, inputs, ... }:
{
  home.packages = [ inputs.ooks-scripts.packages.${pkgs.system}.powermenu ];
}
```

```nix
#configuration.nix
{ pkgs, inputs, ... }:
{
  environment.systemPackages = [ inputs.ooks-scripts.packages.${pkgs.system}.powermenu ];
}
```

## Usage

```bash
$ powermenu [OPTIONS]... [ACTIONS]
```

### Options

| Command            | Result                                                           |
| ------------------ | ---------------------------------------------------------------- |
| `-c` `--countdown` | Enable 5 second countdown before performing action, except lock. |
| `-d` `--dry`       | Substitute action for notification, used for debugging.          |

### Actions

| Command    | Result                               |
| ---------- | ------------------------------------ |
| `usage`    | Prints help information              |
| `dmenu`    | Open rofi menu for selecting options |
| `logout`   | Kills hyprland session               |
| `poweroff` | Shutdown current host                |
| `reboot`   | Restart current host                 |
| `lock`     | Locks current session with           |
