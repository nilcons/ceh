#!/opt/ceh/lib/perl
# -*- mode: perl; -*-

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehInstall;

ceh_nixpkgs_install_for_emacs("emacs24Packages.proofgeneral", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => 'jm57bqj1pcrpgxwxd3vikjvjqscmscw3-ProofGeneral-4.2.drv', out => 'j406z45hbjk2ip6zs6qc9q5k71br0s3q-ProofGeneral-4.2');
