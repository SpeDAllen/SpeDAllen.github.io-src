{
  description = "blog";
  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/23.11";
     };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.x86_64-linux.default = ( import ./shell.nix { inherit pkgs; });
    };
}
