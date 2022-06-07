#!/bin/bash
gtf_list=$1
pileup_dir=$2
out_dir=$3

cat $gtf_list | while read -r gtf; do
line_cnt=0
awk -F '\t' '{print $3"\t"$4"\t"$5"\t"$7"\t"$9}' $gtf | while read -r CorU st end strand att
do
	#echo $st
	temp=$(echo $att | cut -d '"' -f2)
	ensembl_id=$(echo $temp | cut -d '.' -f1)
	for (( pos=$st; pos<=$end; pos++))
	do
		if grep -m 1 "${pos}" "${pileup_dir}/${ensembl_id}.pileup" | awk -F '\t' -v id=$ensembl_id -v offset=$st -v strand=$strand -v CorU=$CorU -v pos=$line_cnt '{print id"\t"pos"\t"$4"\t"CorU"\t"strand}' >> "${out_dir}/${ensembl_id}.tsv"
		then
			((line_cnt++))
		else
			#awk -v pos=$line_cnt -v id=$ensembl_id -v CorU=$CorU -v strand=$strand '{print id"\t"pos"\t0\t"CorU"\t"strand"\t_here"}' >> "${out_dir}/${ensembl_id}.tsv"
			echo -e "${ensembl_id}\t${line_cnt}\t0\t${CorU}\t${strand}" >> "${out_dir}/${ensembl_id}.tsv"
			((line_cnt++))
		fi
	done
	done
done

