## RNA-Seq

### Criar um ambiente (environment) para a análise do RNA-Seq
<br/>

Instalar última versão do *Miniconda*
```sh
cd $HOME/softwares/
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
<br/>

Criar environment rna-seq
```sh
$HOME/softwares/miniconda3/bin/conda create --name rna-seq
```
- ``create`` cria um environment para instalar uma lista específica de pacotes (packages)
- ``--name`` nome do environment
<br/>

Ativar enviroment rna-seq
```sh
source $HOME/softwares/miniconda3/bin/activate rna-seq
```
<br/>

Instalar aplicações no enviroment rna-seq
```sh
conda install --name rna-seq --channel bioconda fastqc
conda install --name rna-seq --channel bioconda multiqc
conda install --name rna-seq --channel bioconda trimmomatic
conda install --name rna-seq --channel bioconda star
conda install --name rna-seq --channel bioconda subread
conda install --name rna-seq --channel bioconda diamond
conda install --name rna-seq --channel bioconda krona
```
- ``install`` instala uma lista de pacotes
- ``--name`` nome do environment
- ``--channel`` canal do pacote a ser instalado (site para buscar pacotes: https://anaconda.org/search)
<br/>

Desativar environment rna-seq
```sh
conda deactivate
```
---

### Organizar *raw data* no servidor
<br/>

Copiar os diretórios das 5 corridas (runs) para o servidor
- Cada corrida tem 544 lanes totais, dispostas em diretório com 2 lanes de uma única amostra, cada lane contém leituras pareadas (paired-end) R1 e R2
```
.
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

Organizar as lanes em um diretório por corrida (run1, run2, run3, run4, run5)
```sh
mkdir $HOME/datasets/arboba-rnaseq/arboba-run1 | find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-08-17_15_33_27Z-116577544/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/arboba-run1/ {} +
mkdir $HOME/datasets/arboba-rnaseq/arboba-run2 | find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-10-17_13_51_20Z-130391988/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/arboba-run2/ {} +
mkdir $HOME/datasets/arboba-rnaseq/arboba-run3 | find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-11_13_17_10Z-141945716/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/arboba-run3/ {} +
mkdir $HOME/datasets/arboba-rnaseq/arboba-run4 | find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-13_14_45_41Z-143225097/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/arboba-run4/ {} +
mkdir $HOME/datasets/arboba-rnaseq/arboba-run5 | find $HOME/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-15_10_26_29Z-143716575/ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/arboba-run5/ {} +
```
<br/>

Excluir diretórios antigos das lanes
```sh
find $HOME/datasets/arboba-rnaseq/ -name 'FASTQ*' -exec rm -rf {} \;
```
---

### Organizar as leituras por corrida
<br/>

Concatenar as lanes por corrida (run1, run2, run3, run4, run5)
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

### Checagem de qualidade (basecalling) por corrida
<br/>

Criar diretórios para os resultados do basecalling
```sh
mkdir $HOME/datasets/arboba-rnaseq/arboba-run1-fastQC/ && mkdir $HOME/datasets/arboba-rnaseq/arboba-run2-fastQC/ && mkdir $HOME/datasets/arboba-rnaseq/arboba-run3-fastQC/ && mkdir $HOME/datasets/arboba-rnaseq/arboba-run4-fastQC/ && mkdir $HOME/datasets/arboba-rnaseq/arboba-run5-fastQC/
```
<br/>

Realizar basecalling utilizando a ferramenta *fastQC*
```sh
cd $HOME/datasets/arboba-rnaseq/arboba-run1/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run1-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run2/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run2-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run3/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run3-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run4/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run4-fastQC/ --threads 12
cd $HOME/datasets/arboba-rnaseq/arboba-run5/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq/arboba-run5-fastQC/ --threads 12
```
- ``*.fastq.gz``: seleciona os arquivos *.fastq.gz para a análise
- ``--outdir`` diretório para os arquivos de saída da análise (output)
- ``--threads`` número de threads utilizados para processar simultaneamente os processos da análise
<br/>

