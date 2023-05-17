## Installation
- get [Ubuntu Server](https://ubuntu.com/download/server) and install it on a USB stick
- boot from the USB stick and follow the instructions as follows
    - choose to install "Ubuntu Server (minimized)"
    - it is fine to use the suggested default disk setup for installation. Encryption is optional. Consider that setting encryption requires the input every reboot, which might be troublesome for headless setups.
    - install the OpenSSH server. It is not required to provide an ssh key yet.
- reboot after the installation.
- make sure that the correct boot device is set in the bios.


## Connectivity
0. Create a directory and path variable to it. Use this to as central place to backup all require files.
`export backmeup=/home/myuser/myvault`
1. connect to the server manually using ssh and password once to add the fingerprint.
2. Create an ssh keypair on the machine that runs the ansible playbooks
`cd $HOME/.ssh`
`ssh-keygen -t rsa -b 4096  -f id_myserver`
`cp id_myserve* $backmeup`

2. adjust the `/etc/ansible/hosts` file. Make sure that all parameters in the example are contained.
3. Copy the ssh key and disable password authentification for SSH:
`ansible-playbook playbooks/001_copysshkey.yml`
4. (Optional) Remove the password from the `/etc/ansible/hosts` file.
