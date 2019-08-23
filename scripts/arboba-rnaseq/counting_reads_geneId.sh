#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/counts/
# realizar contagem dos transcritos das amostras de acordo com o desenho experimental
featureCounts \
-a $HOME/datasets/arboba-rnaseq/refs/gencode.v31.chr_patch_hapl_scaff.annotation.gtf \
-C \
-F GTF \
-g gene_id \
-o $HOME/datasets/arboba-rnaseq/counts/counts.txt \
*bam \
-p \
-s 2 \
-T 12
#-a: arquivo de anotacao dos transcritos do genoma referencia
#-C: nao conta fragmentos quimericos
#-F: formato do arquivo de anotacao dos transcritos do genoma referencia (GTF; SAF; GFF)
#-g: especifica o atributo para nomear os genes (gene_id: Ensembl annotation; gene_name: gene symbol)
#-o: nome do arquivo de saida com as contagem dos transcritos (delimitado por tabulaco)
#counts.txt: arquivo de saida com a contagem dos transcritos de todas as amostras
#counts.txt.summary: arquivo de saida com o sumario da contagem dos transcritos de todas as amostras
#*bam: seleciona as amostras para a contagem
#-p: os fragmentos serao contados ao inves das leituras
#-s: realiza a contagem de acordo com a forma que as leituras foram geradas (0: unstranded; 1: stranded; 2: stranded reverso)
#-T: numero de threads utilizados para processar simultaneamente os processos da analise