Agregar resultados do basecalling utilizando a ferramenta *multiQC*
```sh
cd $HOME/datasets/arboba-rnaseq/arboba-run1-fastQC/
nohup multiqc --fullnames --title ArbovirusBahiaRun1 --interactive --export $HOME/datasets/arboba-rnaseq/arboba-run1-fastQC/
cd $HOME/datasets/arboba-rnaseq/arboba-run2-fastQC/
nohup multiqc --fullnames --title ArbovirusBahiaRun2 --interactive --export $HOME/datasets/arboba-rnaseq/arboba-run2-fastQC/
cd $HOME/datasets/arboba-rnaseq/arboba-run3-fastQC/
nohup multiqc --fullnames --title ArbovirusBahiaRun3 --interactive --export $HOME/datasets/arboba-rnaseq/arboba-run3-fastQC/
cd $HOME/datasets/arboba-rnaseq/arboba-run4-fastQC/
nohup multiqc --fullnames --title ArbovirusBahiaRun4 --interactive --export $HOME/datasets/arboba-rnaseq/arboba-run4-fastQC/
cd $HOME/datasets/arboba-rnaseq/arboba-run5-fastQC/
nohup multiqc --fullnames --title ArbovirusBahiaRun5 --interactive --export $HOME/datasets/arboba-rnaseq/arboba-run5-fastQC/
```
- ``--fullnames`` mantém o nome do arquivo que vai ser analisado
- ``--title`` cria um título para o relatório do multiqc
- ``--interactive`` utiliza plots iterativos
- ``--export`` exporta plots das análises do multiqc
<br/>

Excluir os diretórios do basecalling (etapa após backup)
```sh
find $HOME/datasets/arboba-rnaseq/ -name '*fastQC*' -exec rm -rf {} \;
```
---

### Organizar as leituras como um único experimento
<br/>

Organizar as leituras das corrida em um único diretório
```sh
find ./ -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/ {} +
```
<br/>

Excluir os diretórios de cada corrida
```sh
find $HOME/datasets/arboba-rnaseq/ -name '*arboba-run*' -exec rm -rf {} \;
```
<br/>

Concatenar as corridas
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

Excluir as corridas não concatenadas do diretório
```sh
find $HOME/datasets/arboba-rnaseq/ -type f -name '*RUN*' -exec rm -rf {} \;
```
---

### Checagem de qualidade (basecalling) do experimento
<br/>

Criar diretório para os resultados do basecalling
```sh
mkdir $HOME/datasets/arboba-rnaseq-fastQC/
```
<br/>

Realizar basecalling utilizando a ferramenta *fastQC*
```sh
cd $HOME/datasets/arboba-rnaseq/
nohup fastqc *.fastq.gz --outdir $HOME/datasets/arboba-rnaseq-fastQC/ --threads 12
```
- ``*.fastq.gz``: seleciona os arquivos *.fastq.gz para a análise
- ``--outdir`` diretório para os arquivos de saída da análise (output)
- ``--threads`` número de threads utilizados para processar simultaneamente os processos da análise
<br/>

Agregar resultados do basecalling utilizando a ferramenta *multiQC*
```sh
cd $HOME/datasets/arboba-rnaseq-fastQC/
nohup multiqc --fullnames --title ArbovirusBahiaRNASeq --interactive --export $HOME/datasets/arboba-rnaseq-fastQC/
```
- ``--fullnames`` mantém o nome do arquivo que vai ser analisado
- ``--title`` cria um título para o relatório do multiqc
- ``--interactive`` utiliza plots iterativos
- ``--export`` exporta plots das análises do multiqc
<br/>

Excluir o diretório do basecalling (etapa após backup)
```sh
find $HOME/datasets/ -name '*fastQC*' -exec rm -rf {} \;
```
---

### Filtrar e cortar as leituras de baixa qualidade
<br/>

