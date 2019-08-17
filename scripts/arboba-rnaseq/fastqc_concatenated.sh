#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq-fastQC/ --threads 12
#*.fastq.gz: seleciona os arquivos *.fastq.gz para a analise
#--outdir: diretorio para os arquivos de saida da analise (output)
#--threads: numero de threads utilizados para processar simultaneamente os processos da analise
