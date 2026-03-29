#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "=== [1/4] Mise à jour des paquets ==="
apt-get update -y

echo "=== [2/4] Installation des paquets nécessaires (SSH, XFCE, VNC) ==="
apt-get install -y \
  openssh-server \
  xfce4 xfce4-goodies \
  tigervnc-standalone-server \
  xterm \
  iproute2 net-tools

echo "=== [3/4] Configuration et démarrage du serveur SSH ==="
mkdir -p /var/run/sshd

if ! pgrep -x sshd >/dev/null 2>&1; then
  /usr/sbin/sshd
fi

echo "=== [4/4] Configuration et démarrage du serveur VNC (TigerVNC) ==="

mkdir -p /root/.vnc

echo "runpodvnc" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

cat > /root/.vnc/xstartup << 'XEOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
XEOF
chmod +x /root/.vnc/xstartup

vncserver -kill :1 >/dev/null 2>&1 || true

vncserver :1 -geometry 1280x800 -depth 24 -localhost yes

echo
echo "=== RÉSUMÉ ==="
echo "SSH : en écoute sur le port 22 dans le pod."
echo "VNC : serveur lancé sur :1 (port 5901, localhost uniquement)."
echo "Depuis Windows : créer un tunnel SSH puis se connecter à localhost:5901 avec TigerVNC."

echo "=== [5/5] Installation de la clé SSH personnelle ==="
mkdir -p /root/.ssh
cat << 'KEYEOF' > /root/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANd9I1a8OpsPbKtehNDkowjv3xmq25YCHnq2vw0Dn0S msi_wil@MSI_WIL-PC
KEYEOF
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

