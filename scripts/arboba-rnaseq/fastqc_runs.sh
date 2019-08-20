#!/bin/bash
nohup fastqc $HOME/datasets/arboba-rnaseq/run1/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run1/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run2/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run2/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run3/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run3/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run4/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run4/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run5/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run5/ --threads 12
#nohup: permite executar o comando em segundo plano
#*.fastq.gz: seleciona os arquivos *.fastq.gz para a analise
#--outdir: diretorio para os arquivos de saida da analise (output)
#--threads: numero de threads utilizados para processar simultaneamente os processos da analise
