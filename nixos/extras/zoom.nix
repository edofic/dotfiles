{ stdenv, fetchurl

# Linked dynamic libraries
, glib, gstreamer, libuuid, mesa, pulseaudioFull, qt55, sqlite, xorg
}:

stdenv.mkDerivation {
  name = "zoom";
  version = "1.1.44485.0317";

  src = fetchurl {
    url = https://zoom.us/client/latest/zoom_2.0.52458.0531_x86_64.tar.xz;
    md5 = "b34981522edfa3dc821f892f44b84208";
  };

  libPath = stdenv.lib.makeLibraryPath [
    glib
    gstreamer
    libuuid
    mesa
    pulseaudioFull
    qt55.full
    sqlite
    stdenv.cc.cc
    xorg.libX11
    xorg.libXcomposite
    xorg.libXext
    xorg.libXfixes
    xorg.libXrender
    xorg.libxcb
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
  ];

  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/opt/zoom"
    cp -r * "$out/opt/zoom"
    mkdir "$out/bin/"

    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      --set-rpath "$libPath" "$out/opt/zoom/zoom"

    ln -s "$out/opt/zoom/zoom" "$out/bin/zoom"
  '';
}
