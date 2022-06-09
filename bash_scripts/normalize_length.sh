#!/bin/bash

ls | while read -r table; do
line_cnt=$(awk 'END{print NR}' $table)
if [ $line_cnt != 0 ]
then	
	awk -F '\t' -v cnt=$line_cnt '{if(cnt != 0) print $1"\t"$2/cnt"\t"$3"\t"$4"\t"$5}' $table > "/home/jaebeom/bioinfo1/analysis/CLIP-mRNA-table2/${table}"
fi
done
