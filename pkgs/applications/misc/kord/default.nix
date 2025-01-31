{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, alsa-lib
}:

rustPlatform.buildRustPackage rec {
  pname = "kord";
  version = "0.5.16";

  # kord depends on nightly features
  RUSTC_BOOTSTRAP = 1;

  src = fetchFromGitHub {
    owner = "twitchax";
    repo = "kord";
    rev = "v${version}";
    sha256 = "sha256-gI88fweOT2t+4cj58/mLygtTnue2Ai1QSC5oZf7Xv/g=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "bincode-2.0.0-rc.2" = "sha256-0BfKKGOi5EVIoF0HvIk0QS2fHUMG3tpsMLe2SkXeZlo=";
    };
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ alsa-lib ];

  meta = with lib; {
    description = "A music theory binary and library for Rust";
    homepage = "https://github.com/twitchax/kord";
    maintainers = with maintainers; [ kidsan ];
    license = with licenses; [ mit ];
  };
}
