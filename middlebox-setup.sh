#! /usr/bin/env bash

echo "MiddleBox Setup Script"

echo
echo "===================================="
echo "Installation Script v1.0.0    "
echo "For support contact fheemeyer@ethz.ch"
echo "===================================="
echo 
echo

if ls ~/.ssh/*.pub 2>/dev/null; then
	KEY_FILE=$(ls ~/.ssh/*.pub | head -1)
	echo "public key found in ${KEY_FILE}"
    echo
	echo "Make sure to copy the following and add the key to your GitHub account."
	echo "See https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account"
	echo
	cat ${KEY_FILE}
	echo
	read -p "Press any key to continue"
else
	read -p "No public SSH key was found in ~/.ssh. Should I create one for you? [y]n " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Nn]$ ]]; then
		break
	else
		read -p "Enter your email address: " email
		ssh-keygen -t ed25519 -C "$email" 
		echo "Make sure to copy the following and add the key to your GitHub account."
		echo "See https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account"
		echo
		cat ~/.ssh/id_ed25519.pub

		echo
		read -p "Press any key to continue"
	fi
fi

echo "Starting ssh-agent"
eval `ssh-agent`
echo "Enter the password that you use in your SSH key"
ssh-add
