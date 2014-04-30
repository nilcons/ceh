let
  alma = import ./alma.nix;
  a = import "${alma}/korte.nix";
in
derivation {
  system = "i686-linux";
  name = "kamu_tmux";
  builder = "/bin/bash";
  args = ["-c" "/bin/mkdir -p $out/bin; echo -e '#!/bin/sh\necho ${a.x}' > $out/bin/kamu_tmux; /bin/chmod 755 $out/bin/kamu_tmux"];
}
