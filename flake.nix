{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    # firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    # firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    ...
  }: {
    nixosConfigurations.albarn-t490s = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      extraArgs = {inherit inputs;};
      modules = [
        catppuccin.nixosModules.catppuccin
        inputs.spicetify-nix.nixosModules.default
        {nixpkgs.overlays = [inputs.nur.overlay];}
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.albarn.imports = [catppuccin.homeManagerModules.catppuccin];
        }
      ];
    };
  };
}
