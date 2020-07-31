# Slalom Data Science Virtual Machine

_Created in July 2020 by [raphael.vannson@slalom.com](mailto:raphael.vannson@slalom.com?subject=[Data%20Science%20VM])._



## Provisioning a data science VM

### Pre-requisites

> Do this step only once when you you create the VM for the first time.

Execute all the pre-requisites documented in `../readme.md`.


### Registering the `slalomds` box  with vagrant

> Do this step only once when you you create the VM for the first time.

```bash
# [users and developers]
vagrant box list

# [users only]
# Download the box and register it with vagrant
# Do this overnight, the box is ≈10GB, this will take a while.
vagrant box add --name slalomds http://...TBD...

# [developers only]
# Register the box with vagrant if you already it .box file on your laptop 
# vagrant box add --name slalomds /vagrant/boxes/slalomds.box

# [users and developers]
vagrant box list
```

### Creating the VM

> Do this step every time you create a new vm from the box (ex: if you have detroyed a previous instance of the VM and you need to create a new "fresh VM").

This will create the VM from the box image previously downloaded.

```bash
cd ~/repositories/ds-vm/slalomdsvm
vagrant up
vagrant global-status
```


### Starting Hadoop

 1. Open you web browser at [http://slalomdsvm:8080/](http://slalomdsvm:8080/)
 2. Login with: `admin`:`admin`
 3. Click on the `...` near `Services`, then `Start all`. (If `Start all` is grey out, wait 1 minute, then reload the page and retry. This can happen if the VM was just started while Ambari services are still initializing).
 4. Wait for all services to be started.

![ambari-startall](./ambari-startall.png)
 
 

## Using the VM

### About the VM

 * Centos 7
 * 10GB RAM
 * 4 CPUs
 * 40GB disk (15GB already used).
 * Hadoop 3 (HDFS, YARN, Map/Reduce), Spark 2, Hive 3.



### Accessing Notebooks and other services


|Component | Description | URL | login |
|----|----|----|----|
|Jupyter| Python3 and PySpark notebooks | [http://slalomdsvm:8888/](http://slalomdsvm:8888/) | N/A |
| Zeppelin | Notebook with support for Scala | [http://slalomdsvm:9995/](http://slalomdsvm:9995/) | `admin`:`admin`  |
| Rsudio | R notebooks | [http://slalomdsvm:8787/](http://slalomdsvm:8787/) | `vagrant`:`datascience`|
| Ambari | Manage Hadoop cluster | [http://slalomdsvm:8080/](http://slalomdsvm:8080/) | `admin`:`admin` |
| YARN | Resource Manager UI | [http://slalomdsvm:8088/ui2/#/cluster-overview](http://slalomdsvm:8088/ui2/#/cluster-overview) | N/A |
| Spark  | Job History UI | [http://slalomdsvm:18081/](http://slalomdsvm:18081/) | N/A |
| Map/Reduce  | Job History UI | [http://slalomdsvm:19888/jobhistory](http://slalomdsvm:19888/jobhistory) | N/A |



### Managing the VM

All VM managment operations must be conducted from the VM  directory (it contains the `Vagrantfile`).

```bash
cd ~/repositories/ds-vm/slalomds
```

To resume /suspend the VM:

```bash
vagrant resume
vagrant suspend
```


To boot / shutdown the VM:

```bash
vagrant up
vagrant halt
```

To ssh into the VM  (VM must be running):

```bash
# Once you are logged into the VM,
# you may use all the usual Hadoop commands,
# Example: hdfs dfs -help,  yarn application -help, spark-shell...
vagrant ssh
```

To see the status of the VM:

```bash
vagrant status

# Or from  any directory
vagrant global-status --prune
```




### Sharing files between your laptop and the virtual machine

Files on your laptop under `/vagrant/synchronized` and on the VM under `/synchronized` will be... synchronized ;) . These locations act as a "tunnel" to move files between the 2 hosts.
