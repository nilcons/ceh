{ pkgs, do64 }:

with pkgs;
let
  src = fetchgit {
    url = "https://github.com/NixOS/nixops.git";
    rev = "c6a7df6988f4d9e0f9ce4aa3da5414171e41fc5e";
    sha256 = "0315nc445p0lv01fy2h6mmyjlgv713krb8my59mdk71ydq9sf12g";
  };
  rel = (import "${src}/release.nix") {};

in if do64 then rel.build.x86_64-linux else rel.build.i686-linux
