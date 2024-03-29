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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew found. Updating homebrew"
    brew update
fi

echo "Installing apps from Brewfile"
brew bundle install
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
    echo "Thoughtbot's rcm found."
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

echo "Installing jtgrenz/minidev"
mkdir -p ~/src/github.com/jtgrenz
git clone git@github.com:jtgrenz/minidev.git ~/src/github.com/jtgrenz/
echo

# Symlink the rcrc file manually to initialize rcm
echo "Copying .rcrc file to $HOME"
cp ./rcrc ~/.rcrc
echo

# Finally, run rcup, to symlink dotfiles to home directory.
echo "Linking dotfiles with rcup..."

# RCM tools rely on hostname which is not POSIX and does not always behave as expected on MacOS. Manually set
# the Hostname flag to use the $HOSTNAME or $HOST envvar depending which is set.
if [ "$(uname)" = "Darwin" ]; then
    if [ -n "${HOSTNAME}" ]; then
        HOST_TARGET="${HOSTNAME}"
    elif  [ -n "${HOST}" ]; then
        HOST_TARGET="${HOST}"
    fi

    rcup -B "$HOST_TARGET"
else
    rcup
fi

echo
echo "Changing shell to Zsh."
if echo "$SHELL" | grep -q "zsh"; then
    echo "zsh already active. Nothing to do."
else
    chsh -s /bin/zsh
fi


if [[ -f "./host-$HOST/post_install_hook/installer.sh" ]]; then
   echo "Installing host specific configurations"
   sh ./host-$HOST/post_install_hook/installer.sh
fi

echo "Install complete. Open a new shell to reload"
