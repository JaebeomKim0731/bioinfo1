#!/bin/bash


ls | while read -r table; do
ensembl_id=$(echo $table | cut -d '.' -f1)
for ((i=0; i<100; i++))
do
	st=$i/100;
	en=($i+1)/100;
	awk -F '\t' -v id=$ensembl_id '{idx=($2*100- $2*100%1); arr[idx] += $3}
	END{
	for (idx=0; idx < 100; idx++)
	       print id"\t"idx"\t"arr[idx]	
	}
	' $table > "../CLIP-mRNA-table3/${ensembl_id}.tsv"
done
done
