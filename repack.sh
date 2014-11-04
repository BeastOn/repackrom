#!bin/bash

UPDATERSRIPT="META-INF/com/google/android/updater-script"
              META-INF/com/google/android/updater-script

if [ -z "$1" ]
  then
    echo "Must specify rom.zip"
    exit 1
fi

ROMZIP=$1

if [ -f $ROMFILE]
  then
    echo "$ROMFILE does not exist"
    exit 2
fi

unzip $ROMFILE $UPDATERSCRIPT
for pf in patches/*.patch; do
    patch <$pf
done

zip -r $ROMFILE $UPDATERSCRIPT

rm -r META-INF
