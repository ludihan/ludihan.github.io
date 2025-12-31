{
  description = "My personal website";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      supportedSystems = nixpkgs.lib.systems.flakeExposed;
      forAllSystems =
        function: nixpkgs.lib.genAttrs supportedSystems (system: function nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default =
          with pkgs;
          mkShell {
            shellHook = ''
              export PS1="(ludihan.github.io devshell) $PS1"
            '';
            packages = [
              zola
            ];
          };
      });
    };
}
