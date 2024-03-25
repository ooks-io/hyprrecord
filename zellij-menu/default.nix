{
  lib,
  stdenvNoCC,
  makeWrapper,
  coreutils,
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
    wrapProgram $out/bin/powermenu --prefix PATH ';' \
      "${lib.makeBinPath ([
        coreutils ])}"
  '';

  meta = with lib; {
    description = "Interactive cli and rofi menu for zellij";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ooks-io];
    mainProgram = "zellijmenu";
  };
}