Gerar script para a filtrar e cortar (trimar) as leituras de baixa qualidade
```sh
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
```
- ``PE`` modo paired-end do trimmomatic
- ``-phred33`` escala de qualidade utilizada pelas metodologias Sanger e Illumina 1.8+
- ``-threads`` número de threads utilizados para processar simultaneamente os processos da análise
- ``ILLUMINACLIP`` identifica qual tipo de adaptador será trimado
- ``LEADING`` corta bases de nucleotídeos no início das reads, de acordo com a escala Q-score (https://www.drive5.com/usearch/manual/quality_score.html)
- ``TRAILING`` corta bases de nucleotídeos no final das reads, de acordo com a escala Q-score (https://www.drive5.com/usearch/manual/quality_score.html)
- ``SLIDINGWINDOW`` estratégia de "janela deslizante" para varredura da read a partir da extremidade 5' para trimar as leituras, caso o Q-score seja menor que o estipulado
- ``MINLEN`` descarta reads de acordo com o tamanho mínimo definido
<br/>

Filtrar e cortar (trimar) as leituras de baixa qualidade utilizando a ferramenta *trimmomatic*
```sh
bash trimmomatic_cmd.sh
```
- São gerados 4 outputs:
    - R1_paired.fastq.gz: contém reads R1 que pareiam com as reads R2
    - R1_unpaired.fastq.gz: contém reads R1 que NÃO pareiam com as reads R2 (não será utilizado nas análises posteriores)
    - R2_paired.fastq.gz: contém reads R2 que pareiam com as reads R1
    - R2_unpaired.fastq.gz: contém reads R2 que NÃO pareiam com as reads R1 (não será utilizado nas análises posteriores)
---

### Mapeamento do genoma referência com as amostras
<br/>

Obter arquivos do genoma referência no portal GENCODE (https://www.gencodegenes.org/human/)
- Genoma referência humano em *.fa: ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz 
- Anotação do genoma em *.gtf: ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/GRCh38.p12.genome.fa.gz
```
.
└── arboba-rnaseq
    └── GRCh38.p12.genome.fa.gz
    └── gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz
```
<br/>

Descompactar arquivos do genoma referência GRCh38.p12
```sh
gunzip -d $HOME/datasets/arboba-rnaseq/GRCh38.p12.genome.fa.gz
gunzip -d $HOME/datasets/arboba-rnaseq/gencode.v31.chr_patch_hapl_scaff.annotation.gtf.gz
```
<br/>

Construir os índices (index) do genoma referência GRCh38.p12 utilizando a ferramenta *STAR*
```sh
nohup STAR --runThreadN 12 --runMode genomeGenerate --genomeDir $HOME/datasets/arboba-rnaseq/arboba-rnaseq_index/ --genomeFastaFiles $HOME/datasets/arboba-rnaseq/GRCh38.p12.genome.fa
```
- ``--runThreadN`` número de threads utilizados para processar simultaneamente os processos da análise
- ``--runMode`` tipo de funcionamento do STAR (genomeGenerate: gerar index; alignReads: mapear reads)
- ``--genomeDir`` diretório para armazenar os arquivos do index
- ``--genomeFastaFiles`` arquivo do genoma referência em *.fasta
<br/>

Gerar script para mapear o genoma referência GRCh38.p12 com as amostras
```sh
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
```
- ``--runThreadN`` número de threads utilizados para processar simultaneamente os processos da análise
- ``--runMode`` tipo de funcionamento do STAR (genomeGenerate: gerar index; alignReads: mapear reads)
- ``--genomeDir`` diretório dos arquivos do index
- ``--sjdbGTFfile`` arquivo de anotação dos transcritos do genoma referência
- ``--readFilesIn`` arquivos input das reads R1 e R2 paired da amostra
- ``--readFilesCommand`` comando utilizado caso as reads estejam compactadas (para arquivos *.gz, utilizar zcat; para *.bz2 utilizar bunzip2 -c)
- ``--outFileNamePrefix`` prefixo para nomear os arquivos output
- ``--outSAMtype`` determina o tipo de output do mapeamento (padrão: SAM; BAM Unsorted: arquivo binário sem estar ordenado; BAM SortedByCoordinate: arquivo binário ordenado de acordo com a anotação dos transcritos do genoma referência)
<br/>

Mapear o genoma referência GRCh38.p12 para cada amostra utilizando a ferramenta *STAR*
```sh
bash STAR_alignReads_SortedByCoordinated_cmd.sh
```
- São gerados 6 outputs:
    - Aligned.sortedByCoord.out.bam: mapeamento da amostra
    - Log.final.out: contém o sumário com a estatística do mapeamento
    - Log.out: contém informações e mensagens do processo de análise
    - Log.progress.out: contém informações resumidas da estatística do processo da análise de acordo com o progresso de cada etapa
    - SJ.out.tab: contém informações das junções de splicing
---

### Contagem dos transcritos
<br/>

Realizar contagem dos transcritos das amostras
```sh
nohup featureCounts -T 12 -s 2 -p -F GTF -a $HOME/datasets/arboba-rnaseq/gencode.v31.chr_patch_hapl_scaff.annotation.gtf -o arboba-rnaseq_counts_SortedByCoordinated.txt *bam
```
- ``-T`` número de threads utilizados para processar simultaneamente os processos da análise
- ``-s`` realiza a contagem de acordo com a forma que as reads foram geradas (0: unstranded; 1: stranded; 2: stranded reverso)
- ``-p`` os fragmentos serão contados ao invés das reads
- ``-F`` formato do arquivo de anotação dos transcritos do genoma referência (GTF; SAF; GFF)
- ``-a`` arquivo de anotação dos transcritos do genoma referência
- ``-o`` nome do arquivo output com as contagem dos transcritos (delimitado por tabulação)
- ``*bam`` seleciona as amostras para a contagem 
- São gerados 2 outputs:
    - counts.txt: contém a contagem dos transcritos de todas as amostras
    - counts.txt.summary: contém um sumário da contagem dos transcritos de todas as amostras
---
