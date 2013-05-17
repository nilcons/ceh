#!/opt/ceh/lib/perl
# -*- mode: perl; -*-

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehInstall;

ceh_nixpkgs_install_for_emacs("emacs24Packages.proofgeneral", nixpkgs_version => 'b0f52e08dcf8dc30d58cde17cf836350b393dd0a', derivation => 'jn3z6h8n2wjwppq2zlx211q7sz3zysyq-ProofGeneral-4.2.drv', out => '177qh5d1z68xglrxcvi8nqxy96a7sf9j-ProofGeneral-4.2');
