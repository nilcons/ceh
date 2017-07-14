# Used by bin/teamspeak.

{
  allowUnfree = true;
  packageOverrides = pkgs: rec
    {
      # The nix guys removed the ALSA_PLUGIN_DIRS feature, because THEY were not using it...
      #
      # So instead we copy together alsaLib and alsaPlugins to one big
      # directory and use this as our new alsa-lib dependency in teamspeak.
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

      teamspeak_client = pkgs.teamspeak_client.override {
        alsaLib = alsaLibWithPlugins;
      };

      teamspeakCeh = pkgs.callPackage (
        { stdenv
        , teamspeak_client
        , mesa_drivers
        }: stdenv.mkDerivation rec {
        name = "teamspeak-ceh";

        builder = ./teamspeak-builder.sh;

        ts_path = teamspeak_client;
        mesa_path = mesa_drivers;
        }) { };
    };
}
