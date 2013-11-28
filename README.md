### Auto Installation Media via Kickstart ###

This should work with recent versions of Fedora, RHEL & Centos.

The ``inject-kickstart-to-iso.sh`` script captures the steps required
to remaster an ISO (netinst CD or full DVD, it doesn't matter) with a
kickstart file included and the boot menu updated to include a kickstart
install as the default option.

    $ inject-kickstart-to-iso.sh -h
    usage: inject-kickstart-to-iso.sh [-h|--help] [-d|--dry-run] [-t|--tempdir dir] <distro-image.iso> <kickstart.ks>

* ``--dry-run`` prints out the commands instead of running them
* ``--tempdir`` sets the working directory. Remastering DVD ISOs
  can take over 9Gb of disk space.

An example run:

    $ inject-kickstart-to-iso.sh Fedora-19-x86_64-DVD.iso d1.ks
    ... <output snipped> ...
    Finished: /var/tmp/inject-kickstart-to-iso.21167.workdir/Fedora-19-x86_64-DVD.patched.iso

You can either burn this image to a DVD or just copy it to a pen drive:

    $ dd if=Fedora-19-x86_64-DVD.patched.iso of=/dev/usbkey

As noted above, Fedora netinst CD or even RHEL / Centos images should
work here too.

