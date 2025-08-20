> clone repository and install project
```
sudo apt -qq update && sudo apt -y -qq dist-upgrade
sudo apt install -y -qq git
sudo reboot
cd ~
git clone https://github.com/edpiedra/drone-rpi3-bookworm-32bit.git
cd drone-rpi3
bash ./install/install.sh

