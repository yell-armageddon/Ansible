### Replace device in mirror
To create manual external backups
- Remove a device from the mirror,
- Insert a new empty device and re-create the mirror (resilver process)
- Mount the removed device at a different pc (using keys for encryption) to test the backup.

#### remove currently running device
1. Check the status
```
# zpool status data
  pool: data
 state: ONLINE
  scan: scrub in progress
config:

	NAME                                 STATE     READ WRITE CKSUM
	data                                 ONLINE       0     0     0
	 mirror-0                           ONLINE       0     0     0
	   wwn-0x5000c500e           ONLINE       0     0     0
	   ata-ST8000DM004-H  ONLINE       0     0     0

errors: No known data errors
```

2. split the device from the pool data and create a new pool data_backup
`zpool split <current pool> <split pool> <device to be removed>`
`zpool split data data_backup ata-ST8000DM004-H

device is removed - zpool is no mirror
```
# zpool status data
  pool: data
 state: ONLINE
  scan: scrub in progress
config:

	NAME                      STATE     READ WRITE CKSUM
	data                      ONLINE       0     0     0
	 wwn-0x5000c500e         ONLINE       0     0     0
```

3. attach new device to zpool
`zpool attach <tank> <old device> <new device>`
`# zpool attach data wwn-0x5000c500e ata-ST8000DM004-F`

```
# zpool status data
  pool: data
 state: ONLINE
status: One or more devices is currently being resilvered.  The pool will
	continue to function, possibly in a degraded state.
action: Wait for the resilver to complete.
  scan: resilver in progress since Sat Oct 28 10:42:41 2023
	820G scanned at 16.7G/s, 1.80G issued at 37.6M/s, 2.12T total
	1.80G resilvered, 0.08% done, 16:23:57 to go
config:

	NAME                                 STATE     READ WRITE CKSUM
	data                                 ONLINE       0     0     0
	 mirror-0                           ONLINE       0     0     0
	   wwn-0x5000c500e          ONLINE       0     0     0
	   ata-ST8000DM004-F  ONLINE       0     0 1.32K  (resilvering)
```
#### import removed device at different pc
4. import the pool
`zpool import data_backup`
5. list the zfs 
```
# zfs list -o name,mounted
NAME                   MOUNTED
data_backup            no
data_backup/backup     no
data_backup/docker     no
data_backup/jelly      no
data_backup/nextcloud  no
data_backup/samba      no
data_backup/syncthing  no
```
6. try mounting without key
```
# zfs mount data_backup
cannot mount 'data_backup': encryption key not loaded
```
7. load zfs key
`sudo zfs load-key -L file:///home/yell/vault/zfs_key_yellserver data_backup`
8. mount with key `zfs mount data_backup`
