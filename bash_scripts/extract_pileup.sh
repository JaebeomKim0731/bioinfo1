#!/bin/bash
GTF_list=$1

cat $GTF_list | while read -r GTF; do
	temp=$(echo ${GTF} | cut -d '.' -f1 )
	ensembl_id=$(echo ${temp} | cut -d '/' -f 6)
	awk -F '\t' '{print $4, $5}' "${GTF}" | while read -r st end; do
	#echo ${st}
	awk -F '\t' -v ST=${st} -v END2=${end} '{if(ST <= $2 && $2 <= END2) print $0}' "${ensembl_id}.pileup" >> "/home/jaebeom/bioinfo1/analysis/pileup-membrane-CDS+UTR/${ensembl_id}.pileup"
done
done
