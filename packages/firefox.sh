. /opt/ceh/scripts/common-functions.sh

# This is a 32-bit FF install (working on both amd64 and i686) with
# all the 3 required plugins:
#  - google talk,
#  - java,
#  - flash,
# please make sure to remove all the conflicting plugins from your
# system (~/.mozilla/firefox/plugins, /usr/lib/mozilla, etc.).
#
# To make sure everything is OK, use all 3 plugins while running
# firefox from a terminal and watch stderr.
#
# Do not ever mix 64-bit plugins with this 32-bit firefox!

# TODO(errge): maybe general alsa support in common-functions.sh?
# This is needed for cases when the user has a ~/.asoundrc that uses
# modules (e.g. redirects everything through pulseaudio).
ceh_nixpkgs_install alsaPlugins 1.0pre23438_a72c9d7 \
    gqqmq4c5p3ky30d66fyfcwlcrq3rrify-alsa-plugins-1.0.26.drv \
    zz0mm65zr6ji1d542mr0nx68dn5gsmnk-alsa-plugins-1.0.26
export ALSA_PLUGIN_DIRS=$ceh_nix_install_root/lib/alsa-lib

# To enable google talk plugin and jre plugin.
export NIXPKGS_CONFIG=/opt/ceh/packages/firefox.nix
ceh_nixpkgs_install firefox18Wrapper 1.0pre23438_a72c9d7 \
    zlsqzxhsflgfmv7mzymb47hnq3py4hhq-firefox-18.0-with-plugins.drv \
    bgcsk212dwnqqz18qhvc3j2d3blh69ss-firefox-18.0-with-plugins
