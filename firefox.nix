{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.albarn = {
    programs.firefox = {
      enable = true;
      languagePacks = ["en-US" "de"];
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://startpage.com";
          "browser.search.defaulteninename" = "Startpage";
          "browser.search.order.1" = "Startpage";
          "extensions.autoDisableScopes" = 0;
          "extensions.enabledScopes" = 15;
        };
        search = {
          force = true;
          default = "Startpage";
          order = ["Startpage" "Google"];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };
            "Startpage" = {
              urls = [{template = "https://startpage.com/sp/search?q={searchTerms}";}];
              iconUpdateURL = "https://startpage.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@sp"];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g";
          };
        };

        # Full list here:
        # https://github.com/nix-community/nur-combined/blob/cac5a762ec7c40a8489e8ba4efa4820ad4b23575/repos/rycee/pkgs/firefox-addons/addons.json
        # extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          vimium
          onepassword-password-manager
          istilldontcareaboutcookies
          firefox-color
          tabcenter-reborn
        ];
      };
    };
  };
}
