### Create work directory

sudo mkdir manager && cd manager && sudo mkdir ssh && cd ssh

### Configure the Pi

sudo apt update && sudo apt full-upgrade --yes

sudo apt-get install -y git cmake build-essential curl libcurl4-openssl-dev libssl-dev uuid-dev ca-certificates

sudo reboot

### Check libc6 version

Check if exist a ssh-proxy-client-v<version> equal or minor.

ldd --version

### Build the client proxy code

Run the `build.sh` script on the Pi if version dont exists. This script will clone the Azure IoT C SDK, build it, then compile the client code. You can see the client code in the ssh-proxy-client.c file.

### Run the client proxy code

./ssh-proxy-client-v<version> "<device connection string>"

### Create service deamon

cd /lib/systemd/system

sudo nano device_stream.service

[Unit]
Description="Device Local Proxy Service"
After=network.target
[Service]
ExecStart=/home/<user>/manager/ssh/ssh-proxy-client-v<version> <iot_hub_device_connection_string>
Restart=always
[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload

sudo systemctl enable device_stream

sudo systemctl start device_stream

sudo systemctl status device_stream
