#!/bin/bash
GTF=$1
BAM=$2

awk -F '\t' '{print $1, $4, $5, $9}' "${GTF}" | while read -r chr st end att; do
	geneID=$(echo ${att} | cut -d '"' -f2)
	echo $geneID
       	samtools view -b -o "${geneID}.bam" "${BAM}" "${chr}:${st}-${end}"
done
	
#samtools view -b -o "${geneID}.bam" "${BAM}" "${chr}:${st}-${end}"
