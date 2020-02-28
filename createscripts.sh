#!/bin/bash

#BTRFSSCRIPTS=$(pwd)/scripts/btrfs/
#EXT4SCRIPTS=$(pwd)/scripts/ext4/

BASESCRIPTS=$(pwd)/scripts/basescripts/*

declare -a fileSystems=("btrfs" "ext4")

declare -a drives=("ssd" "hdd")


for driveType in "${drives[@]}"
do


	for filesystem in "${fileSystems[@]}"
	do
		echo "Processing $filesystem scripts"

		SCRIPT="$(pwd)/scripts/$driveType/$filesystem/"
		for f in $BASESCRIPTS
		do 
			echo "Processing $f"
			for i in 10000 25000 50000
			do			
				cp $f $SCRIPT
				NEWFILE=$SCRIPT$(basename $f)-$i
				echo "created file $NEWFILE"
				mv $SCRIPT/$(basename $f) $NEWFILE
				sed -i "s?dir=\/tmp?dir=$(pwd)\/mount\/$driveType\/$filesystem?" $NEWFILE
				if grep -q nfiles= "$NEWFILE";
					then
						#in case that nfiles exists the script is not randomRW and we update the line
						sed -i "s/nfiles=.*/nfiles=$i/" $NEWFILE
					else
						#in case that nfiles doesn't exist we dont try to update that line but change the filesitze				
						i=$((i / 1000))
						sed -i "s/filesize=.*/filesize="$i"g/" $NEWFILE
						mv $NEWFILE "$SCRIPT/$(basename $f)-$i"
				fi
			
			done
		done


	done
done
