# Used by bin/firefox.

{
  firefox.jre = true;
  firefox.enableGoogleTalkPlugin = true;
  packageOverrides = pkgs: {
    firefox21Wrapper = (pkgs.wrapFirefox {
      # Elf-hack is a performance optimization for the dynamic linker on startup.
      # It's not clear why it's not compatible with ceh, but compatible with nixos,
      # maybe something is impure in the hack.  Disabling for now.
      browser = pkgs.lib.overrideDerivation
        (pkgs.firefox21Pkgs.override { enableOfficialBranding = true; }).firefox
        (args: { configureFlags = args.configureFlags ++ [ "--disable-elf-hack" ]; });
    });
  };
}
