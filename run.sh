#!/bin/bash
BTRFSSCRIPTS=$(pwd)/scripts/btrfs/*
EXT4SCRIPTS=$(pwd)/scripts/ext4/*


RESULTFILE=$(pwd)/results/result$(date +"%d_%m_%H_%M").csv

echo "Processing btrfs scripts"
for i in {1..5}
do
	for f in $BTRFSSCRIPTS
	do 
		echo "Processing $f"
	
		
		filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE

		
		sed -i -E "s/(ops|ops\/s|rd\/wr|mb\/s|ms\/op)//g" $RESULTFILE
		sed -i -E "s/(.*IO Summary: )/ext4,$(basename $f),/g" $RESULTFILE
		sed -i -E 's/ +/,/g' $RESULTFILE

	done
done
rm -r $(pwd)/mount/btrfs/*

echo "Processing ext4 scripts"
for i in {1..5}
do

	for f in $EXT4SCRIPTS
	do 
		echo "Processing $f"
		
		filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE
			
		sed -i -E "s/(ops|ops\/s|rd\/wr|mb\/s|ms\/op)//g" $RESULTFILE
		sed -i -E "s/(.*IO Summary: )/btrfs,$(basename $f),/g" $RESULTFILE
		sed -i -E 's/ +/,/g' $RESULTFILE

	done
done
rm -r $(pwd)/mount/ext4/*

