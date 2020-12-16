#!/bin/bash

THREADS="12"

RAWDIR="/path/directory/"
HACDEMUXDIR="/path/directory/"

REFSEQ=""
SAMPLEID=""

PLOIDY="" #1

source activate seq
minimap2 -ax map-ont -t ${THREADS} ${REFSEQ} ${SAMPLEID}.fastq | samtools sort -@ 12 -o ${SAMPLEID}.sorted.bam -
samtools view -h -F 4 -b ${SAMPLEID}.sorted.bam > ${SAMPLEID}.sorted.mapped.bam -@ 12
samtools index ${SAMPLEID}.sorted.mapped.bam -@ 12
nanopolish index -d ${RAWDIR} -s ${HACDEMUXDIR}/sequencing_summary.txt ${SAMPLEID}.fastq
[ ! -d "vcf" ] && mkdir -p vcf
nanopolish_makerange.py ${REFSEQ} --overlap-length -1 | parallel -P 1 nanopolish variants -t ${THREADS} -r ${SAMPLEID}.fastq -b ${SAMPLEID}.sorted.mapped.bam -o vcf/${SAMPLEID}.{#}.vcf -g ${REFSEQ} -w {1} -p ${PLOIDY} -v
ls vcf/*.vcf > ${SAMPLEID}.vcfList.txt
nanopolish vcf2fasta --skip-checks -g ${SAMPLEID}.fastq -f ${SAMPLEID}.vcfList.txt > ${SAMPLEID}.polished.fasta
minimap2 -ax map-ont -t ${THREADS} ${REFSEQ} ${SAMPLEID}.polished.fasta | samtools sort -@ 12 -o ${SAMPLEID}.polished.bam -
vcf-concat vcf/*.vcf | vcf-sort | bgzip -f > ${SAMPLEID}.vcf.gz
tabix -p vcf ${SAMPLEID}.vcf.gz
cat ${REFSEQ} | vcf-consensus ${SAMPLEID}.vcf.gz > ${SAMPLEID}.consensus.fasta
samtools coverage -q 5 ${SAMPLEID}.polished.bam > ${SAMPLEID}.coverage
samtools depth -q 5 ${SAMPLEID}.polished.bam > ${SAMPLEID}.depth
mkdir ${SAMPLEID}_RefGenAssembly && mv *.bai *.bam *.coverage *.depth *.fai *.fasta *.fastq *.gz *.gzi *.index *.out *.readdb *.sh *.tbi *.txt vcf ${SAMPLEID}_RefGenAssembly