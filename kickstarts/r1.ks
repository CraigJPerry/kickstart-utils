#version=DEVEL
#
# r1 Kickstart
# Craig J Perry, 8th November 2013
#
# This is a minimal install, package selection is handled
# post-reboot by ansible config management. This ks file
# defines:
#  a) disk layout, Fedora defaults
#  b) Hostname (with F19 bug workaround, see %post)
#  c) Root account with default password (changed on first reboot)
#

cdrom

lang en_GB.UTF-8
keyboard --vckeymap=uk --xlayouts='gb'
timezone Europe/London --isUtc

zerombr
clearpart --all --initlabel --drives=sda
ignoredisk --only-use=sda
# BUG: Only installs on sda
bootloader --location=mbr --driveorder=sda

autopart

# Users
auth --enableshadow --passalgo=sha512
rootpw --iscrypted $6$JSdgnAXgP16EA7MR$HQ4isREWMEgyKP3can3iaTr678f4HPgAhp3eUp7SAYBzSPevGyooLpQ0LapodSvXU27kvOJZA6Xt9M66//x5X/

# Network information
# BUG: Fedora 19 manual workaround in %post below
network --hostname=r1.local

xconfig  --startxonboot

# No packages specified here (@core implied) as we want a
# minimal install. Ansible will handle packages post-install
%packages
%end

%post
# Workaround https://bugzilla.redhat.com/show_bug.cgi?id=981934
echo "r1.local" > /etc/hostname
echo "HOSTNAME=\"r1.local\"" > /etc/sysconfig/network

# Ansible isn't available on the install DVD. Easiest workaround is to
# grab over the network after the installation completes.
yum -y --skip-broken update
yum -y install git ansible

# Attempt to install ansible-pull mode, every 15 mins after reboot
echo "*/15 * * * * root ansible-pull --purge --url https://github.com/CraigJPerry/home-network --directory home-network --inventory-file hosts > /tmp/install-pull-mode.cron 2>&1" > /etc/cron.d/ansible-pull-install

%end

reboot

