#!/bin/bash
DESTINATION=$1
PORT=$2
CHAT=$3
# clone Odoo directory
git clone --depth=1 https://github.com/BlueZebra-Works-nl/odoo-16-docker-compose-mac $DESTINATION
rm -rf $DESTINATION/.git
# set permission
mkdir -p $DESTINATION/postgresql
sudo chmod -R 777 $DESTINATION
# Load kernel extension caches (if necessary)
sudo kmutil load -n -d $DESTINATION
# config
if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi

echo 'replace ports in docker-compose.yml to run multiple instances.'
# sed -i '' 's#10016#'$PORT'#g' $DESTINATION/docker-compose.yml
# sed -i '' 's#20016#'$CHAT'#g' $DESTINATION/docker-compose.yml
# run Odoo
echo 'docker-compose -f $DESTINATION/docker-compose.yml up -d'

echo 'Started Odoo @ http://localhost:'$PORT' | Master Password: minhng.info | Live chat port: '$CHAT
