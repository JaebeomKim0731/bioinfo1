#!/bin/bash

list=$1

cat $list | while read -r table; do
awk -F '\t' 'BEGIN{cnt=99} {print $1"\t"cnt"\t"$3; cnt -= 1;}' $table > "../CLIP-mRNA-table3-reverse-corrected/${table}"
done
