{ stdenv, hidapi, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "footswitch";
  buildInputs = [ hidapi ];
  src = fetchFromGitHub {
    owner = "rgerganov";
    repo = "footswitch";
    rev = "7cb0a9333a150c27c7e4746ee827765d244e567a";
    sha256 = "0mg1vr4a9vls5y435w7wdnr1vb5059gy60lvrdfjgzhd2wwf47iw";
  };
  buildCommand = ''
    cp -R $src ./src
    cd src
    mkdir -p $out/bin
    $CC footswitch.c common.c debug.c \
      -o $out/bin/footswitch \
      -I${hidapi}/include/hidapi \
      -lhidapi-libusb -L${hidapi}/lib
  '';
}
