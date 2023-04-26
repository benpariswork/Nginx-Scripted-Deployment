#!/bin/bash

### This script was written with the assistance of ChatGPT. See https://openai.com/blog/chatgpt for more.
### This script is based on the documentation for installing Nginx Open Source found here: https://nginx.org/en/linux_packages.html
### It should be noted that the prerequisite gpgv is a replacement for an outdated package from the documnetation, 'gnupg2'.

# Install prerequisites

sudo apt install -y curl gpgv ca-certificates lsb-release ubuntu-keyring

# Import the official nginx signing key
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

# Get the key fingerprint from the downloaded file
KEY_OUTPUT=$(gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg)
EXPECTED_FINGERPRINT="pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
      573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
uid                      nginx signing key <signing-key@nginx.com>"

# Display both fingerprints
echo -e "Expected fingerprint:\n\n$EXPECTED_FINGERPRINT\n\n"
echo -e "Actual fingerprint:\n\n$KEY_OUTPUT\n\n"

# Ask user if they match
read -p "Do the fingerprints match? (y/n) " MATCH

if [[ $MATCH == "y" ]]; then
    # Set up the apt repository for stable nginx packages
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list

    # Set up repository pinning to prefer packages from nginx.org
    echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" | sudo tee /etc/apt/preferences.d/99nginx

    # Install nginx
    sudo apt update
    sudo apt install -y nginx
    nginx
    echo "
 ██████   █████   █████████  █████ ██████   █████ █████ █████                              
░░██████ ░░███   ███░░░░░███░░███ ░░██████ ░░███ ░░███ ░░███                               
 ░███░███ ░███  ███     ░░░  ░███  ░███░███ ░███  ░░███ ███                                
 ░███░░███░███ ░███          ░███  ░███░░███░███   ░░█████                                 
 ░███ ░░██████ ░███    █████ ░███  ░███ ░░██████    ███░███                                
 ░███  ░░█████ ░░███  ░░███  ░███  ░███  ░░█████   ███ ░░███                               
 █████  ░░█████ ░░█████████  █████ █████  ░░█████ █████ █████                              
░░░░░    ░░░░░   ░░░░░░░░░  ░░░░░ ░░░░░    ░░░░░ ░░░░░ ░░░░░                               
                                                                                           
                                                                                           
                                                                                           
  ███                                                                                      
 ░░░                                                                                       
 ████   █████     ████████    ██████  █████ ███ █████                                      
░░███  ███░░     ░░███░░███  ███░░███░░███ ░███░░███                                       
 ░███ ░░█████     ░███ ░███ ░███ ░███ ░███ ░███ ░███                                       
 ░███  ░░░░███    ░███ ░███ ░███ ░███ ░░███████████                                        
 █████ ██████     ████ █████░░██████   ░░████░████                                         
░░░░░ ░░░░░░     ░░░░ ░░░░░  ░░░░░░     ░░░░ ░░░░                                          
                                                                                           
                                                                                           
                                                                                           
 ███████████   █████  █████ ██████   █████ ██████   █████ █████ ██████   █████   █████████ 
░░███░░░░░███ ░░███  ░░███ ░░██████ ░░███ ░░██████ ░░███ ░░███ ░░██████ ░░███   ███░░░░░███
 ░███    ░███  ░███   ░███  ░███░███ ░███  ░███░███ ░███  ░███  ░███░███ ░███  ███     ░░░ 
 ░██████████   ░███   ░███  ░███░░███░███  ░███░░███░███  ░███  ░███░░███░███ ░███         
 ░███░░░░░███  ░███   ░███  ░███ ░░██████  ░███ ░░██████  ░███  ░███ ░░██████ ░███    █████
 ░███    ░███  ░███   ░███  ░███  ░░█████  ░███  ░░█████  ░███  ░███  ░░█████ ░░███  ░░███ 
 █████   █████ ░░████████   █████  ░░█████ █████  ░░█████ █████ █████  ░░█████ ░░█████████ 
░░░░░   ░░░░░   ░░░░░░░░   ░░░░░    ░░░░░ ░░░░░    ░░░░░ ░░░░░ ░░░░░    ░░░░░   ░░░░░░░░░  
                                                                                           
                                                                                           
                                                                                           
    "
else
    echo "User aborted installation due to fingerprint mismatch."
    sudo rm /usr/share/keyrings/nginx-archive-keyring.gpg
fi
