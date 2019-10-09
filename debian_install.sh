# curl https://raw.githubusercontent.com/dmandrioli/sse-extra/master/debian_install.sh | sh
apt-get update
apt-get -y install git
useradd -g users -d /home/ssedemo -s /bin/bash ssedemo
mkdir /home/ssedemo
chown ssedemo:users /home/ssedemo
curl https://install.meteor.com/ | sh
cd /home/ssedemo
sudo -u ssedemo git clone https://github.com/Hitachi-Automotive-And-Industry-Lab/semantic-segmentation-editor
cd semantic-segmentation-editor
sudo -u ssedemo meteor npm install
sudo -u ssedemo sed 's/\(.*saveData.*\){/\1{return;/' -i /home/ssedemo/semantic-segmentation-editor/server/main.js
sudo -u ssedemo sed 's/\(.*\/save.*\){/\1{return;/' -i /home/ssedemo/semantic-segmentation-editor/server/files.js
cat > /home/ssedemo/semantic-segmentation-editor/client/g.html << EOL
<!-- Global site tag (gtag.js) - Google Analytics -->
<head>
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-123193983-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-123193983-1');
</script>
</head>
EOL
iptables -t nat -A PREROUTING -i ens2 -p tcp --dport 80 -j REDIRECT --to-port 3000
killall -9 node mongod
while :; do sudo -u ssedemo meteor --settings settings.json; done&
