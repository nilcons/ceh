# Used by bin/tws-*

{
  packageOverrides = pkgs:
    {
      tws = pkgs.callPackage (
        {stdenv, fetchurl, unzip}: stdenv.mkDerivation rec {
        name = "tws-20141210";

        jts = fetchurl {
          url = "http://download2.interactivebrokers.com/java/classes/latest/jts.latest.jar";
          sha1 = "eb2e34fd819dfc64adbaa495a52c20ad0906f06b";
        };

        total = fetchurl {
          url = "http://download2.interactivebrokers.com/java/classes/total.2012.jar";
          sha1 = "348755c2f21c32f93ce423527c6255c813650fb6";
        };

        buildInputs = [ unzip ];

        unpackPhase = ''
          mkdir -p $out/share/tws-jars
          cp $jts $out/share/tws-jars/jts.jar
          cp $total $out/share/tws-jars/total.jar
        '';

        installPhase = ''
          mkdir -p $out/bin
          cat >$out/bin/tws-ui <<'EOF'
#!/bin/sh

export TZ=America/New_York
exec /opt/ceh/bin/java -cp ''${CEH_TWS_CLASSPATH:+$CEH_TWS_CLASSPATH:}${jts}:${total} -Xmx2000m \
  -XX:MaxPermSize=512m ''${CEH_TWS_UI_MAINCLASS:-jclient.LoginFrame} /opt/ceh/home/Jts
EOF
          chmod a+x $out/bin/tws-ui
          cat >$out/bin/tws-api <<'EOF'
#!/bin/sh

export TZ=America/New_York
exec /opt/ceh/bin/java -cp ''${CEH_TWS_CLASSPATH:+$CEH_TWS_CLASSPATH:}${jts}:${total} -Xmx512m \
  ''${CEH_TWS_API_MAINCLASS:-ibgateway.GWClient} /opt/ceh/home/Jts
EOF
          chmod a+x $out/bin/tws-api
          cat >$out/bin/tws-javac <<'EOF'
#!/bin/sh

exec /opt/ceh/bin/javac -cp ''${CEH_TWS_CLASSPATH:+$CEH_TWS_CLASSPATH:}${jts}:${total} "$@"
EOF
          chmod a+x $out/bin/tws-javac
        '';

        }) { };
    };
}
