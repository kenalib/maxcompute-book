
# Log collection scripts


## setup test servers

```
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


## setup pssh commands

```bash
brew install pssh
# remote execute
pssh -A -l root -h host.txt -i "uptime"
# scp from local to remote
pscp -A -l root -h host.txt README.md /tmp/README.md
# scp from remote to local
pslurp -A -l root -h host.txt -L /tmp/outdir /tmp/README.md README.md
# kill process
pnuke -A -l root -h host.txt httpd
```


## setup odps commands on test servers

```bash
pscp -A -l root -h host.txt -r ~/bin/odpscmd_public/ /home/admin/bin/
pssh -A -l root -h host.txt -i "/home/admin/bin/odpscmd_public/bin/odpscmd -e 'whoami;'"
```


## upload data to MaxCompute

```bash
# test run on local test
bash -xe script/upload.sh 20140212 ods_log_tracker/dt=20140212
# test run on remote server
pssh -A -h host.txt -i "bash /home/admin/script/upload.sh 20140212 ods_log_tracker/dt='20140212'"
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
