# Expression generated by update.sh; do not edit it by hand!
{ stdenv, callPackage, ... }@args:

callPackage ./make-brave.nix (removeAttrs args [ "callPackage" ])
  (
    if stdenv.isAarch64 then
      {
        pname = "brave";
        version = "1.67.123";
        url = "https://github.com/brave/brave-browser/releases/download/v1.67.123/brave-browser_1.67.123_arm64.deb";
        hash = "sha256-YcTwa1sTKpLn9O4/M11nrjgItD6ktug1GFw0tNcZplg=";
        platform = "aarch64-linux";
      }
    else if stdenv.isx86_64 then
      {
        pname = "brave";
        version = "1.67.123";
        url = "https://github.com/brave/brave-browser/releases/download/v1.67.123/brave-browser_1.67.123_amd64.deb";
        hash = "sha256-L9Jcug6HQxJ4E2C9p8BdwxkD75F2j+HaEmgjdrU9oEo=";
        platform = "x86_64-linux";
      }
    else
      throw "Unsupported platform."
  )
