#!/bin/bash
id_list=$1
gtf=$2

awk '{print $0}' $id_list | while read -r id; do
	grep "${id}" $gtf | awk -F '\t' '{if($3 == "transcript" || $3 == "CDS" || $3 == "UTR") print $0}' > "${id}.gtf" 
done

