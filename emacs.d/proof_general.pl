#!/opt/ceh/lib/perl
# -*- mode: perl; -*-

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehInstall;

ceh_nixpkgs_install_for_emacs("emacs24Packages.proofgeneral", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => 'azmnzwn5v943pnhj8h9586b6wmpln4pr-ProofGeneral-4.2.drv', out => 'qkqsgp619vklk3z2mxhyhm0a5wxi5s8y-ProofGeneral-4.2');
