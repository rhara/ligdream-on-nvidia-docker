#!/bin/bash

chk() {
    # if OK then ret=1, else ret=0
    f=$1
    chksum=$2
    ret=0
    if [ -f $f ] ; then
        chksum=$(md5sum $f | awk '{print $1}')
        if [ $chksum = 'a36c036f36b0a31c63b115703c1430e5' ] ; then
            ret=1
        fi
    fi
    if [ $ret -eq 0 ] ; then
        wget -c http://pub.htmd.org/$f
    fi
}

chk zinc15_druglike_clean_canonical_max60.zip a36c036f36b0a31c63b115703c1430e5
chk ligdream-20190128T143457Z-001.zip c1a4ca4f2e46ad86c0f9c6c606cc8a53

mkdir -p traindataset
unzip zinc15_druglike_clean_canonical_max60.zip -d traindataset

rm -rf modelweights
unzip ligdream-20190128T143457Z-001.zip
mv ligdream modelweights

echo "Complete"
