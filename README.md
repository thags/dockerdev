# Docker dev environment

## Why?

WSL is nice, but the corporation can break it at their whim.
It can take a long time to setup.
With a docker config I can have a more portable dev environment.
Something breaks, no problem. Just rebuild the container.

I have all of my dotfiles on a seperate private repo, so all my customizations can easily be retrieved too.
I would like to create a way to automatically add those into the container though.

## Steps to setup:

1. Set variables to your desired in the .env file
2. `docker compose up -d`

Then connect with either ssh, or through docker exec.
I recommend ssh as docker exec has issues with displaying colors.

- `ssh -p 2222 dev@localhost`
    - account name is `dev`
    - password is configured through the .env file
- `docker exec -it dockerdev tmux`

That is it.
You now have an account named `dev` with the password configured in the .env file.

## Automated setup

### Dockerfile

Pacman handles the installation of all the pre-installed applications and requirements.
SSH is configured.
`dev` account created.
`dev` account given permission 

### setup.sh

This file is copied over during the build and is automatically run.
Mostly for setup that needs to happen at runtime. 
Some of the items probably could be moved to the Dockerfile, but it works either way.
I kind of like having the .sh file as it is more portable, it could be ran on any linux environment to get it configured the same.
I may actually move many of the items from the Dockerfile to the setup.sh.

Use docker just as an easy way to get a linux container started then use setup.sh to configure it.
That way the same config could be applied even outside of docker.


This only runs once.
It creates the file: `/home/dev/.dockerdev_setup_complete`
If that file exists then it will not run.

### SSH

If you have recreated the container since the last ssh connection you may need to delete the ssh keys on the host before it will allow you to connect.
On the host run:
`ssh-keygen -R [localhost]:2222`

SSH is installed and turned on by default.
The password will be what you set in the .env file for `DEV_PASSWORD` with account name `dev`.

### Neovim

Neovim comes pre configured with my config.
Just start it with 'nvim', it should auto install everything needed.
Keep in mind this has my custom stuff, you can customize your own.

### Tmux

This is partially working. 
It does configure the keybindings, but the theme is not loading.

The idea is:
Pretty much a straight copy from: https://dreamsofcode.io/blog/zen-tmux-configuration

### dotnet 8 and 9 sdk

Both are installed.
8 is needed for projects at work.
9 is needed for the roslyn and rzls LSPs in nvim


### git

Since files are being shared from the host, which could be windows to the container some git configuration was needed.
We set everything to a safe directory for git, and turn autocrlf to input.



## Future ideas

- Pull from my personal dotfiles repo and use stow to apply it, just like I manually would.
    - requires making my dotfiles repo public.
- Add optional environment variable for github ssh key
- 