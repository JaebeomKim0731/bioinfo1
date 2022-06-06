#!/bin/bash
pileup_list=$1
awk -F '\t' 'BEGIN{cnt=0; len_before=0; len_after=0}
{len_before=length($0);
 gsub("<","",$5);
 gsub(">","",$5);
 len_after=length($0);
 cnt = len_before - len_after;
 if(length($5) != 0) {print $1"\t"$2"\t"$3"\t"$4-cnt"\t"$5"\t"$6}
}' "${pileup_list}"


