#!/bin/bash
list=$1

cat $list | while read -r file; do
awk -F '\t' '{if($3 == "CDS" || $3 == "UTR") print $0}' $file > "/home/jaebeom/bioinfo1/integral_membrane_CDS+UTR_gtfs/${file}"
done
