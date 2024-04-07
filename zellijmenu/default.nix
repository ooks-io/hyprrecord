{
  lib,
  stdenvNoCC,
  makeWrapper,
  coreutils,
  rofi-wayland,
}:
stdenvNoCC.mkDerivation {
  pname = "zellijmenu";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
  ];

  makeFlags = ["PREFIX=$(out)"];

  postInstall = ''
    wrapProgram $out/bin/zellijmenu --prefix PATH : \
      "/run/wrappers/bin:${lib.makeBinPath ([
        coreutils 
        rofi-wayland
        ])}"
  '';

  meta = with lib; {
    description = "Interactive cli and rofi menu for zellij";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ooks-io];
    mainProgram = "zellijmenu";
  };
}
