{inputs, ...}: let
  utils = rec {
    # Converts a list of strings to paths, using `base` as the path prefix
    pathify = base: names: map (name: base + "/${name}") names;

    # List all *.nix files in a directory (as strings)
    listNixFileNames = path: let
      dirContents = builtins.readDir path;
    in
      builtins.filter (name: builtins.match ".*\\.nix$" name != null) (builtins.attrNames dirContents);

    # List all *.nix files in a directory (as paths)
    listNixFiles = path: pathify path (listNixFileNames path);

    # List all directories in a directory (as paths)
    listSubdirs = path: let
      dirContents = builtins.readDir path;
    in
      pathify path (builtins.filter (name: dirContents.${name} == "directory") (builtins.attrNames dirContents));

    # List all directories in a directory that can be imported (i.e. that have a default.nix in them)
    listImportableSubdirs = path: let
      subdirs = listSubdirs path;

      # All dirs with a `default.nix`
      defaultDirs = builtins.filter (subpath: builtins.pathExists (subpath + "/default.nix")) subdirs;

      # All dirs with a file of their own name (i.e. a `test.nix` in `features/asdf/test`) - nicer to work with in editor
      # Only applies if `default.nix` does not exist, in order to prevent unexpected behavior
      namedDirs = builtins.filter (subpath: let
        name = builtins.baseNameOf subpath;
      in
        builtins.pathExists (subpath + "/${name}.nix") && !builtins.pathExists (subpath + "/default.nix"))
      subdirs;
    in
      defaultDirs
      ++ map (dir: dir + "/${builtins.baseNameOf dir}.nix") namedDirs;

    # Import everything in a directory; that is: all *.nix files directly contained, as well as importable dirs
    # (a dir is importable if it contains a `default.nix`)
    importDir = path: (listNixFiles path) ++ (listImportableSubdirs path);

    # Imports a feature
    importFeature = name: importDir (./features + "/${name}");
  };
in {
  mkSystem = {
    modules ? [],
    extraDirs ? [],
    system ? "x86_64-linux",
    features ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      system = system;
      extraArgs = {inherit inputs;};
      modules =
        [
          inputs.catppuccin.nixosModules.catppuccin
          inputs.spicetify-nix.nixosModules.default
          {nixpkgs.overlays = [inputs.nur.overlay];}
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.albarn.imports = [inputs.catppuccin.homeManagerModules.catppuccin];
          }
        ]
        ++ modules
        ++ builtins.concatMap utils.importFeature (features ++ ["common"])
        ++ builtins.concatMap utils.importDir extraDirs;
    };
}
