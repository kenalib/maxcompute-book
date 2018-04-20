
# Log collection scripts


upload access log from 3 web servers to MaxCompute


## setup test servers

* install Docker Community Edition https://www.docker.com/
* start 3 mock servers by docker-compose

```
cd book/ch3_tunnel/
docker-compose up -d
docker-compose ps
```

* sample `~/.ssh/config` for 3 containers

```
Host host1
    HostName localhost
    User root
    Port 32801
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
Host host2
    HostName localhost
    User root
    Port 32802
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
Host host3
    HostName localhost
    User root
    Port 32803
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
```

* try `ssh root@host1` to confirm it is working.
* password is `screencast` as in https://docs.docker.com/engine/examples/running_ssh_service/


## setup pssh commands

* `pssh` is parallel ssh to run SSH commands over many servers.

```bash
brew install pssh
```

* try sample commands

```bash
# remote execute
pssh -A -l root -h host.txt -i "uptime"
# scp from local to remote
pscp -A -l root -h host.txt README.md /tmp/README.md
# scp from remote to local
pslurp -A -l root -h host.txt -L /tmp/outdir /tmp/README.md README.md
# kill process (just a example, will not work in this case)
pnuke -A -l root -h host.txt httpd
```


## setup odps commands on test servers

```bash
pscp -A -l root -h host.txt -r ~/odpscmd/ /
pssh -A -l root -h host.txt -i "echo 'export PATH=\$PATH:/odpscmd/bin/' >> /root/.profile"
pssh -A -l root -h host.txt -i "bash -cl \"odpscmd -e 'whoami;'\""
```


## upload data to MaxCompute

```bash
# add partition for testing
odpscmd -e "ALTER TABLE ods_log_tracker ADD IF NOT EXISTS PARTITION(dt='20140212');"
# test run on local test
bash -xe script/upload.sh 20140212 ods_log_tracker/dt=20140212
# test run on remote server
pssh -A -h host.txt -i "bash -l /home/admin/script/upload.sh 20140212 ods_log_tracker/dt='20140212'"
# run all
bash -xe script/master.sh
```


## clean up

```bash
docker-compose ps
docker-compose down
```


## reference

* https://docs.docker.com/engine/examples/running_ssh_service/
