{
  description = "Evan's home manager flake";
  # https://www.chrisportela.com/posts/home-manager-flake/ thank you!

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stable-pkgs.url = "github:nixos/nixpkgs/release-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stable-pkgs, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
    homeConfigurations = {
      evan = home-manager.lib.homeManagerConfiguration {
        # Note: I am sure this could be done better with flake-utils or something
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ((import ./home.nix) stable-pkgs.legacyPackages.x86_64-linux )
        ];
      };
    };
  };
}
