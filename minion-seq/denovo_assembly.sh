#!/bin/bash

THREADS="12"

RAWDIR="/path/directory/"
HACDEMUXDIR="/path/directory/"

REFSEQ=""
SAMPLEID=""

GENOMESIZE="" #g|m|k
PLOIDY="" #1

source activate seq
canu -d canu -p ${SAMPLEID}.canu genomeSize=${GENOMESIZE} -nanopore ${SAMPLEID}.fastq correctedErrorRate=0.145 minReadLength=500 minInputCoverage=5 stopOnLowCoverage=5
minimap2 -x ava-ont -t ${THREADS} canu/${SAMPLEID}.canu.contigs.fasta ${SAMPLEID}.fastq > ${SAMPLEID}.paf
racon -t ${THREADS} ${SAMPLEID}.fastq ${SAMPLEID}.paf canu/${SAMPLEID}.canu.contigs.fasta > ${SAMPLEID}.racon.contigs.fasta
minimap2 -ax map-ont -t ${THREADS} ${SAMPLEID}.racon.contigs.fasta ${SAMPLEID}.fastq | samtools sort -@ 12 -o ${SAMPLEID}.racon.sorted.bam -
samtools index ${SAMPLEID}.racon.sorted.bam -@ 12
nanopolish index -d ${RAWDIR} -s ${HACDEMUXDIR}sequencing_summary.txt ${SAMPLEID}.fastq
[ ! -d "vcf" ] && mkdir -p vcf
nanopolish_makerange.py ${SAMPLEID}.racon.contigs.fasta --overlap-length -1 | parallel -P 1 nanopolish variants -t ${THREADS} -r ${SAMPLEID}.fastq -b ${SAMPLEID}.racon.sorted.bam -o vcf/${SAMPLEID}.{#}.vcf -g ${SAMPLEID}.racon.contigs.fasta -w {1} -p ${PLOIDY} -v
ls vcf/*.vcf > ${SAMPLEID}.vcfList.txt
nanopolish vcf2fasta --skip-checks -g ${SAMPLEID}.racon.contigs.fasta -f ${SAMPLEID}.vcfList.txt > ${SAMPLEID}.nanopolish.contigs.fasta
ragtag.py correct -t ${THREADS} -o ragtag ${REFSEQ} ${SAMPLEID}.nanopolish.contigs.fasta
ragtag.py scaffold -t ${THREADS} -o ragtag ${REFSEQ} ragtag/query.corrected.fasta
mkdir ${SAMPLEID}_DeNovoAssembly && mv *.bai *.bam *.fai *.fasta *.fastq *.gzi *.index *.out *.paf *.readdb *.txt canu ragtag vcf ${SAMPLEID}_RefGenAssembly