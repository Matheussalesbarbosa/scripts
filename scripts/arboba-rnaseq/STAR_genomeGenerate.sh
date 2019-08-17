#!/bin/bash
nohup STAR --runThreadN 12 --runMode genomeGenerate --genomeDir $HOME/datasets/arboba-rnaseq/arboba-rnaseq_index/ --genomeFastaFiles $HOME/datasets/arboba-rnaseq/GRCh38.p12.genome.fa
#--runThreadN: numero de threads utilizados para processar simultaneamente os processos da analise
#--runMode: tipo de funcionamento do STAR (genomeGenerate: gerar index; alignReads: mapear reads)
#--genomeDir: diretorio para armazenar os arquivos do index
#--genomeFastaFiles: arquivo do genoma referencia
