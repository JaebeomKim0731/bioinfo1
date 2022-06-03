#!/bin/bash

awk -F "\t" '{if($3=="integral\ membrane"){print $1}}' mouselocalization-20210507.txt > integral_membrane_ensembl_list.txt
