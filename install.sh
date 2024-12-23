 sudo apt-get install -y ca-certificates curl gnupg
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
        apt-get update
        apt-get install -y nodejs
        npm i -g yarn
        cd /var/www/pterodactyl
        yarn
        yarn add cross-env
        apt install -y zip unzip git curl wget
        wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip
        mv release.zip /var/www/pterodactyl/release.zip
        cd /var/www/pterodactyl
        unzip release.zip
        WEBUSER="www-data"; USERSHELL="/bin/bash"; PERMISSIONS="www-data:www-data"
        sed -i -E -e "s|WEBUSER=\"www-data\" #;|WEBUSER=\"$WEBUSER\" #;|g" -e "s|USERSHELL=\"/bin/bash\" #;|USERSHELL=\"$USERSHELL\" #;|g" -e "s|OWNERSHIP=\"www-data:www-data\" #;|OWNERSHIP=\"$PERMISSIONS\" #;|g" $FOLDER/blueprint.sh
        chmod +x blueprint.sh
        bash blueprint.sh
        cd /var/www

BLUEPRINT_FILE="/var/www/pterodactyl/blueprint.sh"

if [ ! -f "$BLUEPRINT_FILE" ]; then

    echo "𝗗𝗘𝗣𝗘𝗡𝗗 𝗣𝗟𝗨𝗚𝗜𝗡𝗦 𝗕𝗘𝗟𝗨𝗠 𝗗𝗜𝗜𝗡𝗦𝗧𝗔𝗟 𝗦𝗜𝗟𝗔𝗛𝗞𝗔𝗡 𝗜𝗡𝗦𝗧𝗔𝗟𝗟 𝗧𝗘𝗥𝗟𝗘𝗕𝗜𝗛 𝗗𝗔𝗛𝗨𝗟𝗨 𝗗𝗘𝗡𝗚𝗔𝗡 𝗠𝗘𝗠𝗜𝗟𝗜𝗛 𝗢𝗣𝗦𝗜 𝗡𝗢 𝟭𝟭"

    exit 1

fi
# Masukkan token GitHub langsung di sini

    GITHUB_TOKEN="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"
    # Clone repositori menggunakan token

    REPO_URL="https://${GITHUB_TOKEN}@github.com/rainmc0123/RainPrem.git"

    TEMP_DIR="RainPrem"
    # Mengkloning repositori

    git clone "$REPO_URL"
    sudo mv "$TEMP_DIR/nebulaptero.zip" /var/www/

    unzip -o /var/www/nebulaptero.zip -d /var/www/

    cd /var/www/pterodactyl && blueprint -install nebula

  cd /var/www/ && rm -r RainPrem

  cd /var/www/ && rm -r nebulaptero.zip

cd /var/www/pterodactyl && rm -r nebula.blueprint

echo "NEBULA THEME BERHASIL DI INSTALL"
# URL dan lokasi file

FILE_URL="https://raw.githubusercontent.com/"

DESTINATION="/var/www/pterodactyl"
# Mengunduh file dengan menyembunyikan output dan error

curl -H "Authorization: token ${GITHUB_TOKEN}" -L -o "${DESTINATION}" "${FILE_URL}" > /dev/null 2>&1
# Informasi hasil

if [ $? -eq 0 ]; then

    echo "File berhasil diunduh ke ${DESTINATION}" > /dev/null 2>&1

else

    echo "Gagal mengunduh file" > /dev/null 2>&1

fi
