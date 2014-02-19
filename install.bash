#!/usr/bin/env bash

function exit_with_message() {
  echo $1
  exit 1
}

# First, retrieve the zip file from Github.
# It will use wget or curl (whichever is defined.)
curl_available=$(command -v curl)
wget_available=$(command -v wget)
unzip_available=$(command -v unzip)

dotfiles_zip=/tmp/dotfiles-master.zip
dotfiles_dir=/tmp/dotfiles-master
dotfiles_url=https://github.com/fnando/dotfiles/archive/master.zip
user_file="/tmp/user_${RANDOM}.sh"

if [[ "$unzip_available" = "" ]]; then
  exit_with_message "#=> Make sure you have the unzip command available"
fi

echo "#=> Downloading $dotfiles_url to $dotfiles_zip"

if [[ "$curl_available" != "" ]]; then
  curl -Ls -o $dotfiles_zip $dotfiles_url
elif [[ "$wget_available" != "" ]]; then
  wget -q -O $dotfiles_zip $dotfiles_url
else
  exit_with_message "#=> Please make sure curl or wget is installed"
fi

[ -f "$dotfiles_zip" ] || exit_with_message "#=> ERROR: Couldn't download ${dotfiles_url}."

# Now, unzip the directory and
rm -rf $dotfiles_dir
unzip -q $dotfiles_zip -d /tmp

# Make a backup copy of an existing .bash/user.sh
if [[ -f "${HOME}/.bash/user.sh" ]]; then
  echo "#=> Backing up ${HOME}/.bash/user.sh"
  cp "${HOME}/.bash/user.sh" $user_file
fi

# Copy files
find ${dotfiles_dir}/files -maxdepth 1 -mindepth 1 -exec cp -R "{}" $HOME/ \;

# Restore .bash/user.sh backup copy
if [[ -f $user_file ]]; then
  cp $user_file $HOME/.bash/user.sh
  echo "#=> Restoring ${HOME}/.bash/user.sh"
fi

# Source the initalization file.
. $HOME/.bash/init.sh

echo "#=> Done!"