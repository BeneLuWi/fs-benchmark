#!/bin/bash

if [ -z "$1" ]
	then
		echo "ERROR: please specify disk type as arg 1"
		exit
	fi


if [ -z "$2" ]
	then
		echo "ERROR: please specify number of replications type as arg 2"
		exit
	fi
echo "	##########################################"
echo "	# Bechmarking a $1 with $2 replications #"
echo "	##########################################"
echo "	"

RESULTFILE=$(pwd)/results/result$(date +"%d_%m_%H_%M").csv
declare -a arr=("btrfs" "ext4")


for filesystem in "${arr[@]}"
do
	SCRIPTS="$(pwd)/scripts/$filesystem/*"
##TODO is this the right dir? -> f in scripts doesn't find any files?
	
	for i in $(seq 1 $2)
	do	echo "------------------ Executing replication $i from $2 ------------------"
		for f in $SCRIPTS
		do 
			echo "Processing $f"		
			
			filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE

			
			sed -i -E "s/(ops|ops\/s|rd\/wr|mb\/s|ms\/op)//g" $RESULTFILE
			sed -i -E "s/(.*IO Summary: )/$1,$filesystem,$(basename $f),/g" $RESULTFILE
			sed -i -E 's/ +/,/g' $RESULTFILE
			sed -i -E 's/,,/,/g' $RESULTFILE
			#rm -r $(pwd)/mount/$filesystem/*

		done
	done
done
