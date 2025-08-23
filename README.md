> clone repository and install project
```
sudo apt update && sudo apt -y dist-upgrade
sudo apt install -y git
sudo reboot
cd ~
git clone https://github.com/edpiedra/drone-rpi3-bookworm-32bit.git
cd drone-rpi3-bookworm-32bit
bash ./install/install.sh
# for fresh reinstall
bash ./install/install.sh --reinstall

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

# using pymavlink library
source .venv/bin/activate
python3 -m test_motors_mavlink


