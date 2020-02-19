#!/bin/bash
BTRFSSCRIPTS=$(pwd)/scripts/btrfs/*
EXT4SCRIPTS=$(pwd)/scripts/ext4/*

echo "Processing btrfs scripts"
for f in $BTRFSSCRIPTS
do 
	echo "Processing $f"
	RESULTFILE=$(pwd)/results/btrfs/$(basename $f).txt


	filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE

	
	sed -i -E 's/(ops|ops\/s|rd\/wr|mb\/s|ms\/op|.*IO Summary: )//g' $RESULTFILE
	sed -i -E 's/ +/,/g' $RESULTFILE

done

echo "Processing ext4 scripts"
for f in $EXT4SCRIPTS
do 
	echo "Processing $f"
	RESULTFILE=$(pwd)/results/ext4/$(basename $f).txt

	
	filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE
		
	sed -i -E 's/(ops|ops\/s|rd\/wr|mb\/s|ms\/op|.*IO Summary: )//g' $RESULTFILE
	sed -i -E 's/ +/,/g' $RESULTFILE

done

