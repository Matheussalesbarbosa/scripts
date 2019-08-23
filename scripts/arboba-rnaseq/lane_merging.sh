#!/bin/bash
for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)
do echo "sample $i R1 concatenated"
cat "$i"_L00*_R1_001.fastq.gz > "$i"_RUN0_R1_001.fastq.gz
echo "sample $i R2 concatenated"
cat "$i"_L00*_R2_001.fastq.gz > "$i"_RUN0_R2_001.fastq.gz
done