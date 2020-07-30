# Slalom Data Science Virtual Machine

Created in July 2020 by [raphael.vannson@slalom.com](mailto:raphael.vannson@slalom.com?subject=[Data%20Science%20VM]).

## What I am getting?

These instructions detail how to provision the `slalomdsvm` virtual machine on your laptop. The VM provides the usual tools for big-data-based data science work.

VM details:

   * VM: 4 CPU cores, 12GB RAM, 50GB disk.
   * VM web services available within your web browser at `http://slalomdsvm:port/xyz`
   * Easy exchange of files between host laptop and VM via a simple directory synced between both hosts.

Hadoop components details:

   * Hadoop (HDFS, Map/Redude, YARN)
   * Ambari (Hadoop managment web UI)
   * Spark 2
   * Hive
   * Jupyter
   * Hue ?
   * Zeppelin ?


Base software:

  * Java version: .....
  * Python version: .....



## Minimum system requirements

 * Mac OS X 10.14
 * 16GB RAM
 * 6 CPU cores
 * 100GB disk


## Installing the VM (do once)
This should take  ≈ 20 minutes on a reasonable internet connection.


### brew

Check that Brew is installed, if not install it, see: [https://brew.sh](https://brew.sh).

```bash
brew -v
#Homebrew 2.1.14
#Homebrew/homebrew-core (git revision d9eef8; last commit 2019-10-16)
```

### wget

```bash
brew install wget
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



### Download the VM box

```bash
cd /vagrant/boxes
wget https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-Vagrant-8.2.2004-20200611.2.x86_64.vagrant-virtualbox.box
```

### Clone the repo

```bash
cd
mkdir repositories
cd repositories
git clone https://github.com/raphslalom/ds-vm
```


### Initialize the VM

```
cd ~/repositories/ds-vm
vagrant up
```
_(Once you are done, run  `vagrant suspend` to put the VM to sleep and release CPU / RAM resources)._


### Start Hadoop services


TO DO





## Using the VM (regular usage)
### Starting/Stopping the virtual machine

Boot / shutdown:

```bash
vagrant up
vagrant halt
```

Resume /suspend:

```bash
vagrant resume
vagrant suspend
```






### Connecting to the virtual machine (ssh)

`cd` into the directory where you have executed `vagrant up` first. Example:

```bash
cd ~/repositories/ds-vm
vagrant ssh
```

From there, you may use all the usual Hadoop commands (`hdfs dfs -help`, `yarn application -help`, `spark-shell`...)

### Sharing files between your laptop and the virtual machine

Files on your laptop under `/vagrant/synchronized` and on the VM under `/synchronized` will be... synchronized ;) . These locations act as a "tunnel" to move files between the 2 hosts.

### Acessing Ambari (cluster management)

### Accessing the YARN job tracker

### Acessing Jupyter (python, pyspark)








## Notes
### backup vm

```bash
## Create a new box file from the current box

vagrant halt
vagrant global-status --prune
#id       name       provider   state    directory
#---------------------------------------------------------------------------------------------
#8d43906  default    virtualbox poweroff /Users/raphael.vannson/repositories/ds-vm/centos7
#96e5087  slalomdsvm virtualbox poweroff /Users/raphael.vannson/repositories/ds-vm/slalomdsvm

vagrant box list
#centos/7    (virtualbox, 2004.01)
#slalomdsvm  (virtualbox, 0)

vagrant box repackage slalomdsvm virtualbox 0

# Destroy the original box

vagrant destroy slalomdsvm
vagrant box remove slalomdsvm

vagrant global-status --prune
#id       name       provider   state    directory
#---------------------------------------------------------------------------------------------
#8d43906  default    virtualbox poweroff /Users/raphael.vannson/repositories/ds-vm/centos7

vagrant box list
#centos/7    (virtualbox, 2004.01)

# Backup the previous box and replace with the new one
rm /vagrant/boxes/slalomdsvm-backup.box
mv /vagrant/boxes/slalomdsvm.box /vagrant/boxes/slalomdsvm-backup.box
mv package.box /vagrant/boxes/slalomdsvm.box


# Start the vm from the new box
vagrant up
```


### Disk resize

[https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size](https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size), then

```
xfs_growfs /dev/sda1
```




```
sudo hostnamectl set-hostname slalomdsvm

sudo yum install httpd
sudo service httpd start

sudo yum install wget

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

sudo echo "foo" > /var/www/html/foo.html


wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pdsh/pdsh-2.29.tar.bz2
bzip2 -d pdsh-2.29.tar.bz2
tar -xvf pdsh-2.29.tar
cd pdsh-2.29/
sudo ./configure --with-ssh
sudo make
sudo make install
ln -s /usr/local/bin/pdsh /bin/pdsh
sudo ln -s /usr/local/bin/pdsh /bin/pdsh
pdsh


sudo rpm -ivh jdk-14.0.2_linux-x64_bin.rpm


sudo dnf install python3

sudo pip3 install pandas matplotlib pyyaml pyjson scipy scikit-learn seaborn



svn checkout http://svn.apache.org/repos/asf/ambari/trunk ambari
yum install rpm-build

```


------------------------------

## Install Ambari
### Java
Install a JDK from the Oracle website if java is not installed, (Google).

```bash
java -version
#java version "1.8.0_202"
#Java(TM) SE Runtime Environment (build 1.8.0_202-b08)
#Java HotSpot(TM) 64-Bit Server VM (build 25.202-b08, mixed mode)

javac -version
#javac 1.8.0_202

which javac
#/usr/bin/javac
```


### Maven

```bash
brew install maven
#For the system Java wrappers to find this JDK, symlink it with
#  sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

#openjdk is keg-only, which means it was not symlinked into /usr/local,
#because it shadows the macOS `java` wrapper.

#If you need to have openjdk first in your PATH run:
#  echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >> /Users/raphael.vannson/.bash_profile

#For compilers to find openjdk you may need to set:
#  export CPPFLAGS="-I/usr/local/opt/openjdk/include"

mvn --version
#Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
#Maven home: /usr/local/Cellar/maven/3.6.3_1/libexec
#Java version: 14.0.1, vendor: N/A, runtime: /usr/local/Cellar/openjdk/14.0.1/libexec/openjdk.jdk/Contents/Home
#Default locale: en_US, platform encoding: UTF-8
#OS name: "mac os x", version: "10.14.6", arch: "x86_64", family: "mac"
```




```bash
cd
mkdir repositories
cd repositories
git clone https://github.com/apache/ambari.git
cd ambari
mvn clean install
```










