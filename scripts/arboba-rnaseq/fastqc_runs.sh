#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/arboba-run1/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run1-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run2/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run2-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run3/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run3-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run4/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run4-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run5/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run5-fastQC/ --threads 12
#*.fastq.gz: seleciona os arquivos *.fastq.gz para a analise
#--outdir: diretorio para os arquivos de saida da analise (output)
#--threads: numero de threads utilizados para processar simultaneamente os processos da analise
