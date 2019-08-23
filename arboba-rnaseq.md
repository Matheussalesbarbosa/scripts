## RNA-Seq "ArbovirusFiocruzBA"

### Ambiente de trabalho
<br/>

A análise de RNA-seq será disposta de acordo com o proposto:
```
.
└── $HOME
    ├── datasets
        └── arboba-rnaseq
            ├── align
                ├── align-c
                ├── align-d
                ├── align-dc
                ├── align-dz
                ├── align-z
                └── align-zc
            ├── concatenated
            ├── counts
                ├── counts-c
                ├── counts-d
                └── counts-z
            ├── index
            ├── qc
                ├── qc-concatenated
                ├── qc-r1
                ├── qc-r2
                ├── qc-r3
                ├── qc-r4
                └── qc-r5
            ├── refs
            ├── run1
            ├── run2
            ├── run3
            ├── run4
            ├── run5
            └── trimmed
└── softwares
        └── miniconda3
```
- ``$HOME/datasets/`` datasets para análises
- ``$HOME/datasets/arboba-rnaseq`` análise do "ArbovirusFiocruzBA"
- ``$HOME/datasets/arboba-rnaseq/align`` leituras mapeadas com o genoma humano de referência GRCh38.p12
- ``$HOME/datasets/arboba-rnaseq/align/align-c`` leituras mapeadas para CHIKV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/align/align-d`` leituras mapeadas para DENV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/align/align-dc`` leituras mapeadas para DENV vs. CHIKV
- ``$HOME/datasets/arboba-rnaseq/align/align-dz`` leituras mapeadas para DENV vs. ZIKV
- ``$HOME/datasets/arboba-rnaseq/align/align-z``leituras mapeadas para ZIKV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/align/align-zc``leituras mapeadas para ZIKV vs. CHIKV
- ``$HOME/datasets/arboba-rnaseq/concatenated`` leituras concatenadas
- ``$HOME/datasets/arboba-rnaseq/counts`` contagem dos genes
- ``$HOME/datasets/arboba-rnaseq/counts/counts-c`` contagem dos genes de CHIKV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/counts/counts-d`` contagem dos genes de DENV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/counts/counts-z`` contagem dos genes de ZIKV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/index`` índices do genoma humano de referência GRCh38.p12
- ``$HOME/datasets/arboba-rnaseq/qc`` dados de qualidade
- ``$HOME/datasets/arboba-rnaseq/qc/qc-concatenated`` dados de qualidade das corridas concatenadas
- ``$HOME/datasets/arboba-rnaseq/qc/qc-r1`` dados de qualidade da corrida 1 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-r2`` dados de qualidade da corrida 2 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-r3`` dados de qualidade da corrida 3 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-r4`` dados de qualidade da corrida 4 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-r5`` dados de qualidade da corrida 5 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/refs`` arquivos do genoma humano de referência GRCh38.p12
- ``$HOME/datasets/arboba-rnaseq/run1`` diretório temporário para a corrida 1 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/run2`` diretório temporário para a corrida 2 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/run3`` diretório temporário para a corrida 3 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/run4`` diretório temporário para a corrida 4 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/run5`` diretório temporário para a corrida 5 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/trimmed`` leituras após filtragem de qualidade
- ``$HOME/softwares/`` aplicações instaladas
---

### Criar ambiente de aplicações para análise de RNA-Seq
<br/>

Instalar última versão do *Miniconda*
```sh
curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh --output $HOME/softwares/miniconda3.sh
bash $HOME/softwares/miniconda3.sh -bfp $HOME/softwares/miniconda3 && rm --recursive --force $HOME/softwares/miniconda3.sh
echo 'export PATH="$HOME/softwares/miniconda3/bin:/usr/local/share/rsi/idl/bin:$PATH"' >> $HOME/.bashrc
```
<br/>

Criar ambiente nomeado "rna-seq"
```sh
conda create --name rna-seq
```
- ``create`` cria ambiente para instalar uma lista específica de pacotes (packages)
- ``--name`` nome do ambiente
<br/>

Ativar "rna-seq"
```sh
source activate rna-seq
```
<br/>

