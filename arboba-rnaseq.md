## RNA-Seq "ArbovirusFiocruzBA"

### Organizar as pastas de trabalho
<br/>

Criar diretórios de trabalho no workstation
```
.
└── $HOME
    ├── datasets
        └── arboba-rnaseq
            ├── align
                ├── align-chikv
                ├── align-denv
                └── align-zikv
            ├── concatenated
            ├── counts
                ├── counts-chikv
                ├── counts-denv
                └── counts-zikv
            ├── index
            ├── qc
                ├── qc-concatenated
                ├── qc-run1
                ├── qc-run2
                ├── qc-run3
                ├── qc-run4
                └── qc-run5
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
- ``$HOME/datasets/arboba-rnaseq/align/align-chikv`` leituras mapeadas de CHIKV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/align/align-denv`` leituras mapeadas de DENV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/align/align-zikv``leituras mapeadas de ZIKV vs. CONTROLES 
- ``$HOME/datasets/arboba-rnaseq/concatenated`` leituras concatenadas
- ``$HOME/datasets/arboba-rnaseq/counts`` contagem dos genes
- ``$HOME/datasets/arboba-rnaseq/counts/counts-chikv`` contagem dos genes de CHIKV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/counts/counts-denv`` contagem dos genes de DENV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/counts/counts-zikv`` contagem dos genes de ZIKV vs. CONTROLES
- ``$HOME/datasets/arboba-rnaseq/index`` índices do genoma humano de referência GRCh38.p12
- ``$HOME/datasets/arboba-rnaseq/qc`` dados de qualidade
- ``$HOME/datasets/arboba-rnaseq/qc/qc-concatenated`` dados de qualidade das corridas concatenadas 
- ``$HOME/datasets/arboba-rnaseq/qc/qc-run1`` dados de qualidade da corrida 1 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-run2`` dados de qualidade da corrida 2 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-run3`` dados de qualidade da corrida 3 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-run4`` dados de qualidade da corrida 4 do RNA-Seq
- ``$HOME/datasets/arboba-rnaseq/qc/qc-run5`` dados de qualidade da corrida 5 do RNA-Seq
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

Copiar as lanes dipostas em um diretório por corrida (run1, run2, run3, run4, run5)
```sh
find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-08-17_15_33_27Z-116577544/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run1/ {} +
find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-10-17_13_51_20Z-130391988/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run2/ {} +
find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-11_13_17_10Z-141945716/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run3/ {} +
find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-13_14_45_41Z-143225097/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run4/ {} +
find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-15_10_26_29Z-143716575/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/run5/ {} +
```
<br/>

Excluir diretórios antigos das lanes
```sh
find $HOME/datasets/arboba-rnaseq/ -name 'FASTQ*' -exec rm -rf {} \;
```
---

### Organizar as lanes por corrida (run1, run2, run3, run4, run5)
<br/>

Concatenar as lanes
- script: [cat_lane_merging.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/cat_lane_merging.sh)
```sh
#!/bin/bash
for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)
do echo "sample $i R1 concatenated"
cat "$i"_L00*_R1_001.fastq.gz > "$i"_RUN0_R1_001.fastq.gz
echo "sample $i R2 concatenated"
cat "$i"_L00*_R2_001.fastq.gz > "$i"_RUN0_R2_001.fastq.gz
done
```
<br/>

Excluir as lanes dos diretórios
```sh
find $HOME/datasets/arboba-rnaseq/ -type f -name '*L00*' -exec rm -rf {} \;
```
---

### Checar qualidade das corridas
<br/>

Realizar análise de qualidade utilizando a ferramenta *fastQC*
- script: [fastqc_runs.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/fastqc_runs.sh)
```sh
#!/bin/bash
nohup fastqc $HOME/datasets/arboba-rnaseq/run1/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run1/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run2/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run2/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run3/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run3/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run4/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run4/ --threads 12
nohup fastqc $HOME/datasets/arboba-rnaseq/run5/*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-run5/ --threads 12
```
- ``nohup`` permite executar o comando em segundo plano
- ``*.fastq.gz`` seleciona os arquivos *.fastq.gz para a análise
- ``--outdir`` diretório para os arquivos de saída da análise (output)
- ``--threads`` número de threads utilizados para processar simultaneamente os processos da análise
<br/>

Agregar resultados de qualidade utilizando a ferramenta *multiQC*
- script: [multiqc_runs.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/multiqc_runs.sh)
```sh
#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/qc/qc-run1/ && nohup multiqc --fullnames --title ArbovirusBahiaRun1 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run1/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run2/ && nohup multiqc --fullnames --title ArbovirusBahiaRun2 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run2/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run3/ && nohup multiqc --fullnames --title ArbovirusBahiaRun3 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run3/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run4/ && nohup multiqc --fullnames --title ArbovirusBahiaRun4 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run4/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run5/ && nohup multiqc --fullnames --title ArbovirusBahiaRun5 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run5/
```
- ``nohup`` permite executar o comando em segundo plano
- ``--fullnames`` mantém o nome do arquivo que vai ser analisado
- ``--title`` cria um título para o relatório do multiqc
- ``--interactive`` utiliza plots iterativos
- ``--export`` exporta plots das análises do multiqc
---

### Organizar as leituras como um único experimento
<br/>

Organizar as leituras das corrida em um único diretório
```sh
find ./ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/concatenated {} +
```
<br/>

Excluir os diretórios de cada corrida
```sh
find $HOME/datasets/arboba-rnaseq/ -name 'run*' -exec rm -rf {} \;
```
<br/>

Concatenar as corridas
- script: [cat_runs_merging.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/cat_runs_merging.sh)
```sh
#!/bin/bash
for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)
do echo "sample $i R1 concatenated"
cat "$i"_RUN*_R1_001.fastq.gz > "$i"_R1.fastq.gz
echo "sample $i R2 concatenated"
cat "$i"_RUN*_R2_001.fastq.gz > "$i"_R2.fastq.gz
done
```
<br/>

Excluir as corridas não concatenadas
```sh
find $HOME/datasets/arboba-rnaseq/concatenated -type f -name '*RUN*' -exec rm -rf {} \;
```
---

### Checar qualidade do experimento
<br/>

Realizar análise de qualidade utilizando a ferramenta *fastQC*
- script: [fastqc_concatenated.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/fastqc_concatenated.sh)
```sh
#!/bin/bash
nohup fastqc $HOME/datasets/arboba-rnaseq/concatenated*.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/ --threads 12
```
- ``nohup`` permite executar o comando em segundo plano
- ``*.fastq.gz`` seleciona os arquivos *.fastq.gz para a análise
- ``--outdir`` diretório para os arquivos de saída da análise
- ``--threads`` número de threads utilizados para processar simultaneamente os processos da análise
<br/>

Agregar resultados de qualidade utilizando a ferramenta *multiQC*
- script: [multiqc_concatenated.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/multiqc_concatenated.sh)
```sh
#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/ && nohup multiqc --fullnames --title ArbovirusBahiaRNASeq --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/
```
- ``nohup`` permite executar o comando em segundo plano
- ``--fullnames`` mantém o nome do arquivo que vai ser analisado
- ``--title`` cria um título para o relatório do multiqc
- ``--interactive`` utiliza plots iterativos
- ``--export`` exporta plots das análises do multiqc
---

### Filtrar e cortar as leituras de baixa qualidade
<br/>

Gerar script para a filtrar e cortar as leituras de baixa qualidade
- script: [trimmomatic.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/trimmomatic.sh)
```sh
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
```
- ``nohup`` permite executar o comando em segundo plano
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
bash trimmomatic_cmd.sh
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
- script: [STAR_genomeGenerate.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/STAR_genomeGenerate.sh)
```sh
#!/bin/bash
nohup STAR --runThreadN 12 --runMode genomeGenerate --genomeDir $HOME/datasets/arboba-rnaseq/index/ --genomeFastaFiles $HOME/datasets/arboba-rnaseq/refs/GRCh38.p12.genome.fa
```
- ``nohup`` permite executar o comando em segundo plano
- ``--runThreadN`` número de threads utilizados para processar simultaneamente os processos da análise
- ``--runMode`` tipo de funcionamento do STAR (genomeGenerate: gerar índices; alignReads: mapear leituras)
- ``--genomeDir`` diretório para armazenar os arquivos do index
- ``--genomeFastaFiles`` arquivo do genoma referência em *.fasta
<br/>

Gerar script para mapear o genoma referência GRCh38.p12 com as amostras
- script: [STAR_alignReads_SortedByCoordinated.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/STAR_alignReads_SortedByCoordinated.sh)
```sh
#!/bin/bash
echo '#!/bin/bash' >> STAR_alignReads_SortedByCoordinated_cmd.sh
for i in `ls -1 *R1_paired*.fastq.gz | sed 's/\_R1_paired.fastq.gz//'`
do echo nohup STAR \
--runThreadN 12 \
--runMode alignReads \
--genomeDir $HOME/datasets/arboba-rnaseq/index/ \
--sjdbGTFfile $HOME/datasets/arboba-rnaseq/refs/gencode.v31.chr_patch_hapl_scaff.annotation.gtf \
--readFilesIn $HOME/datasets/arboba-rnaseq/trimmed/$i\_R1_paired.fastq.gz $HOME/datasets/arboba-rnaseq/trimmed/$i\_R2_paired.fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix $HOME/datasets/arboba-rnaseq/align/$i\_ \
--outSAMtype BAM SortedByCoordinate \
--outReadsUnmapped Fastx \
>> STAR_alignReads_SortedByCoordinated_cmd.sh
done
```
- ``nohup`` permite executar o comando em segundo plano
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
bash STAR_alignReads_SortedByCoordinated_cmd.sh
```
---

### Definir os desenhos esperimentais para a contagem de leituras
<br/>

Definir os desenhos experimentais

| sample     | group   |
| ---------- | ------- |
| ZK0041_S23 | chikv   |
| ZK0043_S65 | chikv   |
| ZK0046_S2  | chikv   |
| ZK0048_S32 | chikv   |
| ZK0049_S34 | chikv   |
| ZK0066_S1  | chikv   |
| ZK0085_S31 | chikv   |
| ZK0087_S16 | chikv   |
| ZK0088_S30 | chikv   |
| ZK0094_S52 | chikv   |
| ZK0104_S27 | chikv   |
| ZK0126_S19 | chikv   |
| ZK0129_S63 | chikv   |
| ZK0130_S22 | chikv   |
| ZK0134_S15 | chikv   |
| ZK0135_S3  | chikv   |
| ZK0137_S60 | chikv   |
| ZK0140_S43 | chikv   |
| ZK0143_S21 | chikv   |
| ZK0145_S12 | chikv   |
| ZK0160_S10 | chikv   |
| ZK0162_S29 | chikv   |
| ZK0170_S68 | chikv   |
| ZK0171_S46 | chikv   |
| ZK0172_S7  | chikv   |
| ZK0180_S6  | chikv   |
| ZK0182_S41 | chikv   |
| ZK0185_S54 | chikv   |
| ZK0187_S55 | chikv   |
| ZK0188_S26 | chikv   |
| ZK0191_S45 | chikv   |
| ZK0193_S17 | chikv   |
| ZK0194_S67 | chikv   |
| ZK0195_S28 | chikv   |
| ZK0196_S59 | chikv   |
| ZK0198_S44 | chikv   |
| ZK0202_S14 | chikv   |
| ZK0214_S9  | control |
| ZK0215_S58 | control |
| ZK0219_S24 | control |
| ZK0361_S51 | control |
| ZK0362_S50 | control |
| ZK0363_S25 | control |
| ZK0364_S13 | control |
| ZK0365_S39 | control |
| ZK0366_S40 | control |
<br/>

| sample     | group   |
| ---------- | ------- |
| 2137_S38   | denv    |
| 2167_S48   | denv    |
| 2173_S42   | denv    |
| 3051_S66   | denv    |
| 3053_S47   | denv    |
| 4171_S57   | denv    |
| 4175_S37   | denv    |
| 4230_S5    | denv    |
| ZK0214_S9  | control |
| ZK0215_S58 | control |
| ZK0219_S24 | control |
| ZK0361_S51 | control |
| ZK0362_S50 | control |
| ZK0363_S25 | control |
| ZK0364_S13 | control |
| ZK0365_S39 | control |
| ZK0366_S40 | control |
<br/>

| sample     | group   |
| ---------- | ------- |
| 140_S33    | zikv    |
| 193_S11    | zikv    |
| 200_S18    | zikv    |
| 210_S62    | zikv    |
| 225_S20    | zikv    |
| 227_S49    | zikv    |
| 241_S53    | zikv    |
| 39_S35     | zikv    |
| ZK0099_S64 | zikv    |
| ZK0110_S8  | zikv    |
| ZK0111_S61 | zikv    |
| ZK0128_S36 | zikv    |
| ZK0214_S9  | control |
| ZK0215_S58 | control |
| ZK0219_S24 | control |
| ZK0361_S51 | control |
| ZK0362_S50 | control |
| ZK0363_S25 | control |
| ZK0364_S13 | control |
| ZK0365_S39 | control |
| ZK0366_S40 | control |
<br/>

Organizar as leituras mapeadas de acordo com o desenho experimental
- script: [mv_alignReads.sh](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/mv_alignReads.sh)
```sh
#!/bin/bash
#chikv versus controles
mv ZK0041_S23* ZK0043_S65* ZK0046_S2* ZK0048_S32* ZK0049_S34* ZK0066_S1* ZK0085_S31* ZK0087_S16* ZK0088_S30* ZK0094_S52* ZK0104_S27* ZK0126_S19* ZK0129_S63* ZK0130_S22* ZK0134_S15* ZK0135_S3* ZK0137_S60* ZK0140_S43* ZK0143_S21* ZK0145_S12* ZK0160_S10* ZK0162_S29* ZK0170_S68* ZK0171_S46* ZK0172_S7* ZK0180_S6* ZK0182_S41* ZK0185_S54* ZK0187_S55* ZK0188_S26* ZK0191_S45* ZK0193_S17* ZK0194_S67* ZK0195_S28* ZK0196_S59* ZK0198_S44* ZK0202_S14* \
ZK0214_S9* ZK0215_S58* ZK0219_S24* ZK0361_S51* ZK0362_S50* ZK0363_S25* ZK0364_S13* ZK0365_S39* ZK0366_S40* \
$HOME/datasets/arboba-rnaseq/align/align-chikv/
#denv versus controles
mv 2137_S38* 2167_S48* 2173_S42* 3051_S66* 3053_S47* 4171_S57* 4175_S37* 4230_S5* \
ZK0214_S9* ZK0215_S58* ZK0219_S24* ZK0361_S51* ZK0362_S50* ZK0363_S25* ZK0364_S13* ZK0365_S39* ZK0366_S40* \
$HOME/datasets/arboba-rnaseq/align/align-denv/
#zikv versus controles
mv 140_S33* 193_S11* 200_S18* 210_S62* 225_S20* 227_S49* 241_S53* 39_S35* ZK0099_S64* ZK0110_S8* ZK0111_S61* ZK0128_S36* \
ZK0214_S9* ZK0215_S58* ZK0219_S24* ZK0361_S51* ZK0362_S50* ZK0363_S25* ZK0364_S13* ZK0365_S39* ZK0366_S40* \
$HOME/datasets/arboba-rnaseq/align/align-zikv/
```
---

### Contar as leituras das amostras
<br/>

Realizar contagem dos transcritos das amostras para cada desenho experimental
```sh
#!/bin/bash
nohup featureCounts -T 12 -s 2 -p -F GTF -a $HOME/datasets/arboba-rnaseq/refs/gencode.v31.chr_patch_hapl_scaff.annotation.gtf -o counts.txt *bam
```
- ``nohup`` permite executar o comando em segundo plano
- ``-T`` número de threads utilizados para processar simultaneamente os processos da análise
- ``-s`` realiza a contagem de acordo com a forma que as leituras foram geradas (0: unstranded; 1: stranded; 2: stranded reverso)
- ``-p`` os fragmentos serão contados ao invés das leituras
- ``-F`` formato do arquivo de anotação dos transcritos do genoma referência (GTF; SAF; GFF)
- ``-a`` arquivo de anotação dos transcritos do genoma referência
- ``-o`` nome do arquivo de saída com as contagem dos transcritos (delimitado por tabulação)
- ``*bam`` seleciona as amostras para a contagem
- `counts.txt` arquivo de saída com a contagem dos transcritos de todas as amostras
- `counts.txt.summary` arquivo de saída com o sumário da contagem dos transcritos de todas as amostras
---

### Análise da expressão diferencial de genes 
<br/>

Montar script de análise de acordo com o desenho experimental (baseado em: [stephenturner/deseq2-analysis-template.R](https://gist.github.com/stephenturner/f60c1934405c127f09a6)
- script para chikv: [DESeq_chikv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_chikv.R)
- script para denv: [DESeq_denv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_denv.R)
- script para zikv: [DESeq_zikv.R](https://github.com/lpmor22/docs/blob/master/scripts/arboba-rnaseq/DESeq_zikv.R)
```r
### RNA-seq analysis
### Analise de RNA-seq

## Import & pre-process -----------------------------------------------------------------------------------------
## Pre-processamento & importacao -------------------------------------------------------------------------------

# Import data from featureCounts
# Importar dados obtidos do featureCounts
countdata <- read.table("F:\\RNASeqArbovirusFiocruzBA\\counts\\counts-chikv\\counts.txt", header=TRUE, row.names=1)

# Remove first five columns (chr, start, end, strand, length)
# Remover as p´rimeiras cinco colunas (chr, start, end, strand, length)
countdata <- countdata[ ,6:ncol(countdata)]

# Remove _Aligned.sortedByCoord.out.bam from filenames
# Remover _Aligned.sortedByCoord.out.bam do nome dos arquivos
colnames(countdata) <- gsub("\\_Aligned.sortedByCoord.out.bam$", "", colnames(countdata))

# Convert to matrix
# Converter para matrix
countdata <- as.matrix(countdata)
head(countdata)

# Assign condition (first "(rep(x)" contain the expansion - exp, second " (rep(x)" are controls - ctl)
# Atribuir condicoes (o primeiro "(rep(x)" são os experimentos - exp, o segundo "(rep(x)" são os controles)
(condition <- factor(c(rep("exp", 37), rep("ctl", 9))))


## Analysis with DESeq2 -----------------------------------------------------------------------------------------
## Analise com DESeq2 -------------------------------------------------------------------------------------------

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
png("F:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\qc-dispersions.png", 1000, 1000, pointsize=20)
plotDispEsts(dds, main="Dispersion plot")
dev.off()

# Regularized log transformation for clustering/heatmaps, etc
# Transformar valores de log para clusterizacao/heatmaps, etc
rld <- rlogTransformation(dds)
head(assay(rld))
hist(assay(rld))

# Colors for plots below
# Cores para os plots
library(RColorBrewer)
(mycols <- brewer.pal(8, "Dark2")[1:length(unique(condition))])

# Sample distance heatmap
# Heatmap de dispersao das amostras
sampleDists <- as.matrix(dist(t(assay(rld))))
library(gplots)
png("F:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\qc-heatmap-samples.png", w=1000, h=1000, pointsize=20)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[condition], RowSideColors=mycols[condition],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()

# Principal components analysis
# Analise de componentes principais
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
png("F:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\qc-pca.png", 1000, 1000, pointsize=20)
rld_pca(rld, colors=mycols, intgroup="condition", xlim=c(-75, 35))
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
write.csv(resdata, file="F:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\diffexpr-results.csv")

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
png("F:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\diffexpr-maplot.png", 1500, 1000, pointsize=20)
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
    with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), textxy(log2FoldChange, -log10(pvalue), labs=Gene, cex=textcx, ...))
  }
  legend(legendpos, xjust=1, yjust=1, legend=c(paste("FDR<",sigthresh,sep=""), paste("|LogFC|>",lfcthresh,sep=""), "both"), pch=20, col=c("red","orange","green"))
}
png("F:\\RNASeqArbovirusFiocruzBA\\analysis\\DESeq\\diffexpr-volcanoplot.png", 1200, 1000, pointsize=20)
volcanoplot(resdata, lfcthresh=1, sigthresh=0.05, textcx=.8, xlim=c(-2.3, 2))
dev.off()
```
---
