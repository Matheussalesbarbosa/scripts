#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/index/
# construir os indices do genoma referencia
STAR \
--runThreadN 12 \
--runMode genomeGenerate \
--genomeDir $HOME/datasets/arboba-rnaseq/index/ \
--genomeFastaFiles $HOME/datasets/arboba-rnaseq/refs/GRCh38.p12.genome.fa
#--runThreadN: numero de threads utilizados para processar simultaneamente os processos da analise
#--runMode: tipo de funcionamento do STAR (genomeGenerate: gerar indices; alignReads: mapear leituras)
#--genomeDir: diretorio para armazenar os arquivos do index
#--genomeFastaFiles: arquivo do genoma referencia
