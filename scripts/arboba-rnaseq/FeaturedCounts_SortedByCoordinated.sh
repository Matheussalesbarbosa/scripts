#!/bin/bash
nohup featureCounts -T 12 -s 2 -p -F GTF -a $HOME/datasets/arboba-rnaseq/gencode.v31.chr_patch_hapl_scaff.annotation.gtf -o arboba-rnaseq_counts_SortedByCoordinated.txt *bam
#-T: numero de threads utilizados para processar simultaneamente os processos da analise
#-s: realiza a contagem de acordo com a forma que as reads foram geradas (0: unstranded; 1: stranded; 2: stranded reverso)
#-p: os fragmentos serao contados ao inves das reads
#-F: formato do arquivo de anotacao dos transcritos do genoma referencia (GTF; SAF; GFF)
#-a: arquivo de anotacao dos transcritos do genoma referencia
#-o: nome do arquivo output com as contagem dos transcritos (delimitado por tabulaco)
#*bam: seleciona as amostras para a contagem
