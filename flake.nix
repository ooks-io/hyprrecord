{
  description = "A simple screen recording script for hyprland";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    genSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
    pkgsFor = nixpkgs.legacyPackages;
  in {
    overlays.default = _: prev: {
      hyprrecord = prev.callPackage ./default.nix {hyprland = null;};
    };

    packages = genSystems (system: self.overlays.default null pkgsFor.${system});

    defaultPackage = genSystems (system: self.packages.${system}.hyprrecord);

    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
