#!/bin/bash
list=$1
cat $list | while read -r file; do
	sort -k 4 $file > "/home/jaebeom/bioinfo1/integral_membrane_CDS+UTR_gtfs_sorted/${file}"
done
