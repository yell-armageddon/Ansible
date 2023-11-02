## Installation
- get [Ubuntu Server](https://ubuntu.com/download/server) and install it on a USB stick
- boot from the USB stick and follow the instructions as follows
    - choose to install "Ubuntu Server (minimized)"
    - it is fine to use the suggested default disk setup for installation. Encryption is optional. Consider that setting encryption requires the input every reboot, which might be troublesome for headless setups.
    - install the OpenSSH server. It is not required to provide an ssh key yet.
- reboot after the installation.
- make sure that the correct boot device is set in the bios.


## Connectivity
0. Create a directory as central place to backup all require files.
1. connect to the server manually using ssh and password once to add the fingerprint.
2. Create an ssh keypair on the machine that runs the ansible playbooks
`cd $HOME/.ssh`
`ssh-keygen -t rsa -b 4096  -f id_myserver`
`cp id_myserve* /folder/in/step/0`

2. Write a custom `/etc/ansible/hosts` file. Make sure that all parameters in the example are contained.
```
[myvhosts]
192.168.123.456
[myvhosts:vars]
ansible_vault=/path/to/the/folder/in/step/0
ansible_user=user_created_during_installation
ansible_password=user_password
ansible_become_password=user_password
ansible_ssh_private_key_file=/path/to/private/key
ansible_ssh_public_key_file="{{lookup ('file','/path/to/public/key') }}"
```
3. Copy the ssh key and disable password authentification for SSH:
`ansible-playbook playbooks/001_copysshkey.yml`
4. (Optional) Remove the two password rows from the `/etc/ansible/hosts` file.

## Required accounts
The variable.yml file needs to be adjusted.
0. Provide custom passwords (and user names) wherever applicable.
1a. Register your dynamic DNS (the script assumes https://www.goip.de. Take the user name and password from the "router" menu.)
1b. Create the necessary subdomain (e.g. nextcloud.domain).
2. If you don't have an email with smtp yet, register a new one, for example at outlook.com.
3. setup your router to port forward 80 and 443.

## Device setup
0. create zfs key (and store it in your vault folder)
`dd if=/dev/urandom of=zfs_key bs=32 count=1`
`dd bs=512 count=4 if=/dev/random of=luks_key iflag=fullblock`
1. adjust the zfs device ids und luks device id carefully.
2. run the three playbooks to set up your file system:
```
ansible-playbook playbooks/017_setup_zfs.yml 
ansible-playbook playbooks/018_create_backup_device.yml 
ansible-playbook playbooks/019_mount_the_backup_device.yml 
```

## Packages & Device Setup
1. run 
```
ansible-playbook playbooks/010_install_packages.yml
    ansible-playbook playbooks/015_sync_dns_job.yml
```
### nginx installation
Before running the next playbook, make sure that portforwarding is enabled in your router to the new ubuntu server for https (port 443 and 80). LetsEncrypt will require port 80 to assign a certificate.
`ansible-playbook playbooks/020_install_nginx.yaml`

### bookstack installation
after running the playbook
`ansible-playbook playbooks/030_install_bookstack.yml`
login using`admin@admin.com` with a password of `password` and change the default password.

### nextcloud installation
after running the playbook
`ansible-playbook playbooks/040_install_nextcloud.yml`
open nextcloud to do the initial configuration:

|field| value| comment|
|------------ | ------------|  ------------| 
|username | admin| free choice of username|
|password | \* | free choice of password|
|data folder| /var/www/html/data | leave unchanged|
|database user | nextcloud | vnextcloud_db_user| 
|database password | \* | vnextcloud_db_password|
|database name | nextcloud | can't be changed|
|database host | nextcloud-mariadb| can't be changed| 

Next, install all recommended apps.