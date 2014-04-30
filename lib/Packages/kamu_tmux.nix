{
  packageOverrides = pkgs: {
    kamu_tmux = import ./end-to-end/kamu_tmux.nix;
  };
}
