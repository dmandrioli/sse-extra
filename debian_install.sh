# curl https://raw.githubusercontent.com/dmandrioli/sse-extra/master/debian_install.sh | sh
apt-get update
apt-get -y install git
useradd -g users -d /home/ssedemo -s /bin/bash ssedemo
mkdir /home/ssedemo
chown ssedemo:users /home/ssedemo
curl https://install.meteor.com/ | sh
cd /home/ssedemo
sudo -u ssedemo git clone https://github.com/Hitachi-Automotive-And-Industry-Lab/semantic-segmentation-editor
mkdir images
chown ssedemo:users images
cd images
mkdir samples
chown ssedemo:users samples
sudo -u ssedemo wget https://github.com/dmandrioli/sse-extra/raw/master/pointcloud.pcd
sudo -u ssedemo wget https://github.com/dmandrioli/sse-extra/raw/master/bitmap.png
cd ../../semantic-segmentation-editor
sudo -u ssedemo meteor npm install
sudo -u ssedemo sed 's_\(input-folder.*\)XXXXX_\1/home/ssedemo/images_' -i /home/ssedemo/semantic-segmentation-editor/settings.json
sudo -u ssedemo sed 's_\(output-folder.*\)XXXXX_\1/home/ssedemo/pcd_' -i /home/ssedemo/semantic-segmentation-editor/settings.json
sudo -u ssedemo sed 's/\(.*saveData.*\){/\1{return;/' -i /home/ssedemo/semantic-segmentation-editor/server/main.js
sudo -u ssedemo sed 's/\(.*\/save.*\){/\1{return;/' -i /home/ssedemo/semantic-segmentation-editor/server/files.js
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3000
sudo -u ssedemo meteor --settings settings.json