Instalar aplicações no "rna-seq"
```sh
conda install --name rna-seq --channel bioconda fastqc multiqc trimmomatic star subread
```
- ``install`` instala uma lista de pacotes
- ``--name`` nome do ambiente
- ``--channel`` canal do pacote a ser instalado (site para buscar pacotes: https://anaconda.org/search)
<br/>

Desativar "rna-seq"
```sh
conda deactivate
```
---

### Organizar dados brutos do RNA-Seq
<br/>

Copiar os diretórios das 5 corridas no workstation
- Cada corrida tem 544 lanes totais, dispostas em diretório com 2 lanes de uma única amostra, cada lane contém leituras pareadas R1 e R2
```
.
└── $HOME
    └── datasets
        └── arboba-rnaseq
            └── ArbovirusFiocruzBA-83677594 (n=2720)
                ├── FASTQ_Generation_2018-08-17_15_33_27Z-116577544 (n=544)
                        └── 1_1_L001-ds.901a0121cf82438fb90c16ce58350a12 (n=2)
                            ├── 193_S11_L001_R1_001.fastq.gz
                            └── 193_S11_L001_R2_001.fastq.gz
                ├── FASTQ_Generation_2018-10-17_13_51_20Z-130391988
                ├── FASTQ_Generation_2018-12-11_13_17_10Z-141945716
                ├── FASTQ_Generation_2018-12-13_14_45_41Z-143225097
                └── FASTQ_Generation_2018-12-15_10_26_29Z-143716575
```
<br/>

Organizar os diretórios por corrida (run1, run2, run3, run4, run5)
- script: [sorting_raw_reads.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/sorting_raw_reads.sh)
```sh
#!/bin/bash
# criar diretorios
mkdir $HOME/datasets/arboba-rnaseq/ && \
mkdir $HOME/datasets/arboba-rnaseq/run1/ && \
mkdir $HOME/datasets/arboba-rnaseq/run2/ && \
mkdir $HOME/datasets/arboba-rnaseq/run3/ && \
mkdir $HOME/datasets/arboba-rnaseq/run4/ && \
mkdir $HOME/datasets/arboba-rnaseq/run5/
# copiar as lanes para diretorios de cada corrida (run1, run2, run3, run4, run5)
find $HOME/datasets/FASTQ_Generation_2018-08-17_15_33_27Z-116577544/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run1/ {} +
find $HOME/datasets/FASTQ_Generation_2018-10-17_13_51_20Z-130391988/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run2/ {} +
find $HOME/datasets/FASTQ_Generation_2018-12-11_13_17_10Z-141945716/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run3/ {} +
find $HOME/datasets/FASTQ_Generation_2018-12-13_14_45_41Z-143225097/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run4/ {} +
find $HOME/datasets/FASTQ_Generation_2018-12-15_10_26_29Z-143716575/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run5/ {} +
```
---

### Organizar as lanes por corrida (run1, run2, run3, run4, run5)
<br/>

Concatenar as lanes
- script: [lane_merging.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/lane_merging.sh)
```sh
#!/bin/bash
for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)
do echo "sample $i R1 concatenated"
cat "$i"_L00*_R1_001.fastq.gz > "$i"_RUN0_R1_001.fastq.gz
echo "sample $i R2 concatenated"
cat "$i"_L00*_R2_001.fastq.gz > "$i"_RUN0_R2_001.fastq.gz
done
```
---

### Checar qualidade das corridas
<br/>

Realizar análise de qualidade utilizando a ferramenta *fastQC*
- script: [quality_check_runs.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/quality_check_runs.sh)
```sh
#!/bin/bash
# criar diretorios
mkdir $HOME/datasets/arboba-rnaseq/qc/ && \
mkdir $HOME/datasets/arboba-rnaseq/qc/qc-r1/ && \
mkdir $HOME/datasets/arboba-rnaseq/qc/qc-r2/ && \
mkdir $HOME/datasets/arboba-rnaseq/qc/qc-r3/ && \
mkdir $HOME/datasets/arboba-rnaseq/qc/qc-r4/ && \
mkdir $HOME/datasets/arboba-rnaseq/qc/qc-r5/
# checar qualidade das corridas
fastqc $HOME/datasets/arboba-rnaseq/run1/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r1/ --threads 12
fastqc $HOME/datasets/arboba-rnaseq/run2/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r2/ --threads 12
fastqc $HOME/datasets/arboba-rnaseq/run3/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r3/ --threads 12
fastqc $HOME/datasets/arboba-rnaseq/run4/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r4/ --threads 12
fastqc $HOME/datasets/arboba-rnaseq/run5/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-r5/ --threads 12
```
- ``*.fastq.gz`` seleciona os arquivos *.fastq.gz para a análise
- ``--outdir`` diretório para os arquivos de saída da análise (output)
- ``--threads`` número de threads utilizados para processar simultaneamente os processos da análise
<br/>

Agregar resultados de qualidade utilizando a ferramenta *multiQC*
- script: [summary_qc_runs.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/summary_qc_runs.sh)
```sh
#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/qc/qc-r1/ && \
multiqc --fullnames --title ArbovirusBahiaRun1 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-r1/
cd $HOME/datasets/arboba-rnaseq/qc/qc-r2/ && \
multiqc --fullnames --title ArbovirusBahiaRun2 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-r2/
cd $HOME/datasets/arboba-rnaseq/qc/qc-r3/ && \
multiqc --fullnames --title ArbovirusBahiaRun3 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-r3/
cd $HOME/datasets/arboba-rnaseq/qc/qc-r4/ && \
multiqc --fullnames --title ArbovirusBahiaRun4 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-r4/
cd $HOME/datasets/arboba-rnaseq/qc/qc-r5/ && \
multiqc --fullnames --title ArbovirusBahiaRun5 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-r5/
```
- ``--fullnames`` mantém o nome do arquivo que vai ser analisado
- ``--title`` cria um título para o relatório do multiqc
- ``--interactive`` utiliza plots iterativos
- ``--export`` exporta plots das análises do multiqc
---

### Organizar as leituras como um único experimento
<br/>

Organizar as leituras das corrida em um único diretório
- script: [sorting_concatenated_run.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/sorting_concatenated_run.sh)
```sh
#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/concatenated
# copiar as lanes para diretorios de cada corrida (run1, run2, run3, run4, run5)
find $HOME/datasets/arboba-rnaseq/run -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/concatenated {} +
```
<br/>

Concatenar as corridas
- script: [runs_merging.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/runs_merging.sh)
```sh
#!/bin/bash
for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)
do echo "sample $i R1 concatenated"
cat "$i"_RUN*_R1_001.fastq.gz > "$i"_R1.fastq.gz
echo "sample $i R2 concatenated"
cat "$i"_RUN*_R2_001.fastq.gz > "$i"_R2.fastq.gz
done
```
---

### Checar qualidade do experimento
<br/>

Realizar análise de qualidade utilizando a ferramenta *fastQC*
- script: [quality_check_concatenated_run.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/quality_check_concatenated_run.sh)
```sh
#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/
# checar qualidade das corridas
fastqc $HOME/datasets/arboba-rnaseq/concatenated/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/ --threads 12
```
- ``*.fastq.gz`` seleciona os arquivos *.fastq.gz para a análise
- ``--outdir`` diretório para os arquivos de saída da análise
- ``--threads`` número de threads utilizados para processar simultaneamente os processos da análise
<br/>

Agregar resultados de qualidade utilizando a ferramenta *multiQC*
- script: [summary_qc_concatenated_run.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/summary_qc_concatenated_run.sh)
```sh
#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/ && \
multiqc --fullnames --title ArbovirusBahiaRNASeq --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/
```
- ``--fullnames`` mantém o nome do arquivo que vai ser analisado
- ``--title`` cria um título para o relatório do multiqc
- ``--interactive`` utiliza plots iterativos
- ``--export`` exporta plots das análises do multiqc
---

### Filtrar e cortar as leituras de baixa qualidade
<br/>

Gerar script para a filtrar e cortar as leituras de baixa qualidade
- script: [trimming_reads.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/trimming_reads.sh)
```sh
#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/trimmed/
# gerar script para filtrar e cortar as leituras de baixa qualidade
echo '#!/bin/bash' >> trimming_reads_cmd.sh
for i in `ls -1 *R1*.fastq.gz | sed 's/\_R1.fastq.gz//'`
do echo trimmomatic \
PE \
-phred33 \
-threads 12 \
$HOME/datasets/arboba-rnaseq/concatenated/$i\_R1.fastq.gz \
$HOME/datasets/arboba-rnaseq/concatenated/$i\_R2.fastq.gz \
$HOME/datasets/arboba-rnaseq/trimmed/$i\_R1_paired.fastq.gz \
$HOME/datasets/arboba-rnaseq/trimmed/$i\_R1_unpaired.fastq.gz \
$HOME/datasets/arboba-rnaseq/trimmed/$i\_R2_paired.fastq.gz \
$HOME/datasets/arboba-rnaseq/trimmed/$i\_R2_unpaired.fastq.gz \
ILLUMINACLIP:$HOME/softwares/miniconda3/envs/rna-seq/share/trimmomatic-0.39-1/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 \
>> trimming_reads_cmd.sh
done
```
- ``PE`` modo paired-end do trimmomatic
- ``-phred33`` escala de qualidade utilizada pelas metodologias Sanger e Illumina 1.8+
- ``-threads`` número de threads utilizados para processar simultaneamente os processos da análise
- ``_R1.fastq.gz`` arquivo de entrada com as leituras R1 da amostra
- ``_R2.fastq.gz`` arquivo de entrada com as leituras R2 da amostra
- ``_R1_paired.fastq.gz`` arquivo de saída para as leituras R1 que pareiam com as leituras R2
- ``_R1_unpaired.fastq.gz`` arquivo de saída para as leituras R1 que NÃO pareiam com as leituras R2
- ``_R2_paired.fastq.gz`` arquivo de saída para as leituras R2 que pareiam com as leituras R1
- ``_R2_unpaired.fastq.gz`` arquivo de saída para as leituras R2 que NÃO pareiam com as leituras R1
- ``ILLUMINACLIP`` identifica qual tipo de adaptador será trimado
- ``LEADING`` corta bases de nucleotídeos no início das leituras, de acordo com a escala Q-score (https://www.drive5.com/usearch/manual/quality_score.html)
- ``TRAILING`` corta bases de nucleotídeos no final das leituras, de acordo com a escala Q-score (https://www.drive5.com/usearch/manual/quality_score.html)
- ``SLIDINGWINDOW`` estratégia de "janela deslizante" para varredura da leitura a partir da extremidade 5' para trimar as leituras, caso o Q-score seja menor que o estipulado
- ``MINLEN`` descarta leituras de acordo com o tamanho mínimo definido
<br/>

Filtrar e cortar as leituras de baixa qualidade utilizando a ferramenta *trimmomatic*
```sh
bash trimming_reads_cmd.sh
```
---

### Mapeamento do genoma humano de referência com as amostras
<br/>

Obter arquivos do genoma humano de referência GRCh38.p12 no portal GENCODE (https://www.gencodegenes.org/human/)
```sh

curl ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/GRCh38.p12.genome.fa.gz --output $HOME/datasets/arboba-rnaseq/refs/GRCh38.p12.genome.fa.gz
curl ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz --output $HOME/datasets/arboba-rnaseq/refs/gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz
```
- ``GRCh38.p12.genome.fa.gz`` genoma humano de referência GRCh38.p12
- ``gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz`` anotação do genoma humano de referência GRCh38.p12
```
.
└── $HOME
    ├── datasets
        └── arboba-rnaseq
            ├── refs
                ├── GRCh38.p12.genome.fa.gz
                └── gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz
```
<br/>

Descompactar arquivos do genoma humano de referência GRCh38.p122
```sh
gunzip --decompress $HOME/datasets/arboba-rnaseq/GRCh38.p12.genome.fa.gz
gunzip --decompress $HOME/datasets/arboba-rnaseq/gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz
```
<br/>

Construir os índices do genoma humano de referência GRCh38.p12 utilizando a ferramenta *STAR*
- script: [genome_index.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/genome_index.sh)
```sh
#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/index/
# construir os indices do genoma referencia
STAR \
--runThreadN 12 \
--runMode genomeGenerate \
--genomeDir $HOME/datasets/arboba-rnaseq/index/ \
--genomeFastaFiles $HOME/datasets/arboba-rnaseq/refs/GRCh38.p12.genome.fa
```
- ``--runThreadN`` número de threads utilizados para processar simultaneamente os processos da análise
- ``--runMode`` tipo de funcionamento do STAR (genomeGenerate: gerar índices; alignReads: mapear leituras)
- ``--genomeDir`` diretório para armazenar os arquivos do index
- ``--genomeFastaFiles`` arquivo do genoma referência em *.fasta
<br/>

Gerar script para mapear o genoma referência GRCh38.p12 com as amostras
- script: [align_reads.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/align_reads.sh)
```sh
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
```
- ``--runThreadN`` número de threads utilizados para processar simultaneamente os processos da análise
- ``--runMode`` tipo de funcionamento do STAR (genomeGenerate: gerar índices; alignReads: mapear leituras)
- ``--genomeDir`` diretório dos arquivos do index
- ``--sjdbGTFfile`` arquivo de anotação dos transcritos do genoma referência
- ``--readFilesIn`` arquivos de entrada das leituras R1 e R2 paired da amostra
- ``--readFilesCommand`` comando utilizado caso as leituras estejam compactadas (para arquivos *.gz, utilizar zcat; para *.bz2 utilizar bunzip2 -c)
- ``--outFileNamePrefix`` determina o diretório e o prefixo para nomear os arquivos de saída
- ``--outSAMtype`` determina o tipo de arquivo de sada do mapeamento (padrão: SAM; BAM Unsorted: arquivo binário sem estar ordenado; BAM SortedByCoordinate: arquivo binário ordenado de acordo com a anotação dos transcritos do genoma referência)
- ``--outReadsUnmapped`` determina que as leituras não mapeadas gerem arquivos de saída 
- ``_Aligned.sortedByCoord.out.bam`` arquivo de saída do mapeamento da amostra
- ``_Log.final.out`` arquivo de saída com o sumário da estatística do mapeamento
- ``_Log.out`` arquivo de saída com informações resumidas da estatística do processo da análise de acordo com o progresso de cada etapa
- ``_Log.progress.out`` arquivo de saída com informações e mensagens do processo de análise
- ``_SJ.out.tab`` arquivo de saída com informações das junções de splicing
- ``_Unmapped.out.mate1`` arquivos de saída das leituras R1 não mapeadas
- ``_Unmapped.out.mate2`` arquivos de saída das leituras R2 não mapeadas
<br/>

Mapear o genoma referência GRCh38.p12 para cada amostra utilizando a ferramenta *STAR*
```sh
bash align_reads_cmd.sh
```
---

### Definir os desenhos esperimentais para a contagem de leituras
<br/>

Definir os desenhos experimentais

| amostras | grupo | total |
| --- | --- | --- |
| ZK0041_S23, ZK0043_S65, ZK0046_S2, ZK0048_S32, ZK0049_S34, ZK0066_S1, ZK0085_S31, ZK0087_S16, ZK0088_S30, ZK0094_S52, ZK0104_S27, ZK0126_S19, ZK0129_S63, ZK0130_S22, ZK0134_S15, ZK0135_S3, ZK0137_S60, ZK0140_S43, ZK0143_S21, ZK0145_S12, ZK0160_S10, ZK0162_S29, ZK0170_S68, ZK0171_S46, ZK0172_S7, ZK0180_S6, ZK0182_S41, ZK0185_S54, ZK0187_S55, ZK0188_S26, ZK0191_S45, ZK0193_S17, ZK0194_S67, ZK0195_S28, ZK0196_S59, ZK0198_S44, ZK0202_S14 | chikv | 37 |
| ZK0214_S9, ZK0215_S58, ZK0219_S24, ZK0361_S51, ZK0362_S50, ZK0363_S25, ZK0364_S13, ZK0365_S39, ZK0366_S40 | controle | 9 |
<br/>

| amostras | grupo | total |
| --- | --- | --- |
| 2137_S38, 2167_S48, 2173_S42, 3051_S66, 3053_S47, 4171_S57, 4175_S37, 4230_S5 | denvv | 8 |
| ZK0214_S9, ZK0215_S58, ZK0219_S24, ZK0361_S51, ZK0362_S50, ZK0363_S25, ZK0364_S13, ZK0365_S39, ZK0366_S40 | controle | 9 |
<br/>

| amostras | grupo | total |
| --- | --- | --- |
| 2137_S38, 2167_S48, 2173_S42, 3051_S66, 3053_S47, 4171_S57, 4175_S37, 4230_S5 | denvv | 8 |
| ZK0041_S23, ZK0043_S65, ZK0046_S2, ZK0048_S32, ZK0049_S34, ZK0066_S1, ZK0085_S31, ZK0087_S16, ZK0088_S30, ZK0094_S52, ZK0104_S27, ZK0126_S19, ZK0129_S63, ZK0130_S22, ZK0134_S15, ZK0135_S3, ZK0137_S60, ZK0140_S43, ZK0143_S21, ZK0145_S12, ZK0160_S10, ZK0162_S29, ZK0170_S68, ZK0171_S46, ZK0172_S7, ZK0180_S6, ZK0182_S41, ZK0185_S54, ZK0187_S55, ZK0188_S26, ZK0191_S45, ZK0193_S17, ZK0194_S67, ZK0195_S28, ZK0196_S59, ZK0198_S44, ZK0202_S14 | chikv | 37 |
<br/>

| amostras | grupo | total |
| --- | --- | --- |
| 2137_S38, 2167_S48, 2173_S42, 3051_S66, 3053_S47, 4171_S57, 4175_S37, 4230_S5 | denvv | 8 |
| 140_S33, 193_S11, 200_S18, 210_S62, 225_S20, 227_S49, 241_S53, 39_S35, ZK0099_S64, ZK0110_S8, ZK0111_S61, ZK0128_S36 | zikv | 12 |
<br/>

| amostras | grupo | total |
| --- | --- | --- |
| 140_S33, 193_S11, 200_S18, 210_S62, 225_S20, 227_S49, 241_S53, 39_S35, ZK0099_S64, ZK0110_S8, ZK0111_S61, ZK0128_S36 | zikv | 12 |
| ZK0214_S9, ZK0215_S58, ZK0219_S24, ZK0361_S51, ZK0362_S50, ZK0363_S25, ZK0364_S13, ZK0365_S39, ZK0366_S40 | controle | 9 |
<br/>

| amostras | grupo | total |
| --- | --- | --- |
| 140_S33, 193_S11, 200_S18, 210_S62, 225_S20, 227_S49, 241_S53, 39_S35, ZK0099_S64, ZK0110_S8, ZK0111_S61, ZK0128_S36 | zikv | 12 |
| ZK0041_S23, ZK0043_S65, ZK0046_S2, ZK0048_S32, ZK0049_S34, ZK0066_S1, ZK0085_S31, ZK0087_S16, ZK0088_S30, ZK0094_S52, ZK0104_S27, ZK0126_S19, ZK0129_S63, ZK0130_S22, ZK0134_S15, ZK0135_S3, ZK0137_S60, ZK0140_S43, ZK0143_S21, ZK0145_S12, ZK0160_S10, ZK0162_S29, ZK0170_S68, ZK0171_S46, ZK0172_S7, ZK0180_S6, ZK0182_S41, ZK0185_S54, ZK0187_S55, ZK0188_S26, ZK0191_S45, ZK0193_S17, ZK0194_S67, ZK0195_S28, ZK0196_S59, ZK0198_S44, ZK0202_S14 | chikv | 37 |
<br/>

Organizar as leituras mapeadas de acordo com o desenho experimental
- script: [sorting_mapped_reads.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/sorting_mapped_reads.sh)
```sh
#!/bin/bash
# criar diretorios
mkdir $HOME/datasets/arboba-rnaseq/align/align-c/ && \
mkdir $HOME/datasets/arboba-rnaseq/align/align-d/ && \
mkdir $HOME/datasets/arboba-rnaseq/align/align-dc/ && \
mkdir $HOME/datasets/arboba-rnaseq/align/align-dz/ && \
mkdir $HOME/datasets/arboba-rnaseq/align/align-z/ && \
mkdir $HOME/datasets/arboba-rnaseq/align/align-zc/
# copiar amostras mapeadas *.bam para cada pasta de acordo com o desenho experimental
cp ZK0041_S23*.bam ZK0043_S65*.bam ZK0046_S2*.bam ZK0048_S32*.bam ZK0049_S34*.bam ZK0066_S1*.bam ZK0085_S31*.bam ZK0087_S16*.bam ZK0088_S30*.bam ZK0094_S52*.bam ZK0104_S27*.bam ZK0126_S19*.bam ZK0129_S63*.bam ZK0130_S22*.bam ZK0134_S15*.bam ZK0135_S3*.bam ZK0137_S60*.bam ZK0140_S43*.bam ZK0143_S21*.bam ZK0145_S12*.bam ZK0160_S10*.bam ZK0162_S29*.bam ZK0170_S68*.bam ZK0171_S46*.bam ZK0172_S7*.bam ZK0180_S6*.bam ZK0182_S41*.bam ZK0185_S54*.bam ZK0187_S55*.bam ZK0188_S26*.bam ZK0191_S45*.bam ZK0193_S17*.bam ZK0194_S67*.bam ZK0195_S28*.bam ZK0196_S59*.bam ZK0198_S44*.bam ZK0202_S14*.bam \
ZK0214_S9*.bam ZK0215_S58*.bam ZK0219_S24*.bam ZK0361_S51*.bam ZK0362_S50*.bam ZK0363_S25*.bam ZK0364_S13*.bam ZK0365_S39*.bam ZK0366_S40*.bam \
$HOME/datasets/arboba-rnaseq/align/align-c/
cp 2137_S38*.bam 2167_S48*.bam 2173_S42*.bam 3051_S66*.bam 3053_S47*.bam 4171_S57*.bam 4175_S37*.bam 4230_S5*.bam \
ZK0214_S9*.bam ZK0215_S58*.bam ZK0219_S24*.bam ZK0361_S51*.bam ZK0362_S50*.bam ZK0363_S25*.bam ZK0364_S13*.bam ZK0365_S39*.bam ZK0366_S40*.bam \
$HOME/datasets/arboba-rnaseq/align/align-d/
cp 2137_S38*.bam 2167_S48*.bam 2173_S42*.bam 3051_S66*.bam 3053_S47*.bam 4171_S57*.bam 4175_S37*.bam 4230_S5*.bam \
ZK0041_S23*.bam ZK0043_S65*.bam ZK0046_S2*.bam ZK0048_S32*.bam ZK0049_S34*.bam ZK0066_S1*.bam ZK0085_S31*.bam ZK0087_S16*.bam ZK0088_S30*.bam ZK0094_S52*.bam ZK0104_S27*.bam ZK0126_S19*.bam ZK0129_S63*.bam ZK0130_S22*.bam ZK0134_S15*.bam ZK0135_S3*.bam ZK0137_S60*.bam ZK0140_S43*.bam ZK0143_S21*.bam ZK0145_S12*.bam ZK0160_S10*.bam ZK0162_S29*.bam ZK0170_S68*.bam ZK0171_S46*.bam ZK0172_S7*.bam ZK0180_S6*.bam ZK0182_S41*.bam ZK0185_S54*.bam ZK0187_S55*.bam ZK0188_S26*.bam ZK0191_S45*.bam ZK0193_S17*.bam ZK0194_S67*.bam ZK0195_S28*.bam ZK0196_S59*.bam ZK0198_S44*.bam ZK0202_S14*.bam \
$HOME/datasets/arboba-rnaseq/align/align-dc/
cp 2137_S38*.bam 2167_S48*.bam 2173_S42*.bam 3051_S66*.bam 3053_S47*.bam 4171_S57*.bam 4175_S37*.bam 4230_S5*.bam \
140_S33*.bam 193_S11*.bam 200_S18*.bam 210_S62*.bam 225_S20*.bam 227_S49*.bam 241_S53*.bam 39_S35*.bam ZK0099_S64*.bam ZK0110_S8*.bam ZK0111_S61*.bam ZK0128_S36*.bam \
$HOME/datasets/arboba-rnaseq/align/align-dz/
cp 140_S33*.bam 193_S11*.bam 200_S18*.bam 210_S62*.bam 225_S20*.bam 227_S49*.bam 241_S53*.bam 39_S35*.bam ZK0099_S64*.bam ZK0110_S8*.bam ZK0111_S61*.bam ZK0128_S36*.bam \
ZK0214_S9*.bam ZK0215_S58*.bam ZK0219_S24*.bam ZK0361_S51*.bam ZK0362_S50*.bam ZK0363_S25*.bam ZK0364_S13*.bam ZK0365_S39*.bam ZK0366_S40*.bam \
$HOME/datasets/arboba-rnaseq/align/align-z/
cp 140_S33*.bam 193_S11*.bam 200_S18*.bam 210_S62*.bam 225_S20*.bam 227_S49*.bam 241_S53*.bam 39_S35*.bam ZK0099_S64*.bam ZK0110_S8*.bam ZK0111_S61*.bam ZK0128_S36*.bam \
ZK0041_S23*.bam ZK0043_S65*.bam ZK0046_S2*.bam ZK0048_S32*.bam ZK0049_S34*.bam ZK0066_S1*.bam ZK0085_S31*.bam ZK0087_S16*.bam ZK0088_S30*.bam ZK0094_S52*.bam ZK0104_S27*.bam ZK0126_S19*.bam ZK0129_S63*.bam ZK0130_S22*.bam ZK0134_S15*.bam ZK0135_S3*.bam ZK0137_S60*.bam ZK0140_S43*.bam ZK0143_S21*.bam ZK0145_S12*.bam ZK0160_S10*.bam ZK0162_S29*.bam ZK0170_S68*.bam ZK0171_S46*.bam ZK0172_S7*.bam ZK0180_S6*.bam ZK0182_S41*.bam ZK0185_S54*.bam ZK0187_S55*.bam ZK0188_S26*.bam ZK0191_S45*.bam ZK0193_S17*.bam ZK0194_S67*.bam ZK0195_S28*.bam ZK0196_S59*.bam ZK0198_S44*.bam ZK0202_S14*.bam \
$HOME/datasets/arboba-rnaseq/align/align-zc/
```
---

### Contar as leituras das amostras
<br/>

Realizar contagem dos transcritos das amostras para cada desenho experimental
```sh
#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/counts/
# realizar contagem dos transcritos das amostras de acordo com o desenho experimental
featureCounts \
-a $HOME/datasets/arboba-rnaseq/refs/gencode.v31.chr_patch_hapl_scaff.annotation.gtf \
-F GTF \
-g gene_id gene_name \
-o $HOME/datasets/arboba-rnaseq/counts/counts.txt
*bam \
-p \
-s 2 \
-T 12
#-a: arquivo de anotacao dos transcritos do genoma referencia
#-F: formato do arquivo de anotacao dos transcritos do genoma referencia (GTF; SAF; GFF)
#-g: especifica o atributo para nomear os genes (gene_id: Ensembl annotation; gene_name: gene symbol)
#-o: nome do arquivo de saida com as contagem dos transcritos (delimitado por tabulaco)
#*bam: seleciona as amostras para a contagem
#-p: os fragmentos serao contados ao inves das leituras
#-s: realiza a contagem de acordo com a forma que as leituras foram geradas (0: unstranded; 1: stranded; 2: stranded reverso)
#-T: numero de threads utilizados para processar simultaneamente os processos da analise
#counts.txt: arquivo de saida com a contagem dos transcritos de todas as amostras
#counts.txt.summary: arquivo de saida com o sumario da contagem dos transcritos de todas as amostras
```
- ``-a`` arquivo de anotação dos transcritos do genoma referência
- ``-F`` formato do arquivo de anotação dos transcritos do genoma referência (GTF; SAF; GFF)
- ``-g`` especifica o atributo para nomear os genes (gene_id: Ensembl annotation; gene_name: gene symbol)
- ``-o`` nome do arquivo de saída com as contagem dos transcritos (delimitado por tabulação)
- `counts.txt` arquivo de saída com a contagem dos transcritos de todas as amostras
- `counts.txt.summary` arquivo de saída com o sumário da contagem dos transcritos de todas as amostras
- ``*bam`` seleciona as amostras para a contagem
- ``-p`` os fragmentos serão contados ao invés das leituras
- ``-s`` realiza a contagem de acordo com a forma que as leituras foram geradas (0: unstranded; 1: stranded; 2: stranded reverso)
- ``-T`` número de threads utilizados para processar simultaneamente os processos da análise
---

### Análise da expressão diferencial de genes 
<br/>

Montar script de análise de acordo com o desenho experimental (baseado em: [stephenturner/deseq2-analysis-template.R](https://gist.github.com/stephenturner/f60c1934405c127f09a6)
- script para CHIKV vs. CONTROLES: [DESeq_chikv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_chikv.R)
- script para DENV vs. CONTROLES: [DESeq_denv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_denv.R)
- script para DENV vs. CHIKV: [DESeq_denvChikv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_denvChikv.R)
- script para DENV vs. ZIKV: [DESeq_denvZikv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_denvZikv.R)
- script para ZIKV vs. CONTROLES: [DESeq_zikv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_zikv.R)
- script para ZIKV vs. CHIKV: [DESeq_zikvChikv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_zikvChikv.R)
```r
### RNA-seq analysis
### Analise de RNA-seq

## Import & pre-process -----------------------------------------------------------------------------------------
## Pre-processamento & importacao -------------------------------------------------------------------------------

# Import data from featureCounts
# Importar dados obtidos do featureCounts
countdata <- read.table("D:\\RNASeqArbovirusFiocruzBA\\analysis\\counts\\counts-c\\counts.txt", header=TRUE, row.names=1)

# Remove first five columns (chr, start, end, strand, length)
# Remover as p´rimeiras cinco colunas (chr, start, end, strand, length)
countdata <- countdata[ ,6:ncol(countdata)]

# Remove _Aligned.sortedByCoord.out.bam from filenames
# Remover _Aligned.sortedByCoord.out.bam do nome dos arquivos
colnames(countdata) <- gsub("\\_Aligned.sortedByCoord.out.bam", "", colnames(countdata))

# Convert to matrix
# Converter para matrix
countdata <- as.matrix(countdata)
head(countdata)

# Assign condition (first "(rep(x)" contain the experiment - exp, second "(rep(x)" are controls - ctrl)
# Atribuir condicoes (o primeiro "(rep(x)" são os experimentos - exp, o segundo "(rep(x)" são os controles)
(condition <- factor(c(rep("chikv", 37), rep("ctrl", 9))))


## Analysis with DESeq2 -----------------------------------------------------------------------------------------
## Analise com DESeq2 -------------------------------------------------------------------------------------------

# Install DESeq2 package
# Instalar o pacote DESeq2
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("DESeq2")

# Load DESeq2 package
# Carregar o pacote DESeq2
library(DESeq2)

# Create a coldata frame and instantiate the DESeqDataSet. See ?DESeqDataSetFromMatrix
# Criar o frame coldata e iniciar o DESeqDataSet. Veja ?DESeqDataSetFromMatrix
(coldata <- data.frame(row.names=colnames(countdata), condition))
dds <- DESeqDataSetFromMatrix(countData=countdata, colData=coldata, design=~condition)
dds <- estimateSizeFactors(dds)
counts(dds, normalized=TRUE)
idx <- rowSums(counts(dds, normalized=TRUE) >= 5) >=3
dds <- dds[idx,]

# Run the DESeq pipeline
# Iniciar o pipeline DESeq
dds <- DESeq(dds)

# Plot dispersions
# Plots de dispersao
png("D:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\qc-dispersions.png", 3000, 3000, pointsize=50)
plotDispEsts(dds, main="Dispersion plot")
dev.off()

# Regularized log transformation for clustering/heatmaps, etc
# Transformar valores de log para clusterizacao/heatmaps, etc
rld <- rlogTransformation(dds)
head(assay(rld))
hist(assay(rld))
par( mfrow = c( 1, 2 ) )
dds <- estimateSizeFactors(dds)
plot( log2( 1 + counts(dds, normalized=TRUE)[ , 1:2] ),
      col=rgb(0,0,0,.2), pch=16, cex=0.3 )
plot( assay(rld)[ , 1:2],
      col=rgb(0,0,0,.2), pch=16, cex=0.3 )

# Colors for plots below
# Cores para os plots
library(RColorBrewer)
(mycols <- brewer.pal(8, "Dark2")[1:length(unique(condition))])

# Sample distance heatmap
# Heatmap de dispersao das amostras
sampleDists <- as.matrix(dist(t(assay(rld))))
library(gplots)
png("D:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\qc-heatmap-samples.png", w=3000, h=3000, pointsize=50)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[condition], RowSideColors=mycols[condition],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()

# Principal components analysis
# Analise de componentes principais
plotPCA(rld, intgroup="condition")
rld_pca <- function (rld, intgroup = "condition", ntop = 500, colors=NULL, legendpos="bottomleft", main="PCA Biplot", textcx=1, ...) {
  require(genefilter)
  require(calibrate)
  require(RColorBrewer)
  rv = rowVars(assay(rld))
  select = order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  pca = prcomp(t(assay(rld)[select, ]))
  fac = factor(apply(as.data.frame(colData(rld)[, intgroup, drop = FALSE]), 1, paste, collapse = " : "))
  if (is.null(colors)) {
    if (nlevels(fac) >= 3) {
      colors = brewer.pal(nlevels(fac), "Paired")
    }   else {
      colors = c("black", "red")
    }
  }
  pc1var <- round(summary(pca)$importance[2,1]*100, digits=1)
  pc2var <- round(summary(pca)$importance[2,2]*100, digits=1)
  pc1lab <- paste0("PC1 (",as.character(pc1var),"%)")
  pc2lab <- paste0("PC1 (",as.character(pc2var),"%)")
  plot(PC2~PC1, data=as.data.frame(pca$x), bg=colors[fac], pch=21, xlab=pc1lab, ylab=pc2lab, main=main, ...)
  with(as.data.frame(pca$x), textxy(PC1, PC2, labs=rownames(as.data.frame(pca$x)), cex=textcx))
  legend(legendpos, legend=levels(fac), col=colors, pch=20)
  #     rldyplot(PC2 ~ PC1, groups = fac, data = as.data.frame(pca$rld),
  #            pch = 16, cerld = 2, aspect = "iso", col = colours, main = draw.key(key = list(rect = list(col = colours),
  #                                                                                         terldt = list(levels(fac)), rep = FALSE)))
}
png("D:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\qc-pca.png", 3000, 3000, pointsize=50)
rld_pca(rld, colors=mycols, intgroup="condition", xlim=c(-35, 45))
dev.off()

# Get differential expression results
# Obter resultados de genes diferencialmente expressos
res <- results(dds)
table(res$padj<0.05)

## Order by adjusted p-value
## Ordenar de acordo com valor de p ajustado
res <- res[order(res$padj), ]

## Merge with normalized count data
## Mesclar com dados de contagem normalizados
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
head(resdata)

## Write results
## Salvar resultados
write.csv(resdata, file="D:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\diffexpr-results.csv")

## Examine plot of p-values
## Examinar plot do valor de p
hist(res$pvalue, breaks=20, col="grey")

## Examine independent filtering
## Examinar os filtros independentes
attr(res, "filterThreshold")
plot(attr(res,"filterNumRej"), type="b", xlab="quantiles of baseMean", ylab="number of rejections")

## MA plot
## plot MA
maplot <- function (res, thresh=0.05, labelsig=TRUE, textcx=1, ...) {
  with(res, plot(baseMean, log2FoldChange, pch=20, cex=.5, log="x", ...))
  with(subset(res, padj<thresh), points(baseMean, log2FoldChange, col="red", pch=20, cex=1.5))
  if (labelsig) {
    require(calibrate)
    with(subset(res, padj<thresh), textxy(baseMean, log2FoldChange, labs=Gene, cex=textcx, col=2))
  }
}
png("D:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\diffexpr-maplot.png", 2500, 2000, pointsize=20)
maplot(resdata, main="MA Plot")
dev.off()

## Volcano plot with "significant" genes labeled
## Plot estilo vulcao com genes "significantes marcados
volcanoplot <- function (resdata, lfcthresh=2, sigthresh=0.05, main="Volcano Plot", legendpos="bottomright", labelsig=TRUE, textcx=1, ...) {
  with(res, plot(log2FoldChange, -log10(pvalue), pch=20, main=main, ...))
  with(subset(res, padj<sigthresh ), points(log2FoldChange, -log10(pvalue), pch=20, col="red", ...))
  with(subset(res, abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(pvalue), pch=20, col="orange", ...))
  with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(pvalue), pch=20, col="green", ...))
  if (labelsig) {
    require(calibrate)
    with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), textxy(log2FoldChange, -log10(pvalue), labs=NULL, cex=textcx, ...))
  }
  legend(legendpos, xjust=1, yjust=1, legend=c(paste("FDR<",sigthresh,sep=""), paste("|LogFC|>",lfcthresh,sep=""), "both"), pch=20, col=c("red","orange","green"))
}
png("D:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\diffexpr-volcanoplot.png", 2200, 2000, pointsize=30)
volcanoplot(resdata, lfcthresh=1, sigthresh=0.05, textcx=.8, xlim=c(-2.3, 2))
dev.off()
```
---
