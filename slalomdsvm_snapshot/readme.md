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
### Set hostname

```
sudo hostnamectl set-hostname slalomdsvm
```


### Install components

```bash
sudo su -

# httpd - to verify network
yum -y install httpd curl wget
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
echo "foo" > /var/www/html/foo.html
service httpd start
curl localhost/foo.html



# Python3
yum -y install python3
pip3 install pandas matplotlib pyyaml pyjson scipy scikit-learn seaborn

# Ambari
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.4.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
yum -y install ambari-agent ambari-server

# Pre-configure Ambari and install java 8
# Accept all defaults 
# except for
# Enable Ambari Server to download and install GPL Licensed LZO packages [y/n] (n)? y

ambari-server setup 
ln -s /usr/jdk64/jdk1.8.0_112/bin/java /bin/java
java -version

ambari-server start
ambari-agent start

# Jupyter
.... TO DO !!! 
```



### Deploy the Hadoop cluster

 * Open a browser at: [http://slalomdsvm:8080/](http://slalomdsvm:8080/)
 * Login with `admin`:`admin`
 * Launch the install wizard to deploy the Hadoop cluster:
	 * Use `slalomdsvm` as the hostname.
	 * Set all passwords to `slalom`.






### Cleanup

Cleanup the yum cache and command history




CTRL-D to logout of the VM




## Export `slalomdsvm_snapshot` VM to a box file


```bash
vagrant halt
vagrant package --base slalomdsvm_snapshot --output /vagrant/boxes/slalomdsbox.box
```

To use the VM, look at the instructions in the `slalomdsvm` directory.













## Notes
### Resize disk

Edit the disk-related section in the Vagrantfile if you want more or less space.

[https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size](https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size), then

```bash
xfs_growfs /dev/sda1
```

### Download an Oracle Java JDK 

Download the Java 14 JDK from [https://www.oracle.com/java/technologies/javase/jdk14-archive-downloads.html](https://www.oracle.com/java/technologies/javase/jdk14-archive-downloads.html). Make sure to pick the Linux rpm for x64 architectures. 

Move the file to  `/vagrant/synchronized`.

```
# Java
#cd /synchronized
#rpm -ivh jdk-14.0.2_linux-x64_bin.rpm
#java -version
```
