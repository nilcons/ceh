#!/opt/ceh/lib/perl
# -*- mode: perl; -*-

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehInstall;

ceh_nixpkgs_install_for_emacs("emacs24Packages.proofgeneral", nixpkgs_version => '168115f610835654c1ed85a1bcf089f0919c9566', derivation => 'rh46vp19gchq8v9qgmmx6nnrhpamgn8p-ProofGeneral-4.2.drv', out => 'ayxydqpcpfkq641xz4r097lg9f4gmgf4-ProofGeneral-4.2');
