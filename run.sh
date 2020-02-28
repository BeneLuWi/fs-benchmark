#!/bin/bash

if [ -z "$1" ]
	then
		echo "ERROR: please specify number of replications type as arg 1"
		exit
	fi

declare -a drives=("ssd" "hdd")
RESULTFILE=$(pwd)/results/result$(date +"%d_%m_%H_%M").csv
declare -a arr=("btrfs" "ext4")

for driveType in "${drives[@]}"
do

	echo "##########################################"
	echo "# Bechmarking a $driveType with $1 replications #"
	echo "# Starting at $(date +"%H:%M") 		#"
	echo "##########################################"


	for filesystem in "${arr[@]}"
	do
		SCRIPTS="$(pwd)/scripts/$driveType/$filesystem/*"
	##TODO is this the right dir? -> f in scripts doesn't find any files?
		
		for i in $(seq 1 $1)
		do	echo "------- Executing replication $i from $1 for $filesystem on a $driveType (at $(date +"%H:%M"))-------"
			for f in $SCRIPTS
			do 
				echo "Processing $(basename $f)"		
				
				filebench -f $f | grep -n 'IO Summary'  >> $RESULTFILE

				
				sed -i -E "s/(ops|ops\/s|rd\/wr|mb\/s|ms\/op)//g" $RESULTFILE
				sed -i -E "s/(.*IO Summary: )/$driveType,$filesystem,$(basename $f),/g" $RESULTFILE
				sed -i -E 's/ +/,/g' $RESULTFILE
				sed -i -E 's/,,/,/g' $RESULTFILE
				rm -r $(pwd)/mount/$driveType/$filesystem/*

			done
		done
	done
done
echo "##########################################"
echo "# Completed Benchmark at $(date +"%H:%M")  #"
echo "##########################################"
