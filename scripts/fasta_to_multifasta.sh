#!/bin/bash

mkdir multifasta/

echo "set the output file name:"

read output

cat *.fasta > multifasta/$output.fasta

echo ""$output".fasta was saved in directory multifasta/"
