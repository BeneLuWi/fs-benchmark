#!/bin/bash
BTRFSSCRIPTS=$(pwd)/scripts/btrfs/
EXT4SCRIPTS=$(pwd)/scripts/ext4/

BASESCRIPTS=$(pwd)/scripts/basescripts/*

echo "Processing btrfs scripts"
for f in $BASESCRIPTS
do 
	echo "Processing $f"
	for i in 10000 50000 100000
	do
		cp $f $BTRFSSCRIPTS
		NEWFILE=$BTRFSSCRIPTS/$(basename $f)-$i
		mv $BTRFSSCRIPTS/$(basename $f) $NEWFILE
		sed -i "s?dir=\/tmp?dir=$(pwd)\/mount\/btrfs?" $NEWFILE
		sed -i "s/nfiles=.*/nfiles=$i/" $NEWFILE
	done
done

echo "Processing ext4 scripts"
for f in $BASESCRIPTS
do 
	echo "Processing $f"
	for i in 10000 50000 100000
	do
		cp $f $EXT4SCRIPTS
		NEWFILE=$EXT4SCRIPTS/$(basename $f)-$i
		mv $EXT4SCRIPTS/$(basename $f) $NEWFILE
		sed -i "s?dir=\/tmp?dir=$(pwd)\/mount\/ext4?" $NEWFILE
		sed -i "s/nfiles=.*/nfiles=$i/" $NEWFILE
	done
done
