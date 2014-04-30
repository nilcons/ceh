derivation {
  system = "i686-linux";
  name = "alma";
  builder = "/bin/bash";
  args = ["-c" "/bin/mkdir $out; echo Building alma...; echo '{ x = \"szilva5\"; }' > $out/korte.nix"];
}
