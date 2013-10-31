package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("vboot_reference", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'lh6mp56f8b8h5nk71f6g28x080dhkg90-vboot_reference-20130507.drv', out => 'qb4m1y4kzs44yjrn7crywyq097vag8cb-vboot_reference-20130507');

1;
