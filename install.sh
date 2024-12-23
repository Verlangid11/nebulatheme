#!/bin/bash

# Set environment to noninteractive to bypass prompts
export DEBIAN_FRONTEND=noninteractive

# Install dependencies
sudo apt-get install -y ca-certificates curl gnupg unzip git wget zip

# Create necessary directories
sudo mkdir -p /etc/apt/keyrings

# Add Node.js GPG key and repository
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Update package list and install Node.js
sudo apt-get update -y
sudo apt-get install -y nodejs

# Install Yarn globally
npm i -g yarn

# Navigate to Pterodactyl directory and install dependencies
cd /var/www/pterodactyl
yarn
yarn add cross-env

# Download the latest Blueprint release
RELEASE_URL=$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)
wget "$RELEASE_URL" -O /var/www/pterodactyl/release.zip

# Extract the Blueprint release
unzip -o /var/www/pterodactyl/release.zip -d /var/www/pterodactyl

# Update permissions and execute the Blueprint installation script
WEBUSER="www-data"
USERSHELL="/bin/bash"
PERMISSIONS="www-data:www-data"
sed -i -E \
    -e "s|WEBUSER=\"www-data\"|WEBUSER=\"$WEBUSER\"|g" \
    -e "s|USERSHELL=\"/bin/bash\"|USERSHELL=\"$USERSHELL\"|g" \
    -e "s|OWNERSHIP=\"www-data:www-data\"|OWNERSHIP=\"$PERMISSIONS\"|g" \
    /var/www/pterodactyl/blueprint.sh
chmod +x /var/www/pterodactyl/blueprint.sh
bash /var/www/pterodactyl/blueprint.sh

# Check if Blueprint was installed
BLUEPRINT_FILE="/var/www/pterodactyl/blueprint.sh"
if [ ! -f "$BLUEPRINT_FILE" ]; then
    echo "𝗗𝗘𝗣𝗘𝗡𝗗 𝗣𝗟𝗨𝗚𝗜𝗡𝗦 𝗕𝗘𝗟𝗨𝗠 𝗗𝗜𝗜𝗡𝗦𝗧𝗔𝗟𝗟. 𝗦𝗜𝗟𝗔𝗛𝗞𝗔𝗡 𝗜𝗡𝗦𝗧𝗔𝗟𝗟 𝗧𝗘𝗥𝗟𝗘𝗕𝗜𝗛 𝗗𝗔𝗛𝗨𝗟𝗨."
    exit 1
fi

# Clone and install Nebula theme
REPO_URL="https://github.com/Verlangid11/nebulafiles.git"
TEMP_DIR="nebulafiles"
git clone "$REPO_URL"
sudo mv "$TEMP_DIR/nebulaptero.zip" /var/www/
unzip -o /var/www/nebulaptero.zip -d /var/www/
cd /var/www/pterodactyl && ./blueprint.sh -install nebula
rm -rf /var/www/nebulafiles /var/www/nebulaptero.zip

# Clean up unnecessary files
cd /var/www/pterodactyl && rm -f nebula.blueprint
echo "NEBULA THEME BERHASIL DI INSTALL"

# Download additional files
FILE_URL="https://raw.githubusercontent.com/"
DESTINATION="/var/www/pterodactyl/"
curl -s -o "${DESTINATION}" "${FILE_URL}"
if [ $? -eq 0 ]; then
    echo "File berhasil diunduh ke ${DESTINATION}"
else
    echo "Gagal mengunduh file"
fi
