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
      defaultSystems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      forAllSystems =
        function: nixpkgs.lib.genAttrs defaultSystems (system: function nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default =
          with pkgs;
          mkShell {
            shellHook = ''
              export PS1="(ludihan.github.io) $PS1"
            '';
            packages = [
              zola
            ];
          };
      });
    };
}
