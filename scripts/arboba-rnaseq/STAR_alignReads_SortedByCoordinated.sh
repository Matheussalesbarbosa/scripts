#!/bin/bash
echo '#!/bin/bash' >> STAR_alignReads_SortedByCoordinated_cmd.sh
for i in `ls -1 *R1_paired*.fastq.gz | sed 's/\_R1_paired.fastq.gz//'`
do echo nohup STAR \
--runThreadN 12 \
--runMode alignReads \
--genomeDir $HOME/datasets/arboba-rnaseq/arboba-rnaseq_index/ \
--sjdbGTFfile $HOME/datasets/arboba-rnaseq/gencode.v31.chr_patch_hapl_scaff.annotation.gtf \
--readFilesIn $HOME/datasets/arboba-rnaseq/arboba-rnaseq_trimmed/$i\_R1_paired.fastq.gz $HOME/datasets/arboba-rnaseq/arboba-rnaseq_trimmed/$i\_R2_paired.fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix $i\_ \
--outSAMtype BAM SortedByCoordinate \
>> STAR_alignReads_SortedByCoordinated_cmd.sh
done
#--runThreadN: numero de threads utilizados para processar simultaneamente os processos da analise
#--runMode: tipo de funcionamento do STAR (genomeGenerate: gerar index; alignReads: mapear reads)
#--genomeDir: diretorio dos arquivos do index
#--sjdbGTFfile: arquivo de anotacao dos transcritos do genoma referencia
#--readFilesIn: arquivos input das reads R1 e R2 paired da amostra
#--readFilesCommand: comando utilizado caso as reads estejam compactadas (para arquivos *.gz, utilizar zcat; para *.bz2 utilizar bunzip2 -c)
#--outFileNamePrefix: prefixo para nomear os arquivos output
#--outSAMtype: determina o tipo de output do mapeamento (padrao: SAM; BAM Unsorted: arquivo binario sem estar ordenado; BAM SortedByCoordinate: arquivo binario ordenado de acordo com a anotacao dos transcritos do genoma referencia)
