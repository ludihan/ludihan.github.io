{
  description = "My personal website";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = with nixpkgs; lib.genAttrs lib.systems.flakeExposed;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              zola
            ];
            shellHook = ''
              export PS1="(ludihan.github.io) $PS1"
            '';
          };
        }
      );

    };
}
