apt-get update
apt-get -y install git
apt-get -y install unzip
useradd -g users -d /home/ssedemo -s /bin/bash ssedemo
mkdir /home/ssedemo
chown ssedemo:users /home/ssedemo
curl https://install.meteor.com/ | sh
cd /home/ssedemo
sudo -u ssedemo git clone https://github.com/Hitachi-Automotive-And-Industry-Lab/semantic-segmentation-editor
mkdir images
chown ssedemo:users images
cd images
sudo -u ssedemo wget https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0014/2011_09_26_drive_0014_sync.zip
sudo -u ssedemo unzip 2011_09_26_drive_0014_sync.zip
cd ../semantic-segmentation-editor
sudo -u ssedemo meteor npm install
sudo -u ssedemo sed 's_\(input-folder.*\)XXXXX_\1/home/ssedemo/images_ w test' -i /home/ssedemo/semantic-segmentation-editor/settings.json
sudo -u ssedemo sed 's_\(output-folder.*\)XXXXX_\1/home/ssedemo/pcd_ w test' -i /home/ssedemo/semantic-segmentation-editor/settings.json
sudo -u ssedemo sed 's/\(.*saveData.*\){/\1{return;/' -i /home/ssedemo/semantic-segmentation-editor/server/main.js
sudo -u ssedemo sed 's/\(.*\/save.*\){/\1{return;/' -i /home/ssedemo/semantic-segmentation-editor/server/files.js
sudo -u ssedemo meteor --settings settings.json
