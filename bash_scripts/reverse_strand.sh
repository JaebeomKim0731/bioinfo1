#!/bin/bash

list=$1

cat $list | while read -r gtf; do
strand=$(head -n 1 $gtf | awk -F '\t' '{print $7}')
if [ "$strand" == "+" ]
then
	echo $(echo $gtf | cut -d '.' -f1)
fi
done
