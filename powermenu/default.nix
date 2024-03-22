{
  lib,
  stdenvNoCC,
  makeWrapper,
  coreutils,
  rofi-wayland,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "powermenu";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
  ];

  makeFlags = ["PREFIX=$(out)"];

  postInstall = ''
    wrapProgram $out/bin/powermenu --prefix PATH ';' \
      "${lib.makeBinPath ([
        coreutils
        rofi-wayland
      ]
      ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "Simple power utility script with rofi menu";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ooks-io];
    mainProgram = "powermenu";
  };
}
