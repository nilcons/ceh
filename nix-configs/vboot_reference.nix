# Used by bin/cgpt and bin/vbutil_kernel.

{
  packageOverrides = pkgs:
    {
      vboot_reference = pkgs.callPackage (
	{stdenv, fetchgit, pkgconfig, libuuid, openssl, libyaml, lzma}: stdenv.mkDerivation {
	  name = "vboot_reference-R263701B";

	  src = fetchgit {
	    url = "http://git.chromium.org/git/chromiumos/platform/vboot_reference.git";
	    rev = "refs/heads/release-R26-3701.B";
	    sha256 = "89520e6810d0900a94a74ce77ca872a42cd7c2782f38189bdafc23433f02fd91";
	  };

	  buildInputs = [ pkgconfig
                          ( pkgs.lib.overrideDerivation libuuid
                              (args: { configureFlags = args.configureFlags + " --enable-static --enable-shared"; }))
	                  openssl libyaml lzma ];

	  buildPhase = ''
	    make cgpt
	    make `pwd`/build/utility/vbutil_kernel
	  '';

	  installPhase = ''
	    ensureDir $out/bin
	    cp build/cgpt/cgpt $out/bin
	    cp build/utility/vbutil_kernel $out/bin
	  '';
	}) { };
    };
}
