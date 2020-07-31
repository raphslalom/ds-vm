# Create Slalom Data Science Virtual Machine

_Created in July 2020 by [raphael.vannson@slalom.com](mailto:raphael.vannson@slalom.com?subject=[Data%20Science%20VM])_

Use these instructions to create a new `slalomdsvm` from scratch.



## Create `slalomdsvm_snapshot` VM

### Create the VM

```bash
cd slalomdsvm_snapshot
vagrant up
```



### Configure OS and base components

```bash
mkdir /vagrant/synchronized/yum_cache
vagrant ssh
```

```bash
sudo su -

# set hostname
hostnamectl set-hostname slalomdsvm

# Disable Linux firewall
sed 's/SELINUX=enforcing/SELINUX=disabled/' -i /etc/selinux/config

# Set yum cache location to the synced directpry
# to avoid re-downloading all the packages by keeping them on the laptop
sed -e '/cachedir/c\cachedir=/synchronized/yum_cache/$basearch/$releasever' -i /etc/yum.conf
sed -e '/keepcache/c\keepcache=1' -i /etc/yum.conf
 
# Log out of the VM
logout
logout
```

```bash
vagrant reload
```


### Install components

```bash
vagrant ssh
```


```bash
sudo su -

# git
yum -y install git

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
rm -r ~/.cache/pip/*

# Install mysql connector and open jdk
yum -y install mysql-connector-java
java -version

# Ambari
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.4.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
yum -y install ambari-agent ambari-server
ambari-server setup --java-home /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/jre --silent --verbose
ambari-server setup --jdbc-db mysql --jdbc-driver /usr/share/java/mysql-connector-java.jar
ambari-server start
ambari-agent start
# (ambari services will automatically start on vm reboot)

# Jupyter
#.... TO DO !!! 

# Install R + Rstudio
#.... TO DO !!! 

# Delete command history and logout of the VM
history -c
logout
history -c
logout
```



### Deploy the Hadoop cluster

 * Open a browser at: [http://slalomdsvm:8080/](http://slalomdsvm:8080/)
 * Login with `admin`:`admin`
 * Launch the install wizard to deploy the Hadoop cluster:
	 * Use `slalomdsvm` as the hostname.
	 * Set all passwords to `slalom`.
	 * Configure components to minimize memory usage (example: see config downloaded from Ambari for a cluster with a valid configuration).



### Configure Jupyter

```bash
vagrant ssh
```

```bash
configure Python3 and pyspark kernels.
```




### R and Rstudio?
do it if easy





## Export `slalomdsvm_snapshot` VM to a box file


```bash
# vagrant halt
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
