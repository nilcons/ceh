# Used by bin/tws-*

{
  packageOverrides = pkgs:
    {
      tws = pkgs.callPackage (
      	{stdenv, fetchurl, unzip, jre, jrePlugin}: stdenv.mkDerivation rec {
	name = "tws-20130204";

	jts = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/latest/jts.latest.jar";
	  sha1 = "8713df0fc3cc68de22294c2cb0aacbb74f3d66c8";
	};

	total = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/total.2012.jar";
	  sha1 = "348755c2f21c32f93ce423527c6255c813650fb6";
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
