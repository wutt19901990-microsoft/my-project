#!/bin/bash 

echo "============================"
echo " Omni Toolkit Script "
echo "============================" 

case "$1" in 

ssh)
SERVER=$2
echo "Starting SSH Tunnel..." 

if [ -z "$SERVER" ]; then
echo "Usage: ./script.sh ssh user@server_ip"
exit 1
fi 

ssh -D 1080 -C -N $SERVER
;; 

cloudflare)
PORT=${2:-3000} 

echo "Starting Cloudflare Tunnel..." 

cloudflared tunnel --url http://localhost:$PORT
;; 

speed)
echo "Running Speed Test..." 

curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
;; 

install) 

echo "Installing dependencies..." 

apt update 

apt install -y \
openssh-client \
curl \
wget \
python 

wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 

chmod +x cloudflared 

mv cloudflared /usr/local/bin/ 

echo "Installation complete." 

;; 

*) 

echo "Commands available:"
echo ""
echo "./script.sh install"
echo "./script.sh ssh user@server_ip"
echo "./script.sh cloudflare 3000"
echo "./script.sh speed" 

;; 

esac

