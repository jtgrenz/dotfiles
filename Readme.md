
# Dotfiles

Everyone needs to manage and keep their dot files all tidy and orderly. Even better if you can share them across different machines or share them with other users.

This repo uses [ThoughtBot's RCM](https://github.com/thoughtbot/rcm) dot file manager to link different dot files together into the home directory.

## Quick start

clone the repo to your home directory and run

```sh
cd ~/dotfiles && sh install.sh
```

and voila!

## How it works

The `install.sh` script copies `rcrc` to you home folder, installs `rcm` using homebrew (and installs homebrew if necessary) and then runs `rcup`. `rcup` is the rcm command that links everything from the repo into your home directory based on the settings listed in `rcrc`.

The repo is broken up into 2 main categories of folders, `tag-*` and `host-*`. The `rcrc` file specifies a `TAG` and a `HOSTNAME` variable. Every tag listed in the `rcrc` file will be symlinked to the home directory, but if not listed, it will be ignored. This allows you to pick and choose what files you want to include in the setup. The `host-*` directories work similarly and will be copied over if the hostname of the machine matches `*` portion of the directory name. You can force the host to be copied over by running `rcup -B HOSTNAME` Ie `rcup -B Magi06.local` which is the name of my current machine. If a file is shared between this bare repo, `tag-*`, or `host-*`, then it will be overridden by the next file up in the chain. Host trumps Tag, Tag trumps bare files in the repo.

Anytime you add or remove files to ~/.dotfiles, you should run `rcup` to make sure everything is linked correctly.

## Zsh

All of the z-shell configuration is included in `tag-zsh`. `rcup` will link `.zshrc` and `.zshrc.d` to the home folder. Everything is broken down into smaller modules that can be extended using other `tag-*` and `host-*`.

`zshrc` calls `zshrc.d/init.zsh` which sets some sane default settings and aliases that should be universally useful. It then loads plugins from [Antibody](https://getantibody.github.io), a zsh plugin manager.

It then loads all `*.zsh` inside `.zshrc.d/functions`, `.zshrc.d/plugins` and `.zshrc.d/host`.

### Prompt
The shell prompt uses [Powerlevel9k](https://github.com/bhilburn/powerlevel9k) and NerdFonts to render useful information in the shell. You can read the readme on the repo for how to configure it. The confguration file is `.zshrc.d/initializers/powerlevel9k_config.zsh`.

The default configuration I have looks like this:

![](https://screenshot.click/24-12-17-23-08-1ovla-7ej4t.jpg)


### Overriding settings non-destructively

Because `rcm` is able to override files that share a name based on the precedence order host > tag > repo, you can override a file by replicating the file structure in a tag or host folder.

For example, say you want to customize the prompt per machine. You can create a folder called `host-your-hostname/zshrc.d/initializers/powerlevel9k_config.zsh` and run `rcup`. Now your shell will load that file instead of `tag-zsh/zshrc.d/initializers/powerlevel9k_config.zsh`

If you want to add new files, the same thing applies. Anything added to `host-your-hostname/zshrc.d/host/host-name` will be added last to your zshrc.

Adding new antibody plugins is equally as easy. Just override `tag-zsh/zshrc.d/antibody/plugins.txt` with `host-your-hostname/zshrc.d/antibody/plugins.txt`

### Antibody

Rather than having antibody try and find all the files each time you start the shell, it loads them from a static file. Anytime you add a new plugin to `antibody/plugins.txt`, run `antibody static` which will update the static source file for faster load times.


