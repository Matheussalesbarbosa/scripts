#!/bin/bash
echo '#!/bin/bash' >> trimmomatic_cmd.sh
for i in `ls -1 *R1*.fastq.gz | sed 's/\_R1.fastq.gz//'`
do echo nohup trimmomatic \
PE \
-phred33 \
-threads 12 \
$HOME/datasets/arboba-rnaseq/arboba-rnaseq_concatenated/$i\_R1.fastq.gz $HOME/datasets/arboba-rnaseq/arboba-rnaseq_concatenated/$i\_R2.fastq.gz $HOME/datasets/arboba-rnaseq/arboba-rnaseq_trimmed/$i\_R1_paired.fastq.gz $HOME/datasets/arboba-rnaseq/arboba-rnaseq_trimmed/$i\_R1_unpaired.fastq.gz $HOME/datasets/arboba-rnaseq/arboba-rnaseq_trimmed/$i\_R2_paired.fastq.gz $HOME/datasets/arboba-rnaseq/arboba-rnaseq_trimmed/$i\_R2_unpaired.fastq.gz \
ILLUMINACLIP:$HOME/softwares/miniconda3/envs/rna-seq/share/trimmomatic-0.39-1/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 \
>> trimmomatic_cmd.sh
done
#PE: modo paired-end do trimmomatic
#-phred33: escala de qualidade utilizada pelas metodologias Sanger e Illumina 1.8+
#-threads: numero de threads utilizados para processar simultaneamente os processos da analise
#R1.fastq.gz: arquivo de entrada (input) com as reads R1 da amostra
#R2.fastq.gz: arquivo input com as reads R2 da amostra
#R1_paired.fastq.gz: arquivo output para as reads R1 que pareiam com as reads R2
#R1_unpaired.fastq.gz: arquivo output para as reads R1 que NAO pareiam com as reads R2 (nao sera utilizado nas analises posteriores)
#R2_paired.fastq.gz: arquivo output para as reads R2 que pareiam com as reads R1
#R2_unpaired.fastq.gz: arquivo output para as reads R2 que NAO pareiam com as reads R1 (nao sera utilizado nas analises posteriores)
#ILLUMINACLIP: identifica qual tipo de adaptador sera trimado
#LEADING: corta bases de nucleotideos no inicio das reads, de acordo com a escala Q-score
#TRAILING corta bases de nucleotideos no final das reads, de acordo com a escala Q-score
#SLIDINGWINDOW: estrategia de "janela deslizante" para varredura da read a partir da extremidade 5' para trimar as leituras, caso o Q-score seja menor que o estipulado
#MINLEN descarta reads de acordo com o tamanho minimo definido
