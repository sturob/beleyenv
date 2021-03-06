#!/bin/bash
set -e 

sudo apt-get update
sudo apt-get install git-crypt

./devScripts/install-commit-hook.sh

if [[ "$(pwd)" != "$HOME/.beleyenv/beleyenv" ]]; then
	mkdir -p ~/.beleyenv

	echo "Moving your git repo to the .beleyenv folder"
	mv ../beleyenv ~/.beleyenv/
fi


read -rsp 'git-crypt secret key:' secretKey

# Inspired by
# https://unix.stackexchange.com/questions/352569/converting-from-binary-to-hex-and-back
echo "$secretKey" | sed 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI' \
	| xargs -I {} printf {} > ~/.beleyenv/secretKey 

git-crypt unlock ~/.beleyenv/secretKey