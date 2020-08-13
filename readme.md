# Slalom Data Science Virtual Machine

_Created in July 2020 by [raphael.vannson@slalom.com](mailto:raphael.vannson@slalom.com?subject=[Data%20Science%20VM])._




## Abstract

This repository provides instructions to:

 * Provision a data science VM from an existing `slalomds` box (you are a _VM user_ ).
 * Create a new box from scratch (you are a _box developer_).


Instructions:

 1. Everyone must complete the steps in the **Pre-requisites** section
 2. Follow an additional set of instructions for *VM users* or *box developers*,  links are provided in the section **Next steps / further instructions**.


On Windows, use Git Bash to execute the commands, use any terminal on Mac OS X.



## Pre-requisites


### System requirements
Check that your system meets the following requirements:

 * Mac OS X 10.14 or Windows 10
 * 16GB RAM
 * 6 physical CPU cores (12 logical  cores)
 * 60GB disk



### Install `brew` (Mac OS X only)

Check that Brew is installed, if not install it, see: [https://brew.sh](https://brew.sh).

```bash
brew -v
#Homebrew 2.1.14
#Homebrew/homebrew-core (git revision d9eef8; last commit 2019-10-16)
```


### Install `git`

Mac OS X:

```bash
brew install git
git --version
#git version 2.20.1 (Apple Git-117)
```

Windows:

Installl git from [https://gitforwindows.org](https://gitforwindows.org).
This will also provide a Unix-like terminal called Git-Bash.



### Install Virtual Box

 1. Download the VB installer from one of these direct links (or the downloads page: (home page: [https://www.virtualbox.org/wiki/Download](https://www.virtualbox.org/wiki/Download)): 
    * Mac OS X: [https://download.virtualbox.org/virtualbox/6.1.12/VirtualBox-6.1.12-139181-OSX.dmg](https://download.virtualbox.org/virtualbox/6.1.12/VirtualBox-6.1.12-139181-OSX.dmg),
    * Windows: [https://download.virtualbox.org/virtualbox/6.1.12/VirtualBox-6.1.12-139181-Win.exe](https://download.virtualbox.org/virtualbox/6.1.12/VirtualBox-6.1.12-139181-Win.exe)
 2. Double-click on the installer file to install VirtualBox
 3. [Mac OS X only] When prompted, go  to system preferences and allow the Oracle installer to proceed. Go back to the installer window, if the installation failed, run it again (step 2), it will succeed this time.



### Create the `vagrant` directory

Mac OS X:

```bash
mkdir /Users/Shared/vagrant
mkdir /Users/Shared/vagrant/boxes
mkdir /Users/Shared/vagrant/synchronized
```

Windows:

 1. Open Git-bash as administrator (Right-click on the icon -> "Run as administrator").
 2. Execute these commands:
 
 ```bash
 cd /c
 mkdir vagrant
 ```
 3. Close Git-bash.
 4. Open a new Git-bash terminal (do not run as administrator this time).
 5. Run these commands:

 ```bash
 mkdir /c/vagrant/boxes
 mkdir /c/vagrant/synchronized
 ```




### Install `vagrant`
 
 1. Download and run the installer from [https://www.vagrantup.com/downloads](https://www.vagrantup.com/downloads).
 2. Install the Vagrant plugins with these commands:

```bash
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-disksize
```


### Disable the default hypervisor (Windows only)

1. Open Powershell (run as administrator).
2. Run this command:

 ```bash
 bcdedit /set hypervisorlaunchtype off
 ```
3. Close Powershell and restart the computer.
 
 To reactivate, see details at [https://stackoverflow.com/questions/37955942/vagrant-up-vboxmanage-exe-error-vt-x-is-not-available-verr-vmx-no-vmx-code](https://stackoverflow.com/questions/37955942/vagrant-up-vboxmanage-exe-error-vt-x-is-not-available-verr-vmx-no-vmx-code).



### Add VM hostname DNS entry

Mac OS X:

```
sudo echo "192.168.33.10 slalomdsvm" > /etc/hosts
```


Windows:


1. Open Notepad (run as administrator).
2. Open this file: `c:\Windows\System32\drivers\etc\hosts` (select "All files" to list all the files, not just `.txt` files).
3. Add this line at the bottom:

   ```
   192.168.33.10	slalomdsvm
   ```
4. Save and exit.



### Clone this repo

```bash
cd
mkdir repositories
cd repositories
git clone https://github.com/raphslalom/ds-vm
```


## Next steps / further instructions

Follow an additional set instructions provided:

  * In the [`./slalomdsvm`](./slalomdsvm) directory if you are a _VM  user_ (ex: taking a training).
  * In the [`./slalomdsbox`](./slalomdsbox) directory if you are a _box developer_ (ex: creating a new box).
