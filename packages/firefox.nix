# Used by bin/firefox.

{
  firefox.jre = true;
  firefox.enableGoogleTalkPlugin = true;
  packageOverrides = pkgs: {
    firefox20Pkgs = pkgs.firefox20Pkgs.override {
      enableOfficialBranding = true;
    };
  };
}
