#!/bin/bash

echo "=== WireGuard Auto Install Script ==="

# Update system
apt update -y && apt upgrade -y

# Install WireGuard
apt install wireguard qrencode curl -y

# Enable IP Forward
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# Create directory
mkdir -p /etc/wireguard
cd /etc/wireguard

# Generate keys
wg genkey | tee server_private.key | wg pubkey > server_public.key

SERVER_PRIVATE=$(cat server_private.key)

# Detect VPS public IP
SERVER_IP=$(curl -s ifconfig.me)

# Create config
cat > wg0.conf <<EOF
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = $SERVER_PRIVATE
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
EOF

# Set permission
chmod 600 /etc/wireguard/wg0.conf

# Enable service
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

echo ""
echo "=============================="
echo "WireGuard Installed!"
echo "Server IP: $SERVER_IP"
echo "Port: 51820"
echo "=============================="

