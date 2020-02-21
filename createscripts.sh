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
		if [ "$(basename $f)" == "copyfiles.f" ]
			then
				i=$((i / 10))
			fi
			
		cp $f $BTRFSSCRIPTS
		NEWFILE=$BTRFSSCRIPTS/$(basename $f)-$i
		mv $BTRFSSCRIPTS/$(basename $f) $NEWFILE
		sed -i "s?dir=\/tmp?dir=$(pwd)\/mount\/btrfs?" $NEWFILE
		if grep -q nfiles= "$NEWFILE";
			then
				sed -i "s/nfiles=.*/nfiles=$i/" $NEWFILE
			else				
				i=$((i / 10000))
				echo "nfiles not found in file $NEWFILE i has value $i"
				sed -i "s/filesize=.*/filesize="$i"g/" $NEWFILE
				mv $NEWFILE "$BTRFSSCRIPTS/$(basename $f)-$i"
		fi
		
	done
done

echo "Processing ext4 scripts"
for f in $BASESCRIPTS
do 
	echo "Processing $f"
	for i in 10000 50000 100000
	do
		if [ "$(basename $f)" == "copyfiles.f" ]
			then
				i=$((i / 10))	
			fi
			
		cp $f $EXT4SCRIPTS
		NEWFILE=$EXT4SCRIPTS/$(basename $f)-$i
		mv $EXT4SCRIPTS/$(basename $f) $NEWFILE
		sed -i "s?dir=\/tmp?dir=$(pwd)\/mount\/ext4?" $NEWFILE
		if grep -q nfiles= "$NEWFILE";
			then
				sed -i "s/nfiles=.*/nfiles=$i/" $NEWFILE
			else
				i=$((i / 10000))
				echo "nfiles not found in file $NEWFILE i has value $i"
				
				sed -i "s/filesize=.*/filesize="$i"g/" $NEWFILE
				mv $NEWFILE "$BTRFSSCRIPTS/$(basename $f)-$i"
		fi
		
	done
done
