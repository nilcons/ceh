# Used by bin/tws-*

{
  packageOverrides = pkgs:
    {
      tws = pkgs.callPackage (
      	{stdenv, fetchurl, unzip, jre, jrePlugin}: stdenv.mkDerivation rec {
	name = "tws-20131020";

	jts = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/latest/jts.latest.jar";
	  sha256 = "174cj9vgr5v31i85b7l7fh1njlxqgznaf7h36qlhh3mij1an3wrg";
	};

	total = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/total.2012.jar";
	  sha256 = "17fpxwjvy6q5s8dij632qadc6r0c8i6gkv09mccjmdppbzz7a4qb";
	};

	jre = pkgs.jre;
	sunjre = pkgs.jrePlugin;

	buildInputs = [ unzip jre sunjre ];

	unpackPhase = ''
	  ensureDir $out/share/tws-jars
	  cp $jts $out/share/tws-jars/jts.jar
	  cp $total $out/share/tws-jars/total.jar
	'';

	installPhase = ''
	  ensureDir $out/bin
	  cat >$out/bin/tws-ui <<EOF
#!/bin/sh

export TZ=America/New_York
if [ "\$CEH_TWSSUN" = "1" ]; then
  exec $sunjre/bin/java -cp $out/share/tws-jars/total.jar:$out/share/tws-jars/jts.jar -Xmx2000m -XX:MaxPermSize=512m jclient.LoginFrame /opt/ceh/home/Jts
else
  exec $jre/bin/java -cp $out/share/tws-jars/total.jar:$out/share/tws-jars/jts.jar -Xmx2000m -XX:MaxPermSize=512m jclient.LoginFrame /opt/ceh/home/Jts
fi
EOF
	  chmod a+x $out/bin/tws-ui
	  cat >$out/bin/tws-api <<EOF
#!/bin/sh

export TZ=America/New_York
if [ "\$CEH_TWSSUN" = "1" ]; then
  exec $sunjre/bin/java -cp $out/share/tws-jars/total.jar:$out/share/tws-jars/jts.jar -Xmx512m ibgateway.GWClient /opt/ceh/home/Jts
else
  exec $jre/bin/java -cp $out/share/tws-jars/total.jar:$out/share/tws-jars/jts.jar -Xmx512m ibgateway.GWClient /opt/ceh/home/Jts
fi
EOF
	  chmod a+x $out/bin/tws-api
	'';

	}) { };
    };
}
