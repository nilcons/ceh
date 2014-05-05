{
  packageOverrides = pkgs: {
    cehNixOps = (import ./NixOpsDo.nix) { inherit pkgs; do64 = false; };
    cehNixOps64 = (import ./NixOpsDo.nix) { inherit pkgs; do64 = true; };
  };
}
