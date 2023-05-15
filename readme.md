# Ansible Server
## Idea
Setup a custom server to provide a private-cloud and backup solution in a reproducible and almost automated way.
It is hard to keep track of the configuration of a custom server. By using ansible, every change is documented and reproducible.

## requirements
- a dynamic dns service (we use https://goip.de/ )
- (at least temporarily) port-forwarding of port 80 and 443 (in the router settings)
- a linux device to run the ansible playbooks in this github
- a server machine with 3-4 disks (see below)

## configured services
Ubuntu server is used as the base linux installation.
Apart from borgmatic (the backup solution), all services are ran as docker container.
- nginx (reverse proxy)
- Nextcloud (data synchronisation)
- Syncthing (data synchronisation for android devices)
- bookstack (wiki)
- pihole (ad blocking, custom dns)
- borgmatic (automated backup)

## disk setup and backups
The scripts assume a four disk setup.
- >=64GB SSD to install the operating system
- two mirrored zfs devices as data storage
- a single device to store a copy of the backups


## ToDos:
- [ ] Write this document
    - powersaving
- [X] switch to yml variables
- [X] write hdd logs
- [ ] move secrets to /vault
- [ ] setup wikijs

- syncthing: run only locally <ip:8384>
- adjust hosts file if no outside exposure desired
    - still works with expired certs?
