#!/bin/bash

BAM_list=$1

awk '{print $0}' "${BAM_list}" | while read -r bam; do
	geneID=$(echo ${bam} | cut -d. -f1)
	echo $geneID
	samtools mpileup "${bam}" > "${geneID}.pileup"
done


#samtools mpileup CLIP-let7g.bam > CLIP-let7g.pileup
