# Used by bin/firefox.

{
  allowUnfree = true;
  packageOverrides = pkgs:
    {
      firefoxCeh = pkgs.callPackage (
        { stdenv, fetchurl, gtk, pango, perl, python, zip
        , libjpeg, libpng, zlib, dbus, dbus_glib, xlibs
        , freetype, fontconfig, alsaLib, alsaPlugins, nspr
        , nss, libnotify, mesa, sqlite
        , hunspell, libevent, libstartup_notification, libvpx
        , cairo, glib, atk, gdk_pixbuf, linuxPackages, mesa_drivers
        , flashplayer, google_talk_plugin, oraclejdk8distro }: stdenv.mkDerivation rec {
        name = "firefox-ceh";

        builder = ./firefox-builder.sh;

        src = fetchurl {
          url = "https://download.mozilla.org/?product=firefox-34.0.5-SSL&os=linux64&lang=en-US";
          name = "firefox.tar.bz2";
          sha256 = "0dwnkglpw94amzdxxg7wgdk7gz41z052h5bx7z8ngvvcjf9h9jqy";
        };

        flashplayer_path = flashplayer;
        google_talk_plugin_path = google_talk_plugin;
        # Unfortunately, for some reason I can not get amd64+java plugin to work...
        # Fortunately on the other hand, I do not have any more usecases for the java plugin...
        # jre_path = oraclejdk8distro true true;
        alsa_path = alsaPlugins;
        nvidia_path = linuxPackages.nvidia_x11;
        mesa_path = mesa_drivers;

        libPath = stdenv.lib.makeLibraryPath
          [ stdenv.gcc.gcc libpng gtk libjpeg zlib
            dbus dbus_glib pango freetype fontconfig xlibs.libXi
            xlibs.libX11 xlibs.libXrender xlibs.libXft xlibs.libXt
            xlibs.libXfixes xlibs.libXdamage xlibs.libXcomposite
            alsaLib alsaPlugins nspr nss libnotify xlibs.pixman mesa
            xlibs.libXScrnSaver xlibs.scrnsaverproto stdenv.glibc
            xlibs.libXext xlibs.xextproto sqlite
            hunspell libevent libstartup_notification libvpx
            cairo glib atk gdk_pixbuf linuxPackages.nvidia_x11
            mesa_drivers
            ];
        }) { };
    };
}
