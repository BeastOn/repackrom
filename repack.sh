#!/bin/bash

UPDATERSCRIPT="META-INF/com/google/android/updater-script"

if [ -z "$1" ]
  then
    echo "Must specify rom.zip"
    exit 1
fi

ROMFILE=$1

if [ ! -f $ROMFILE ]
  then
    echo "$ROMFILE does not exist"
    exit 2
fi

unzip $ROMFILE $UPDATERSCRIPT
zip -qd $ROMFILE $UPDATERSCRIPT
for pf in patches/*.patch; do
    patch -p1 <$pf
done

zip $ROMFILE $UPDATERSCRIPT

rm -r META-INF

java -Xmx2048m -jar ../out/host/linux-x86/framework/signapk.jar -w ../build/target/product/security/testkey.x509.pem ../build/target/product/security/testkey.pk8 $ROMFILE new.zip
mv new.zip $ROMFILE
md5sum $ROMFILE >${ROMFILE}.md5sum
