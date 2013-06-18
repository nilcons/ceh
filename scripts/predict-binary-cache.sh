#!/bin/bash -e

# Gathers the derivation paths for currently not installed packages
# using install-world and then asks the nix-store for realising all of
# them.
#
# Useful after updating the baseline (but before installing any
# packages) to get a prediction of how well the new baseline's binary
# cache is populated.

export CEH_GATHER_DERIVATIONS_ONLY=1
. /opt/ceh/scripts/install-world.sh
DERIVATIONS=`grep ^CEH_GATHER_DERIVATIONS_ONLY: $CEH_INSTALLWORLDDIR/* | cut -d\  -f2`
echo -e "Gathered derivations:\n$DERIVATIONS"
echo "Running nix-store:"
nix-store --dry-run -r $DERIVATIONS
