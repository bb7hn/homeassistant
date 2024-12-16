#!/bin/bash

# Install required packages
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y python3 python3-dev python3-venv python3-pip \
  bluez libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf \
  build-essential libopenjp2-7 libtiff6 libturbojpeg0-dev tzdata \
  ffmpeg liblapack3 liblapack-dev libatlas-base-dev

# Create a new user and directory for Home Assistant
echo "Creating user and directory for Home Assistant..."
sudo useradd -rm homeassistant
sudo mkdir /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant

# Switch to the homeassistant user and set up the virtual environment
echo "Setting up Home Assistant virtual environment..."
sudo -u homeassistant -H bash << 'EOF'
cd /srv/homeassistant
python3 -m venv .
source bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install wheel
pip3 install homeassistant==2024.12.3

# Start Home Assistant
echo "Starting Home Assistant..."
hass
EOF

echo "Home Assistant installation complete!"
