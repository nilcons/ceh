# Used by bin/tws-*

{
  packageOverrides = pkgs:
    {
      tws = pkgs.callPackage (
      	{stdenv, fetchurl, unzip, jre}: stdenv.mkDerivation rec {
	name = "tws-937";

	jts = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/jts.937.jar";
	  sha256 = "1w0ln9micg1vg0p22fhnmb8yknqdi1nqxd5sz7pm1g69aag42k9x";
	};

	total = fetchurl {
	  url = "http://download2.interactivebrokers.com/java/classes/total.2012.jar";
	  sha256 = "0a862rzjzdakyv9jvmb1rnmmagbzim57g7361sy2rnqpywpyg9ls";
	};

	jre = pkgs.jre;
	jre64 = (pkgs.forceSystem "x86_64-linux").jre;

	buildInputs = [ unzip jre jre64 ];

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
# try with the 64-bit jre first, it's faster...
if $jre64/bin/java -version >/dev/null 2>/dev/null; then
  exec $jre64/bin/java -cp $out/share/tws-jars/total.jar:$out/share/tws-jars/jts.jar -Xmx2000m -XX:MaxPermSize=512m jclient.LoginFrame /opt/ceh/home/Jts
else
  exec $jre/bin/java -cp $out/share/tws-jars/total.jar:$out/share/tws-jars/jts.jar -Xmx2000m -XX:MaxPermSize=512m jclient.LoginFrame /opt/ceh/home/Jts
fi
EOF
	  chmod a+x $out/bin/tws-ui
	'';

	}) { };
    };
}
