> clone repository and install project
```
sudo apt -qq update && sudo apt -y -qq dist-upgrade
sudo apt install -y -qq git
sudo reboot
cd ~
git clone https://github.com/edpiedra/drone-rpi3-bookworm-32bit.git
cd drone-rpi3-bookworm-32bit
bash ./install/install.sh

# it will ask you to plug the orbbec astra mini s camera into the usb and hit ENTER
sudo reboot # when install is finished
```

> connect to Mission Planner
```
# setup -> optional hardware -> UDP
# click Connect
```

> test motors
```
# ArduPilot occupies the RCIO interface
sudo systemctl stop ardupilot
cd ~/drone-rpi3-bookworm-32bit

# using Navio2 library
sudo python3 test_motors.py
