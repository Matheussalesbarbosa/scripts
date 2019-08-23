#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/align/
# gerar script para mapear o genoma referencia com as amostras
echo '#!/bin/bash' >> align_reads_cmd.sh
for i in `ls -1 *R1_paired*.fastq.gz | sed 's/\_R1_paired.fastq.gz//'`
do echo STAR \
--runThreadN 12 \
--runMode alignReads \
--genomeDir $HOME/datasets/arboba-rnaseq/index/ \
--sjdbGTFfile $HOME/datasets/arboba-rnaseq/refs/gencode.v31.chr_patch_hapl_scaff.annotation.gtf \
--readFilesIn $HOME/datasets/arboba-rnaseq/trimmed/$i\_R1_paired.fastq.gz $HOME/datasets/arboba-rnaseq/trimmed/$i\_R2_paired.fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix $HOME/datasets/arboba-rnaseq/align/$i\_ \
--outSAMtype BAM SortedByCoordinate \
--outReadsUnmapped Fastx \
>> align_reads_cmd.sh
done
#--runThreadN: numero de threads utilizados para processar simultaneamente os processos da analise
#--runMode: tipo de funcionamento do STAR (genomeGenerate: gerar indices; alignReads: mapear leituras)
#--genomeDir: diretorio dos arquivos do index
#--sjdbGTFfile: arquivo de anotacao dos transcritos do genoma referencia
#--readFilesIn: arquivos de entrada das leituras R1 e R2 paired da amostra
#--readFilesCommand: comando utilizado caso as leituras estejam compactadas (para arquivos *.gz, utilizar zcat; para *.bz2 utilizar bunzip2 -c)
#--outFileNamePrefix: determina o diretorio e o prefixo para nomear os arquivos de saida
#--outSAMtype: determina o tipo de arquivo de saida do mapeamento (padrao: SAM; BAM Unsorted: arquivo binario sem estar ordenado; BAM SortedByCoordinate: arquivo binario ordenado de acordo com a anotacao dos transcritos do genoma referencia)
#--outReadsUnmapped: determina que as leituras nao mapeadas gerem arquivos de saida
#_Aligned.sortedByCoord.out.bam: arquivo de saida do mapeamento da amostra
#_Log.final.out: arquivo de saida com o sumario da estatistica do mapeamento
#_Log.out: arquivo de saida com informacoes resumidas da estatistica do processo da analise de acordo com o progresso de cada etapa
#_Log.progress.out: arquivo de saida com informacoes e mensagens do processo de analise
#_SJ.out.tab: arquivo de saida com informacoes das juncoes de splicing
#_Unmapped.out.mate1`` arquivos de saida das leituras R1 nao mapeadas
#_Unmapped.out.mate2`` arquivos de saida das leituras R2 nao mapeadas
