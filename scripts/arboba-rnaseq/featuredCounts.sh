#!/bin/bash
nohup featureCounts -T 12 -s 2 -p -F GTF -a $HOME/datasets/arboba-rnaseq/refs/gencode.v31.chr_patch_hapl_scaff.annotation.gtf -o counts.txt *bam
#nohup: permite executar o comando em segundo plano
#-T: numero de threads utilizados para processar simultaneamente os processos da analise
#-s: realiza a contagem de acordo com a forma que as leituras foram geradas (0: unstranded; 1: stranded; 2: stranded reverso)
#-p: os fragmentos serao contados ao inves das leituras
#-F: formato do arquivo de anotacao dos transcritos do genoma referencia (GTF; SAF; GFF)
#-a: arquivo de anotacao dos transcritos do genoma referencia
#-o: nome do arquivo de saida com as contagem dos transcritos (delimitado por tabulaco)
#*bam: seleciona as amostras para a contagem
#counts.txt: arquivo de saida com a contagem dos transcritos de todas as amostras
#counts.txt.summary: arquivo de saida com o sumario da contagem dos transcritos de todas as amostras
