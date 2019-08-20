#!/bin/bash
echo '#!/bin/bash' >> trimmomatic_cmd.sh
for i in `ls -1 *R1*.fastq.gz | sed 's/\_R1.fastq.gz//'`
do echo nohup trimmomatic \
PE \
-phred33 \
-threads 12 \
$HOME/datasets/arboba-rnaseq/concatenated/$i\_R1.fastq.gz $HOME/datasets/arboba-rnaseq/concatenated/$i\_R2.fastq.gz $HOME/datasets/arboba-rnaseq/trimmed/$i\_R1_paired.fastq.gz $HOME/datasets/arboba-rnaseq/trimmed/$i\_R1_unpaired.fastq.gz $HOME/datasets/arboba-rnaseq/trimmed/$i\_R2_paired.fastq.gz $HOME/datasets/arboba-rnaseq/trimmed/$i\_R2_unpaired.fastq.gz \
ILLUMINACLIP:$HOME/softwares/miniconda3/envs/rna-seq/share/trimmomatic-0.39-1/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 \
>> trimmomatic_cmd.sh
done
#nohup: permite executar o comando em segundo plano
#PE: modo paired-end do trimmomatic
#-phred33: escala de qualidade utilizada pelas metodologias Sanger e Illumina 1.8+
#-threads: numero de threads utilizados para processar simultaneamente os processos da analise
#_R1.fastq.gz: arquivo de entrada com as leituras R1 da amostra
#_R2.fastq.gz: arquivo de entrada com as leituras R2 da amostra
#_R1_paired.fastq.gz: arquivo de saida para as leituras R1 que pareiam com as leituras R2
#_R1_unpaired.fastq.gz: arquivo de saida para as leituras R1 que NAO pareiam com as leituras R2
#_R2_paired.fastq.gz: arquivo de saida para as leituras R2 que pareiam com as leituras R1
#_R2_unpaired.fastq.gz: arquivo de saida para as leituras R2 que NAO pareiam com as leituras R1
#ILLUMINACLIP: identifica qual tipo de adaptador sera trimado
#LEADING: corta bases de nucleotideos no inicio das leituras, de acordo com a escala Q-score
#TRAILING corta bases de nucleotideos no final das leituras, de acordo com a escala Q-score
#SLIDINGWINDOW: estrategia de "janela deslizante" para varredura da leitura a partir da extremidade 5' para trimar as leituras, caso o Q-score seja menor que o estipulado
#MINLEN descarta leituras de acordo com o tamanho minimo definido
