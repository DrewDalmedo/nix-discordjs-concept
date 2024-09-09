{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
      });

      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # Languages you wish to use in development shells can be programmatically enabled: 
                  languages.nix.enable = true;

                  # This will install all the necessary files needed to compile / run code written for
                  # that language. It will also install the industry-standard tooling for that language.
                  # For example, the following would not only install gcc, but also make:
                  #languages.c.enable = true;

                  # See the following links for more details:
                  # Languages           ->  https://devenv.sh/languages/

                  # For the sake of time I chose to use javascript for this project,
                  # but devenv also supports using typescript.
                  languages.javascript = {
                    enable = true;
                    pnpm = {  # pnpm is an implementation of npm with significantly faster performance
                      enable = true; 
                      install.enable = true; # auto-install all npm packages on entering a shell
                    };
                  };

                  # devenv has full dotenv integration, making the inclusion of dotenv in packages.json
                  # unnecessary. However, this integration is disabled for the sake of showing how converting to
                  # devenv may look when writing a configuration for an existing codebase without any rewrites
                  dotenv.enable = false;

                  # Processes and services are primarily used for starting things such as development servers, 
                  # SQL databases, etc. Since this example project is small, the only process here is for starting
                  # the Discord bot.
                  processes = {
                    # when you run 'devenv up', the bot will register commands and start
                    register.exec = "pnpm run register";
                    bot.exec = "node ."; 
                  };

                  # See the following links for more details:
                  # Processes           ->  https://devenv.sh/processes/
                  # Services            ->  https://devenv.sh/services/

                  # See full reference at https://devenv.sh/reference/options/
                }
              ];
            };
          });
      };
  }
