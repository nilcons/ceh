# Used by bin/cgpt and bin/vbutil_kernel.

{
  packageOverrides = pkgs:
    {
      vboot_reference = pkgs.callPackage (
	{stdenv, fetchgit, pkgconfig, libuuid, openssl, libyaml, lzma}: stdenv.mkDerivation {
	  name = "vboot_reference-37.43837.2";

	  src = fetchgit {
	    url = "http://git.chromium.org/git/chromiumos/platform/vboot_reference.git";
	    rev = "refs/changes/37/43837/2";
	    sha256 = "0f2ll8gxr7ws8bz97vlpkmvk29i3imj3d00gf2h5b7v0yb0sq5bw";
	  };

	  buildInputs = [ pkgconfig
                          ( pkgs.lib.overrideDerivation libuuid
                              (args: { configureFlags = args.configureFlags + " --enable-static --enable-shared"; }))
	                  openssl libyaml lzma ];

	  buildPhase = ''
	    make ARCH=x86 cgpt
	    make ARCH=x86 `pwd`/build/utility/vbutil_kernel
	  '';

	  installPhase = ''
	    ensureDir $out/bin
	    cp build/cgpt/cgpt $out/bin
	    cp build/utility/vbutil_kernel $out/bin
	  '';
	}) { };
    };
}
