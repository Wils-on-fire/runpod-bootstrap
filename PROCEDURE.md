IP et PORT, voir sur la page du pod onglet CONNECT, bas de page

Lorsque le pod est actif, je note son adresse IP et le port attaché, puis j'ouvre le Web terminal
Je tape :
apt-get update -y
apt-get install -y curl
curl -fsSL https://raw.githubusercontent.com/Wils-on-fire/runpod-bootstrap/refs/heads/main/bootstrap_network.sh | bash

Puis dans powershell à adapter selon l'IP et le port SSH dans l'onglet CONNECT de runpod.io :
ssh -i $env:USERPROFILE\.ssh\runpod_nouvelle root@213.173.110.86 -p 17919

Dans une nouvelle fenetre powershell , connexion SSH dans powershell à adapter selon l'IP et le port SSH dans l'onglet CONNECT de runpod.io :

ssh -i $env:USERPROFILE\.ssh\runpod_nouvelle -L 5901:localhost:5901 root@213.173.110.86 -p 17919

Dans E:\Documents\3D\Runpod ouvrir vncviewer64-1.15.0.exe
puis mot de passe : runpodvnc

Dans le pod →
rsync -avz wil@37.27.84.115:/home/wil/backup-runpod-workspace/ /workspace/