# Admin Setup Guide


## Reinstall Raspbian

1. Download Raspbian image with desktop from [here](https://www.raspberrypi.org/downloads/raspbian/). The latest version is Raspbian Stretch.

2. Flash your SD card with the image by following [this guide](https://www.raspberrypi.org/learning/software-guide/quickstart/)

## Clone and Run scripts to install all dependencies

Clone this setup guide:

```
$ git clone https://github.com/PnS2019/RaspiberrySetup
```

Upgrade and install dependencies:

```
$ cd ./res/setups-py3
$ sudo ./setup-upgrade  # machine will be reboot after installation
$ sudo ./setup-deps  # machine will be reboot after installtion
```

SSH is enabled after installation, the password is changed to `pi` for the user `pi`

Install Wireless Hotspot support

```
$ git clone https://github.com/PnS2018/RPI-Wireless-Hotspot
$ cd RPI-Wireless-Hotspot
$ sudo ./install
```

And follow the instructions

### Check camera, speaker and espeak

```
$ cd ./res/setups
$ ./check-camera
$ ./check-speaker
$ ./check-espeak
```

__Ignore rest of this guide if you've done above settings.__

## Update the system and upgrade

```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo reboot
```

## Setup Pi Camera

Make sure you installed the Pi Camera correctly. Follow the installation instructions at [here](https://picamera.readthedocs.io/en/release-1.13/quickstart.html)

```
$ sudo raspi-config
```

Choose enable camera and reboot the system. Test the camera with `raspistill` program

```
$ raspistill -o output.jpg
```

Install PiCamera package by

```
$ sudo pip install "picamera[array]"
```

__NOTE__: apparently OpenCV's `VideoCapture` feature is not working very nicely
with the Pi Camera.

## Setup USB Speaker

Update `alsa` options. First copy `res/asound.conf` to `/etc`.

```
$ sudo cp ./res/asound.conf /etc
```

Reboot the machine. And test audio by:

```
$ speaker-test -c2
$ speaker-test -c2 --test=wav -w /usr/share/sounds/alsa/Front_Center.wav
```

## Install necessary softwares

+ Install general helping tools:

    ```
    $ sudo apt-get install cmake
    $ sudo apt-get install libhdf5-dev
    $ sudo apt-get install python-opencv
    $ sudo apt-get install python-scipy
    $ sudo apt-get isntall python-matplotlib
    ```

+ Install TensorFlow for Python 2

    ```
    $ sudo apt-get install libblas-dev liblapack-dev python-dev \
    libatlas-base-dev gfortran python-setuptools
    $ sudo pip install http://ci.tensorflow.org/view/Nightly/job/nightly-pi/lastSuccessfulBuild/artifact/output-artifacts/tensorflow-1.5.0-cp27-none-any.whl -U
    ```

    __NOTE__: This operation takes time

+ Install Keras

    ```
    $ sudo pip install keras
    $ sudo apt-get install python-h5py
    $ sudo apt-get install python-pydot
    ```

+ Install `espeak`

    ```
    $ sudo apt-get install mplayer
    $ sudo apt-get install espeak
    ```
    
    Test the sound by:

    ```
    $ espeak -ven+f3 -k5 -s150 "I'm Baby Jarvis" --stdout > /tmp/test.wav | mplayer /tmp/test.wav
    ```

## Get IP address from speaker

Copy `IPspeak.pl` from `res` folder

```
$ cp ./res/IPspeak.pl $HOME
```

Edit `/etc/rc.local`:

```
$ sudo /etc/rc.rc.local
```

Before `exit 0`, add:

```
$ su -l pi -c 'nohup $HOME/IPspeak.pl >> /dev/null &'
```

Reboot.

Run following commands to stop from playing

```
$ pkill IPspeak
```

## No HDMI output signal

1. Take SD card out and connect to another machine.

2. Open `config.txt` at `boot` partition

3. Uncomment following three lines:

```
disable_overscan=1
hdmi_force_hotplug=1
config_hdmi_boost=4
```

4. Save and put the SD card back to the Pi
