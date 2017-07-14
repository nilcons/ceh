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
        , libxcb
        , libXdamage
        , libXext
        , libXfixes
        , libXinerama
        , libXrender
        , libXt
        , libcanberra_gtk2
        , mesa
        , nspr
        , nss
        , pango
        , libheimdal
        , libpulseaudio

        # plugins
        , flashplayer
        , mesa_drivers
        }: stdenv.mkDerivation rec {
        name = "firefox-ceh";

        builder = ./firefox-builder.sh;

        src = fetchurl {
          url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/54.0.1/linux-x86_64/en-US/firefox-54.0.1.tar.bz2";
          name = "firefox.tar.bz2";
          sha256 = "1frns7imxmx4sl8nj9g97zciznmzy7s3b2jdm0fjwyz386w5zrdf";
        };

        flashplayer_path = flashplayer;
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
              libxcb
              libXdamage
              libXext
              libXfixes
              libXinerama
              libXrender
              libXt
              libcanberra_gtk2
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
