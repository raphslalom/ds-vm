# Slalom Data Science Virtual Machine

Created in July 2020 by [raphael.vannson@slalom.com](mailto:raphael.vannson@slalom.com?subject=[Data%20Science%20VM]).


This repo provides resources to re-use an existing VM (user) or create a new one from scratch (developer).

* Users and developers must complete all the pre-requisites listed below.
* Once the pre-requisites are completed:
  * Users will find futher instructions in the directory `slalomdsvm`
  * Developers will find futher instructions in the directory `slalomdsvm-snapshot`


## Pre-requisites
### System requirements

 * Mac OS X 10.14
 * 16GB RAM
 * 6 CPU cores
 * 100GB disk


### brew

Check that Brew is installed, if not install it, see: [https://brew.sh](https://brew.sh).

```bash
brew -v
#Homebrew 2.1.14
#Homebrew/homebrew-core (git revision d9eef8; last commit 2019-10-16)
```


### git

```bash
brew install git

git --version
#git version 2.20.1 (Apple Git-117)
```



### Virtual Box

 1. Download the VB installer from this direct link: [https://download.virtualbox.org/virtualbox/6.1.12/VirtualBox-6.1.12-139181-OSX.dmg](https://download.virtualbox.org/virtualbox/6.1.12/VirtualBox-6.1.12-139181-OSX.dmg), (home page: [https://www.virtualbox.org/wiki/Download](https://www.virtualbox.org/wiki/Download)).
 1. Double click on the dmg file.
 2. Double click on the installer.
 3. When prompted, go  to system preferences and allow the Oracle installer to proceed.
 4. Go back to the installer window, if the installation failed, run it again (step 2), it will succeed this time.




### vagrant
 
 1. Download and run the installer from [https://www.vagrantup.com/downloads](https://www.vagrantup.com/downloads).
 2. Install the Vagrant plugins with these commands:

```bash
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-disksize
```



### Create the `vagrant` directory

```bash
cd /
sudo mkdir vagrant
sudo chown $(whoami) vagrant
cd /vagrant

# Where the .box file will be stored
mkdir boxes

# To sync local to the vm
mkdir synchronized
```

### Add VM hostname DNS entry

```
sudo echo "192.168.33.10 slalomdsvm" > /etc/hosts
```


### Clone the repo

```bash
cd
mkdir repositories
cd repositories
git clone https://github.com/raphslalom/ds-vm
```
