{
  lib,
  stdenvNoCC,
  makeWrapper,
  scdoc,
  coreutils,
  wl-screenrec,
  jq,
  slurp,
  wl-clipboard,
  ffmpeg,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "hyprrecord";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [
    scdoc
  ];

  makeFlags = ["PREFIX=$(out)"];

  postInstall = ''
    wrapProgram $out/bin/hyprrecord --prefix PATH ';' \
      "${lib.makeBinPath ([
        coreutils
        wl-screenrec
        jq
        slurp
        wl-clipboard
        ffmpeg
      ]
      ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "Screen recording utility for Hyprland";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ooks-io];
    mainProgram = "hyprrecord";
  };
}
