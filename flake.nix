{
  description = "A development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {

    devShell = forAllSystems (system:
      with nixpkgsFor.${system}; mkShell {
        buildInputs = [
          bun
        ];

        shellHook = ''
          echo "Welcome to your development environment. This shell has bun."
        '';
      }
    );
  };
}
