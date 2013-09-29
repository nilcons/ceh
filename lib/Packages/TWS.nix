# Used by bin/tws-*

{
  packageOverrides = pkgs:
    {
      tws = pkgs.callPackage (
      	{stdenv, fetchurl, unzip, jre, jrePlugin}: stdenv.mkDerivation rec {
	name = "tws-20130920";

	jts = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/latest/jts.latest.jar";
	  sha256 = "171vgia2v8pm0isvljldzdvy5j652d2kx3s96viw3h2pix26rwx3";
	};

	total = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/total.2012.jar";
	  sha256 = "0a862rzjzdakyv9jvmb1rnmmagbzim57g7361sy2rnqpywpyg9ls";
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
