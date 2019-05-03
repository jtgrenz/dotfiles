#!/usr/bin/sh

############################################################
## Install and setup dot files and support files.
#
# This script should only be run once on a new machine
# and does not aim to fully bootstrap a new machine.
############################################################


# Unzip Nerd Fonts to system fonts directory
echo "Installing Nerd Fonts to /Library/Fonts"
unzip ./lib/nerd_fonts.zip -d /Library/Fonts/
echo

# Install homebrew if not installed, otherwise update it.
echo "Checking for homebrew"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew not found. Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew found. Updating homebrew"
    brew update
fi
echo

# Install RCM, Thoughtbot's dotfiles manager.
echo "Checking for Thoughtbot rcm"
brew tap thoughtbot/formulae
which -s rcup
if [[ $? != 0 ]] ; then
    # Install rcm
    echo "Thoughtbot's rcm not found. Installing rcm"
   brew install rcm
else
    echo "Thoughtbot's rcm  found."
fi
echo

# Install Antibody, the zsh plugin manager.
echo "Antibody zsh plugin manager"
antibody -v
if [[ $? != 0 ]] ; then
    # Install rcm
    echo "Antibody not found. Installing rcm"
    brew install getantibody/tap/antibody
else
    echo "Antibody found."
fi
echo

# Symlink the rcrc file manually to initialize rcm
echo "Copying .rcrc file to $HOME"
cp ./rcrc ~/.rcrc
echo

# Install vundle, the VIM plugin manager
echo "Cloning/updating Vundle"
git -C ~/.vim/bundle/Vundle.vim pull || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo

# Finally, run rcup, to symlink dotfiles to home directory.
echo "Linking dotfiles with rcup..."
rcup
echo "Install complete"
