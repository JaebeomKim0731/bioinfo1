#!/bin/bash
gtf_list=$1
pileup_dir=$2
out_dir=$3

cat $gtf_list | while read -r gtf; do
line_cnt=0
awk -F '\t' '{print $3"\t"$4"\t"$5"\t"$7"\t"$9}' $gtf | while read -r CorU st end strand att; do
	temp=$(echo $att | cut -d '"' -f2)
	ensembl_id=$(echo $temp | cut -d '.' -f1)
	awk -F '\t' -v st=$st -v end=$end -v strand=$strand -v CorU=$CorU -v line_cnt=$line_cnt '
	{if(st <= $2 && $2 <= end) {line_cnt += 1; print line_cnt"\t"$4"\t"CorU"\t"strand}}
	' "${pileup_dir}/${ensembl_id}.pileup" >> "${out_dir}/${ensembl_id}.tsv"
	line_cnt=$(tail -n 1 ${out_dir}/${ensembl_id}.tsv | awk '{print $1}')
done

done

