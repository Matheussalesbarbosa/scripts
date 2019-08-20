#!/bin/bash
nohup fastqc $HOME/datasets/arboba-rnaseq/run1/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r1/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run2/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r2/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run3/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r3/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run4/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r4/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run5/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r5/ --threads 12
#nohup: permite executar o comando em segundo plano
#*.fastq.gz: seleciona os arquivos *.fastq.gz para a analise
#--outdir: diretorio para os arquivos de saida da analise (output)
#--threads: numero de threads utilizados para processar simultaneamente os processos da analise
