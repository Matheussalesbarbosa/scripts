#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/
# checar qualidade das corridas
fastqc $HOME/datasets/arboba-rnaseq/concatenated/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/ --threads 12
#*.fastq.gz: seleciona os arquivos *.fastq.gz para a analise
#--outdir: diretorio para os arquivos de saida da analise (output)
#--threads: numero de threads utilizados para processar simultaneamente os processos da analise