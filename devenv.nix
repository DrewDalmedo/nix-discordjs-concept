{ pkgs, lib, config, inputs, ... }:

{
  # This devenv.nix file doesn't include many features of devenv. For a full list of features,
  # see https://devenv.sh/

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
    bot.exec = "node ."; # when you run 'devenv up', the bot will start
  };

  # See the following links for more details:
  # Processes           ->  https://devenv.sh/processes/
  # Services            ->  https://devenv.sh/services/

  # See full reference at https://devenv.sh/reference/options/
}
