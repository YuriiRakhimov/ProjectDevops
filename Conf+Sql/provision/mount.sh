
sudo su
pvcreate /dev/sdb /dev/sdc 
vgcreate vg00 /dev/sdb /dev/sdc 
lvcreate -n vol1 -l 100%FREE vg00
mkfs.ext4 /dev/vg00/vol1
mkdir /mnt/vol1
fsuid1=$(blkid -o value -s UUID /dev/vg00/vol1)
cd /etc
grep /mnt/vol1 ./fstab || echo "UUID=$fsuid1 /mnt/vol1 ext4 defaults 0 0" >> fstab
mount -a
mount | grep mnt
lsblk
su vagrant

