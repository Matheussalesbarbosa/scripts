#!/bin/bash

for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 13- | rev; done | sort | uniq);

do
/$HOME/softwares/salmon-0.14.0/bin/salmon quant -i *_index \
    -l A \
    -1 "$i"_R1.fastq.gz \
    -2 "$i"_R2.fastq.gz \
    -p 20 \
    --seqBias \
    --useVBOpt \
    --validateMappings \
    -o arboba_quant/"$i"_quant_woGTF/

done
