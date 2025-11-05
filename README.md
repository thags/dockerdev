# Docker dev environment

## Why?

WSL is nice, but the corporation can break it at their whim.
It can take a long time to setup.
With a docker config I can have a more portable dev environment.
Something breaks, no problem. Just rebuild the container.

I have all of my dotfiles on a seperate private repo, so all my customizations can easily be retrieved too.
I would like to create a way to automatically add those into the container though.

## Steps to setup:

1. `docker compose up -d`
2. `docker exec -it dockerdev tmux`
You could use any command other than tmux too. I like my entry to be at tmux though.

### Neovim

Neovim comes pre configured with my config.
Just start it with 'nvim', it should auto install everything needed.
Keep in mind this has my custom stuff, you can customize your own.

### Tmux

This does not work yet.

The idea is:
Pretty much a straight copy from: https://dreamsofcode.io/blog/zen-tmux-configuration
Should already come configured.

After starting tmux press prefix (control + b) and I
This should install everything needed and make tmux look nice.

### dotnet 8 and 9 sdk

Both are installed.
8 is needed for projects at work.
9 is needed for the roslyn and rzls LSPs in nvim



### others

These are installed but just default config:
- git
- github cli
