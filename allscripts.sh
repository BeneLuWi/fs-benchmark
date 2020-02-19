#!/bin/bash
BTRFSSCRIPTS=$(pwd)/btrfs/*
EXT4SCRIPTS=$(pwd)/ext4/*

echo "Processing btrfs scripts"
for f in $BTRFSSCRIPTS
do 
	echo "Processing $f"
	grep -n 'IO Summary' filebench -f $f  >> $HOME/results/btrfs/$(basename $f).txt
done

echo "Processing ext4 scripts"
for f in $EXT4SCRIPTS
do 
	echo "Processing $f"
	grep -n 'IO Summary' filebench -f $f > $HOME/results/ext4/$(basename $f).txt
done
