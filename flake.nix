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
      hyprrecord = prev.callPackage ./hyprrecord {hyprland = null;};
      powermenu = prev.callPackage ./powermenu {hyprland = null;};
      zellijmenu = prev.callPackage ./zellijmenu {};
    };

    packages = genSystems (system: self.overlays.default null pkgsFor.${system});

    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
