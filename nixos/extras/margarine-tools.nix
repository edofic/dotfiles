{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "margarine-tools";
  src = fetchgit {
    url = https://github.com/bssstudio/margarine-tools.git;
    rev = "990a90bbe51a74ce3b5794b8488bd5a37a2b4d19";
    sha256 = "0pqp03nyx20i5n5wfxi3c3sm964sp4pq4v6yqjrba997jynglabg";
  };
  buildCommand = ''
    mkdir -p $out/bin
    cp $src/timesnap/timesnap.sh $out/bin/.
  '';
}
