#!/bin/bash

GTF=$1

awk -F "\t" '
BEGIN{gene = 0; trans = 0}	
{
if($3=="gene"){gene = 1; trans = 0}
else if($3=="transcript" && gene == 1) { trans = trans + 1; if (trans == 1) {print $0}}
else if(trans == 1) {print $0}
}' "${GTF}"
