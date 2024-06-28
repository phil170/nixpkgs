{ lib, buildGoModule, fetchFromGitHub, nixosTests, ... }:

buildGoModule rec {
  pname = "podsync";
  version = "v2.7.0";

  src = fetchFromGitHub {
    owner = "mxpv";
    repo = "podsync";
    rev = "${version}";
    hash = "sha256-JfMHIvx6BwHsVOPFXXcfcXNEVd9c6+kmtabHzmDOz5E=";
  };

  vendorHash = "sha256-YgyNJoIC86dqIphZsgSM+Z5oNMLi3Lzol/9AVDQ++7I=";

  subPackages = [ "cmd/podsync" ];

  passthru.tests.podsync = nixosTests.podsync;

  meta = with lib; {
    homepage = "https://github.com/mxpv/podsync";
    description = "Turn YouTube or Vimeo channels, users, or playlists into podcast feeds";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = [ maintainers.phil170 ];
  };
}
