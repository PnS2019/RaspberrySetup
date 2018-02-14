# Admin Setup Guide


## Reinstall Raspbian

1. Download Raspbian image with desktop from [here](https://www.raspberrypi.org/downloads/raspbian/). The latest version is Raspbian Stretch.

2. Flash your SD card with the image by following [this guide](https://www.raspberrypi.org/learning/software-guide/quickstart/)

## Update the system and upgrade

```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo reboot
```

## Setup Pi Camera

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
    $ sudo apt-get install python-opencv
    $ sudo apt-get install python-scipy
    ```

+ Install TensorFlow for Python 2

    ```
    $ sudo apt-get install libblas-dev liblapack-dev python-dev \
    libatlas-base-dev gfortran python-setuptools
    $ sudo pip install http://ci.tensorflow.org/view/Nightly/job/nightly-pi/lastSuccessfulBuild/artifact/output-artifacts/tensorflow-1.5.0-cp27-none-any.whl -U
    ```

+ Install Keras

    ```
    $ sudo pip install keras
    $ sudo pip install h5py
    ```

+ Install `espeak`

    ```
    $ sudo apt-get install espeak
    ```
    
    Test the sound by:

    ```
    $ espeak -ven+f3 -k5 -s150 "I'm Baby Jarvis" 
    ```
