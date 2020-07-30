# Create Slalom Data Science Virtual Machine

_Created in July 2020 by [raphael.vannson@slalom.com](mailto:raphael.vannson@slalom.com?subject=[Data%20Science%20VM])_

Use these instructions to create a new `slalomdsvm` from scratch.



## Create `slalomdsvm_snapshot` VM

### Start the VM and login

```bash
cd slalomdsvm_snapshot
vagrant up
vagrant ssh
```

### Resize disk

Edit the disk-related section in the Vagrantfile if you want more or less space.

[https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size](https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size), then

```bash
xfs_growfs /dev/sda1
```

### Set hostname

```
sudo hostnamectl set-hostname slalomdsvm
```

### Download an Oracle Java JDK 

Download the Java 14 JDK from [https://www.oracle.com/java/technologies/javase/jdk14-archive-downloads.html](https://www.oracle.com/java/technologies/javase/jdk14-archive-downloads.html). Make sure to pick the Linux rpm for x64 architectures. 

Move the file to  `/vagrant/synchronized`.


### Install components

```bash
sudo su -

# httpd - to verify network
yum -y install httpd curl wget
service httpd start
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
echo "foo" > /var/www/html/foo.html
curl localhost/foo.html

# Java
rpm -ivh jdk-14.0.2_linux-x64_bin.rpm

# Python3
sudo dnf install python3
sudo pip3 install pandas matplotlib pyyaml pyjson scipy scikit-learn seaborn



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





svn checkout http://svn.apache.org/repos/asf/ambari/trunk ambari
yum install rpm-build

```

### Configure Ambari

conf files
service start on boot



### Install hadoop cluster







CTRL-D to logout of the VM




## Export `slalomdsvm_snapshot` VM to a box file


```bash
vagrant halt
vagrant package --base slalomdsvm_snapshot --output /vagrant/boxes/slalomdsbox.box
```

To use the VM, look at the instructions in the `slalomdsvm` directory.


