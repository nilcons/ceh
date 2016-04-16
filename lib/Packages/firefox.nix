# Used by bin/firefox.

{
  allowUnfree = true;
  packageOverrides = pkgs:
    {
      firefoxCeh = pkgs.callPackage (
        { stdenv, fetchurl, gtk, pango, perl, python, zip
        , libjpeg, libpng, zlib, dbus_libs, dbus_glib, xlibs
        , freetype, fontconfig, alsaLib, alsaPlugins, nspr
        , nss, libnotify, mesa, sqlite, cups, glibc
        , hunspell, libevent, libstartup_notification, libvpx
        , gst_plugins_base, gstreamer
        , cairo, glib, atk, gdk_pixbuf, linuxPackages, mesa_drivers
        , libcanberra, libheimdal, libpulseaudio
        , flashplayer, google_talk_plugin
        # , oraclejdk8distro
        }: stdenv.mkDerivation rec {
        name = "firefox-ceh";

        builder = ./firefox-builder.sh;

        src = fetchurl {
          url = "http://download-installer.cdn.mozilla.net/pub/firefox/releases/45.0.2/linux-x86_64/en-US/firefox-45.0.2.tar.bz2";
          name = "firefox.tar.bz2";
          sha256 = "1if684ga4pgfpkv1fwnaa5hbp5h1qshqd4a4q7fri5vyn0zfns20";
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
          [ stdenv.cc.cc libpng gtk libjpeg zlib
            dbus_libs dbus_glib pango freetype fontconfig xlibs.libXi
            xlibs.libX11 xlibs.libXrender xlibs.libXft xlibs.libXt
            xlibs.libXfixes xlibs.libXdamage xlibs.libXcomposite
            xlibs.libXinerama gst_plugins_base gstreamer
            alsaLib alsaPlugins nspr nss libnotify xlibs.pixman mesa
            xlibs.libXScrnSaver xlibs.scrnsaverproto glibc
            xlibs.libXext xlibs.xextproto sqlite cups
            hunspell libevent libstartup_notification libvpx
            cairo glib atk gdk_pixbuf linuxPackages.nvidia_x11
            mesa_drivers libcanberra libheimdal libpulseaudio
            ] + ":" + stdenv.lib.makeSearchPath "lib64" [ stdenv.cc.cc ];
        }) { };
    };
}
