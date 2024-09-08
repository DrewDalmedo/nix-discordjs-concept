{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system: {
      let 
        pkgs = import nixpkgs { inherit system; };
      in 
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
            pkgs.pnpm
          ];
        };

        packages.bot = pkgs.stdenv.mkDerivation {
          pname = "nix-discordjs-concept";
          version = "1.0.0";
          src = ./.;
          buildInputs = [ 
            pkgs.nodejs
            pkgs.pnpm
          ];

          buildPhase = ''
            pnpm install
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp -r src $out/bin/
            cp -r node_modules $out/bin/
            echo "#!/usr/bin/env node" > $out/bin/run-bot
            echo "node ." >> $out/bin/run-bot
            chmod +x $out/bin/run-bot
          '';
        };

        # run the bot in foreground
        apps.run-bot = {
          type = "app";
          program = "${self.packages.${system}.bot}/bin/run-bot";
        };
      }
    });
}
