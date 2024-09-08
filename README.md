# nix-discordjs-concept

Proof of concept for a plug-and-play Discord bot using Nix flakes / devenv for fully reproducible development and production environments.

## Background and Rationale

Automation infrastructure is commonly tied to "mutable" server infrastructure, which is difficult to reproduce from instance to instance.
The industry standard solution to this problem has been to use Docker containers, which codifies replicable environments in Dockerfiles. However, 
Docker, Podman, and all other OCI-compatible runtimes have two major flaws:

1. High overhead due to virtualization
    - OCI container runtimes are significantly lighter than full operating system virtualization tools such as Oracle VirtualBox and VMWare Workstation, but still come at a significant performance cost.
2. Inconsistent reproduction of binaries and environments
    - Dockerfiles and Docker containers are replicable, meaning that they follow a specific set of instructions to achieve a similar production of an environment. 
    However, any environment that is created from a Dockerfile does not have a 1:1 correspondance to any other given environment: in other words, it is *impossible* to
    guarantee an exact binary reproduction of a given piece of software built from within a Docker container. 
    - Any steps inside of a Dockerfile which fetch software updates lead to decreases in the reproducibility of binaries. This may lead to inconsistency between deployments, potentially leading to unpredictable deployment outcomes.

A more optimal solution, then, would need to accomplish the following:

1. Eliminate the need for virtualization without compromising deployment stability
2. Build exact 1:1 reproductions of a binary or of a development / production environment

The Nix programming language and package manager accomplishes both of these goals, allowing for faster and safer development and deployment.

### What is Nix?

[Nix](https://nixos.org) is a DSL that follows the functional programming language paradigm. It allows for easy reproductions of environments and applications.

### What is NixOS?

[NixOS](https://nixos.org) is a GNU/Linux operating system distribution with the Nix binaries pre-installed. 

## Installing Nix
Please see [installing nix](INSTALLING-NIX.md) for details.

## Setting up the bot

This example project uses [dotenv](https://www.npmjs.com/package/dotenv) as a way to store and access sensitive information such as Discord bot tokens.

To run your own Discord bot, you'll need the following information:

- Your bot's `token`
- Your bot's `application ID`
- The `guild ID` (Discord server ID) you want to register the bot's commands for

Create a .env file and add the following fields:

```
BOT_TOKEN=(your bot token)
CLIENT_ID=(your bot's application id)
GUILD_ID=(your discord server's ID)
```

Once you have created the .env file and entered your bot and server details, you're ready to run the bot.

## Running the bot

There are two methods for running the bot that are included in this example project:

1. Using Nix flakes
2. Using devenv

Nix flakes are accessible to everyone who installs Nix. However, the syntax of pure Nix flakes is harder to initially understand.

[devenv](https://devenv.sh/) accomplishes what Nix flakes can do all while having a much simpler and more concise syntax. However, devenv
is not installed by default on fresh Nix / NixOS installations.

Both methods have been included in this example project to illustrate what each would look like when implemented.

### Using Nix flakes

### Using devenv

Before continuing, make sure you have devenv installed. If you don't, you can create a temporary shell with devenv installed by running:

```
nix-shell -p devenv
```

#### Entering a development shell 

To enter a development shell with all the necessary dependencies for the project pre-installed, simply run the following:

```
devenv shell
```

#### Registering commands

To register commands while in a devenv shell, simply run the following `pnpm` command:

```
pnpm run register
```

#### Running while in a devenv shell

To run the bot while in a devenv shell, simply run the project as you normally would with any other discord.js bot:

```
node .
```

#### Running the bot as a service

To run the bot as a foreground service WITHOUT entering a development shell, simply run:

```
devenv up
```

To kill the process, press F10.

You can also run the service as a daemon. To do this, run:

```
devenv up -d
```

This will start the process in the background.

To kill the background process, run:

```
devenv processes stop
```

## References
[Nix / NixOS](https://nixos.org/)
[Nix Flakes](https://nixos.wiki/wiki/Flakes)
[devenv](https://devenv.sh/)
[The Official discord.js Guide](https://discordjs.guide)
