# Used by bin/firefox.

{
  allowUnfree = true;
  packageOverrides = pkgs: rec
    {
      # The nix guys removed the ALSA_PLUGIN_DIRS feature, because THEY were not using it...
      #
      # So instead we copy together alsaLib and alsaPlugins to one big
      # directory and use this as our new alsa-lib dependency
      # in firefox and in flashplugin
      alsaLibWithPlugins = pkgs.callPackage (
        { stdenv, alsaLib, alsaPlugins }: stdenv.mkDerivation {
          name = alsaLib.name;
          alsaLib_path = alsaLib.out;
          alsaPlugins_path = alsaPlugins.out;

          builder = builtins.toFile "builder.sh"
            ''
              source $stdenv/setup
              mkdir -p $out
              cd $out
              cp -a $alsaLib_path/. .     ; chmod -R u+w .
              cp -a $alsaPlugins_path/. . ; chmod -R u+w .
              find -type f | xargs sed -i "s|$(basename $alsaLib_path)|$(basename $(pwd))|g"
            '';
        }
      ) { };

      flashplayer = pkgs.flashplayer.override {
        alsaLib = alsaLibWithPlugins;
      };

      google_talk_plugin = pkgs.google_talk_plugin.override {
        alsaLib = alsaLibWithPlugins;
      };

      firefoxCeh = pkgs.callPackage (
        { stdenv, fetchurl
        , alsaLibWithPlugins
        , atk
        , cairo
        , cups
        , dbus_glib
        , dbus_libs
        , fontconfig
        , freetype
        , gdk_pixbuf
        , glib
        , glibc
        , gst_plugins_base
        , gstreamer
        , gtk2
        , gtk3
        , libX11
        , libXScrnSaver
        , libXcomposite
        , libXdamage
        , libXext
        , libXfixes
        , libXinerama
        , libXrender
        , libXt
        , libcanberra
        , mesa
        , nspr
        , nss
        , pango
        , libheimdal
        , libpulseaudio

        # plugins
        , flashplayer
        , google_talk_plugin
        , linuxPackages
        , mesa_drivers
        }: stdenv.mkDerivation rec {
        name = "firefox-ceh";

        builder = ./firefox-builder.sh;

        src = fetchurl {
          url = "http://download-installer.cdn.mozilla.net/pub/firefox/releases/47.0/linux-x86_64/en-US/firefox-47.0.tar.bz2";
          name = "firefox.tar.bz2";
          sha256 = "1r8mn5wj7ang4fhvaf8cxaaqynz6whyx35nb9xdy6kn17x4wyzvn";
        };

        flashplayer_path = flashplayer;
        google_talk_plugin_path = google_talk_plugin;
        # Unfortunately, for some reason I can not get amd64+java plugin to work...
        # Fortunately on the other hand, I do not have any more usecases for the java plugin...
        # jre_path = oraclejdk8distro true true;
        nvidia_path = linuxPackages.nvidia_x11;
        mesa_path = mesa_drivers;

        libPath = stdenv.lib.makeLibraryPath
            [ stdenv.cc.cc
              alsaLibWithPlugins
              atk
              cairo
              cups
              dbus_glib
              dbus_libs
              fontconfig
              freetype
              gdk_pixbuf
              glib
              glibc
              gst_plugins_base
              gstreamer
              gtk2
              gtk3
              libX11
              libXScrnSaver
              libXcomposite
              libXdamage
              libXext
              libXfixes
              libXinerama
              libXrender
              libXt
              libcanberra
              mesa
              nspr
              nss
              pango
              libheimdal
              libpulseaudio
            ] + ":" + stdenv.lib.makeSearchPath "lib64" [ stdenv.cc.cc ];

        }) { };
    };
}
