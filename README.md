# snapshot.sh
Bash Script for Rackspace Cloud Block Storage snapshot

This was created because there is no current scheduling function to create nightly backup snapshots for a cloud block storage volume.  A block storage volume data was lost due to a host incident and recovery would have been exponetionally faster than the file recovery we did for the lost volume 375GB onto a SATA drive.  So I took some time and wrote this as my first real script.  You can use cron to run the snapshot nightly to get a dirty backup.  I want to eventually add functionality into this script that will check lsof to see if the drive is in use and if not then unmount - create snapshot - and then remount - and then remove old backups that are X days old.
