#!/bin/bash

list=$1

cat $list | while read -r file; do
	sort -n -k2 $file > "./sorted/${file}"

done
