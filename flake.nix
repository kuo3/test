{
  description = "test";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nix-envs,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        packageName = "test";
      in {
        packages = {
          ${packageName} = pkgs.hello;
            # (ref:haskell-package-def)
          default = self.packages.${system}.${packageName};
        };

        formatter = nix-envs.${system}.nixpkgs-fmt;
        devShells = {
        };

        hydraJobs = {
          inherit
            (self)
            packages
            ;
        };
      }
    );
}
