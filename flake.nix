{
  description = "Reusable OpenTofu module for standardized GitHub repository management";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          tofu = pkgs.opentofu.withPlugins (plugins: [ plugins.integrations_github ]);
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              actionlint
              pinact
              renovate
              tflint
              tofu
            ];
          };
        }
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
