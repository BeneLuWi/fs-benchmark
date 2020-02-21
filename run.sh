#!/bin/bash

if [ -z "$1" ]
	then
		echo "please specify disk type as arg 1"
		exit
	fi


if [ -z "$2" ]
	then
		echo "please specify number of replications type as arg 2"
		exit
	fi

echo "Bechmarking a $1 with $2 replications"


BTRFSSCRIPTS=$(pwd)/scripts/btrfs/*
EXT4SCRIPTS=$(pwd)/scripts/ext4/*


RESULTFILE=$(pwd)/results/result$(date +"%d_%m_%H_%M").csv

echo "Processing btrfs scripts"
for i in {1..$2}
do
	for f in $BTRFSSCRIPTS
	do 
		echo "Processing $f"
	
		
		filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE

		
		sed -i -E "s/(ops|ops\/s|rd\/wr|mb\/s|ms\/op)//g" $RESULTFILE
		sed -i -E "s/(.*IO Summary: )/$1,ext4,$(basename $f),/g" $RESULTFILE
		sed -i -E 's/ +/,/g' $RESULTFILE
		sed -i -E 's/,,/,/g' $RESULTFILE

	done
done
rm -r $(pwd)/mount/btrfs/*

echo "Processing ext4 scripts"
for i in {1..$2}
do

	for f in $EXT4SCRIPTS
	do 
		echo "Processing $f"
		
		filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE
			
		sed -i -E "s/(ops|ops\/s|rd\/wr|mb\/s|ms\/op)//g" $RESULTFILE
		sed -i -E "s/(.*IO Summary: )/$1,btrfs,$(basename $f),/g" $RESULTFILE
		sed -i -E 's/ +/,/g' $RESULTFILE
		sed -i -E 's/,,/,/g' $RESULTFILE

	done
done
rm -r $(pwd)/mount/ext4/*

