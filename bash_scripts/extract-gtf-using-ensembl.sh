#!/bin/bash
ensemble_list=$1
gtf_file=$2

grep -f "${ensemble_list}" "${gtf_file}"

