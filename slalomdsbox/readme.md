# Creating a data science Vagrant box

_Created in July 2020 by [raphael.vannson@slalom.com](mailto:raphael.vannson@slalom.com?subject=[Data%20Science%20VM])_


## Abstract

This page provides the steps executed  to create the `slalomds` box (from an "empty" Centos 7.8 box). They can be re-used/modified to create your own box.


## Pre-requisites

Execute all the pre-requisites documented in `../readme.md`.


## Create `slalomdsvm_snapshot` VM

### Create the VM

```bash
cd slalomdsbox
vagrant up
```


### Configure OS and base components

```bash
mkdir /vagrant/synchronized/yum_cache
vagrant ssh
```

```bash
sudo su -

# Create a password for user vagrant
# Use 'datascience' for the password
passwd vagrant

# set hostname
hostnamectl set-hostname slalomdsvm

# set timezone for correct date/time
# timedatectl list-timezones
timedatectl set-timezone America/Los_Angeles
date

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

#  Get repos
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.4.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
yum -y install epel-release

# Install packages (and java via mysql-connector)
yum -y install ambari-agent ambari-server git curl wget httpd mysql-connector-java python3 R
git config --global http.sslVerify false
java -version

# httpd - to verify network
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
echo "foo" > /var/www/html/foo.html
service httpd start
curl localhost/foo.html

# Python3 packages and Jupyter
pip3 install --upgrade pip
pip3 install jupyter findspark pandas matplotlib pyyaml pyjson scipy scikit-learn seaborn
rm -r ~/.cache/pip/*

# Ambari
ambari-server setup --java-home /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/jre --silent --verbose
ambari-server setup --jdbc-db mysql --jdbc-driver /usr/share/java/mysql-connector-java.jar
```

Edit `/var/lib/ambari-server` to set the JVM size options in `AMBARI_JVM_ARGS `:

```
export AMBARI_JVM_ARGS="$AMBARI_JVM_ARGS -Xms256m -Xmx512m -XX:MaxPermSize=128m ...
```



```bash
ambari-server start
ambari-agent start
# (ambari services will automatically start on vm reboot)

# Rstudio
wget https://download2.rstudio.org/rstudio-server-rhel-1.1.453-x86_64.rpm
yum -y install rstudio-server-rhel-1.1.453-x86_64.rpm
rm -f rstudio-server-rhel-1.1.453-x86_64.rpm
yum -y groupinstall "Development Tools"
service rstudio-server status
```



### Deploy the Hadoop cluster

 * Open a browser at: [http://slalomdsvm:8080/](http://slalomdsvm:8080/)
 * Login with `admin`:`admin`
 * Launch the install wizard to deploy the Hadoop cluster:
	 * Use `slalomdsvm` as the hostname.
	 * Set all passwords to `slalom`.
	 * Configure components to minimize memory usage (example: see config downloaded from Ambari for a cluster with a valid configuration).
 * Delete services "Ambari Metrics" and "SmartSense" once the cluster is provisionned.
 * Restart the cluster



### Configure Jupyter

```bash
vagrant ssh
```

Configure network:

```bash
cd
jupyter notebook --generate-config
sed -e "/#c.NotebookApp.allow_origin/c\c.NotebookApp.allow_origin = '*'" -i /home/vagrant/.jupyter/jupyter_notebook_config.py
sed -e "/#c.NotebookApp.ip/c\c.NotebookApp.ip = '0.0.0.0'" -i /home/vagrant/.jupyter/jupyter_notebook_config.py
sed -e "/#c.NotebookApp.token /c\c.NotebookApp.token = ''" -i /home/vagrant/.jupyter/jupyter_notebook_config.py
```

Configure pyspark kernel. These settings will "disable" the `pyspark` command line interface, instead pyspark is now available via Jupyter. To create a pyspark session in Jupyter:

```bash
cd 
echo "export SPARK_HOME=/usr/hdp/current/spark2-client" >> .bashrc
echo "export PYSPARK_DRIVER_PYTHON=jupyter" >> .bashrc
echo "export PYSPARK_DRIVER_PYTHON_OPTS=notebook" >> .bashrc
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> .bashrc
echo "export PATH=$SPARK_HOME/bin:$PATH" >> .bashrc
source .bashrc
```

Start the notebook server

```bash
jupyter notebook
```

Then in the notebook:

```python
import findspark
findspark.init()

# Create a spark context
import pyspark
sc = pyspark.SparkContext()
sc
sc.stop()

# OR
# Create a spark-session (akin to what pyspark provides when it is started)
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()
spark
spark.stop()
```



### Cleanup and logout

Stop all cluster services from Ambari.

```bash
# Cleanup with root
sudo su -
ambari-server stop
ambari-agent stop
rm -rf /tmp/*
rm -f .bash_history
history -c
logout

# Cleanup for user vagrant
cd
rm -rf R
rm -f .bash_history
history -c
logout
```



## Export `slalomdsvm_snapshot` VM to a box file


```bash
vagrant halt
vagrant package --base slalomdsvm_snapshot --output /vagrant/boxes/slalomds.box
```

Upload the box to **...TBD...**

To use the VM, follow the instructions in the `slalomdsvm` directory.
