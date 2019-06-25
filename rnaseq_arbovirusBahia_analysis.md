## RNA-Seq
### Organizar *raw data* no servidor:
- Copiar os diretórios das 5 corridas para o servidor
    - Cada corrida tem 544 lanes totais, dispostas em diretório com 2 lanes (R1 e R2) de uma única amostra
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
- Organizar as lanes em um diretório por corrida (run1, run2, run3, run4, run5)
```sh
mkdir ~/datasets/arboba-rnaseq/arboba-run1 | find ~/datasets/arboba-rnaseq/FASTQ_Generation_2018-08-17_15_33_27Z-116577544/ -type f -name '*.fastq.gz' -exec cp -at ~/datasets/arboba-rnaseq/arboba-run1/ {} +
mkdir ~/datasets/arboba-rnaseq/arboba-run2 | find ~/datasets/arboba-rnaseq/FASTQ_Generation_2018-10-17_13_51_20Z-130391988/ -type f -name '*.fastq.gz' -exec cp -at ~/datasets/arboba-rnaseq/arboba-run2/ {} +
mkdir ~/datasets/arboba-rnaseq/arboba-run3 | find ~/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-11_13_17_10Z-141945716/ -type f -name '*.fastq.gz' -exec cp -at ~/datasets/arboba-rnaseq/arboba-run3/ {} +
mkdir ~/datasets/arboba-rnaseq/arboba-run4 | find ~/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-13_14_45_41Z-143225097/ -type f -name '*.fastq.gz' -exec cp -at ~/datasets/arboba-rnaseq/arboba-run4/ {} +
mkdir ~/datasets/arboba-rnaseq/arboba-run5 | find ~/datasets/arboba-rnaseq/FASTQ_Generation_2018-12-15_10_26_29Z-143716575/ -type f -name '*.fastq.gz' -exec cp -at ~/datasets/arboba-rnaseq/arboba-run5/ {} +
```
- Excluir diretórios antigos das lanes
```sh
find ~/datasets/arboba-rnaseq/ -name 'FASTQ*' -exec rm -rf {} \;
```
---

### Organizar as leituras por corrida:
- Concatenar as lanes por corrida (run1, run2, run3, run4, run5)
```sh
#!/bin/bash

for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)

    do echo "sample $i R1 concatenated"

cat "$i"_L00*_R1_001.fastq.gz > "$i"_RUN0_R1_001.fastq.gz

       echo "sample $i R2 concatenated"

cat "$i"_L00*_R2_001.fastq.gz > "$i"_RUN0_R2_001.fastq.gz

done
```
- Excluir as lanes dos diretórios
```sh
find ~/datasets/arboba-rnaseq/ -type f -name '*L00*' -exec rm -rf {} \;
```
---

### Checagem de qualidade (basecalling) por corrida:
- Criar diretórios para os resultados do basecalling
```sh
mkdir ~/datasets/arboba-rnaseq/arboba-run1-fastQC/ && mkdir ~/datasets/arboba-rnaseq/arboba-run2-fastQC/ && mkdir ~/datasets/arboba-rnaseq/arboba-run3-fastQC/ && mkdir ~/datasets/arboba-rnaseq/arboba-run4-fastQC/ && mkdir ~/datasets/arboba-rnaseq/arboba-run5-fastQC/
```
- Realizar basecalling com *fastQC*
```sh
cd ~/datasets/arboba-rnaseq/arboba-run1/
nohup fastqc *.fastq.gz -o ~/datasets/arboba-rnaseq/arboba-run1-fastQC/ -t 20
cd ~/datasets/arboba-rnaseq/arboba-run2/
nohup fastqc *.fastq.gz -o ~/datasets/arboba-rnaseq/arboba-run2-fastQC/ -t 20
cd ~/datasets/arboba-rnaseq/arboba-run3/
nohup fastqc *.fastq.gz -o ~/datasets/arboba-rnaseq/arboba-run3-fastQC/ -t 20
cd ~/datasets/arboba-rnaseq/arboba-run4/
nohup fastqc *.fastq.gz -o ~/datasets/arboba-rnaseq/arboba-run4-fastQC/ -t 20
cd ~/datasets/arboba-rnaseq/arboba-run5/
nohup fastqc *.fastq.gz -o ~/datasets/arboba-rnaseq/arboba-run5-fastQC/ -t 20
```
- Agregar resultados do basecalling com *multiQC*
```sh
cd ~/datasets/arboba-rnaseq/arboba-run1-fastQC/
nohup multiqc -s -i ArbovirusBahiaRun1 -ip -p ~/datasets/arboba-rnaseq/arboba-run1-fastQC/
cd ~/datasets/arboba-rnaseq/arboba-run2-fastQC/
nohup multiqc -s -i ArbovirusBahiaRun2 -ip -p ~/datasets/arboba-rnaseq/arboba-run2-fastQC/
cd ~/datasets/arboba-rnaseq/arboba-run3-fastQC/
nohup multiqc -s -i ArbovirusBahiaRun3 -ip -p ~/datasets/arboba-rnaseq/arboba-run3-fastQC/
cd ~/datasets/arboba-rnaseq/arboba-run4-fastQC/
nohup multiqc -s -i ArbovirusBahiaRun4 -ip -p ~/datasets/arboba-rnaseq/arboba-run4-fastQC/
cd ~/datasets/arboba-rnaseq/arboba-run5-fastQC/
nohup multiqc -s -i ArbovirusBahiaRun5 -ip -p ~/datasets/arboba-rnaseq/arboba-run5-fastQC/
```
- Excluir os diretórios do basecalling (etapa após backup)
```sh
find ~/datasets/arboba-rnaseq/ -name '*fastQC*' -exec rm -rf {} \;
```
---

### Organizar as leituras como um único experimento:
- Organizar as leituras das corrida em um único diretório
```sh
find ./ -type f -name '*.fastq.gz' -exec cp -at ~/datasets/arboba-rnaseq/ {} +
```
- Excluir os diretórios de cada corrida
```sh
find ~/datasets/arboba-rnaseq/ -name '*arboba-run*' -exec rm -rf {} \;
```
- Concatenar as corridas
```sh
#!/bin/bash

for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)

    do echo "sample $i R1 concatenated"

cat "$i"_RUN*_R1_001.fastq.gz > "$i"_R1.fastq.gz

       echo "sample $i R2 concatenated"

cat "$i"_RUN*_R2_001.fastq.gz > "$i"_R2.fastq.gz

done
```
- Excluir as corridas não concatenadas do diretório
```sh
find ~/datasets/arboba-rnaseq/ -type f -name '*RUN*' -exec rm -rf {} \;
```
---

### Checagem de qualidade (basecalling) do experimento:
- Criar diretório para os resultados do basecalling
```sh
mkdir ~/datasets/arboba-rnaseq-fastQC/
```
- Realizar basecalling com *fastQC*
```sh
cd ~/datasets/arboba-rnaseq/
nohup fastqc *.fastq.gz -o ~/datasets/arboba-rnaseq-fastQC/ -t 20
```
- Agregar resultados do basecalling com *multiQC*
```sh
cd ~/datasets/arboba-rnaseq-fastQC/
nohup multiqc -s -i ArbovirusBahiaRNASeq -ip -p ~/datasets/arboba-rnaseq-fastQC/
```
- Excluir o diretório do basecalling (etapa após backup)
```sh
find ~/datasets/ -name '*fastQC*' -exec rm -rf {} \;
```
---

### Contagem e quantificação dos transcritos:
- Obter arquivos do transcriptoma alvo e orgnizar no servidor
    - O trasncriptoma referência humano utilizado será o obtido a partir do genoma anotado GRCh38.p12 release 96 da EMBL-EBI disponível no [Ensembl Genome Browser](http://www.ensembl.org/Homo_sapiens/Info/Index) pré-processado pelo [COMBINE-LAB](https://github.com/COMBINE-lab/salmon).
        - Para baixar o transcrito pré-processado: http://bit.ly/2HUU7S6
        - Para baixar a anotação do trancrito pré-processado: http://ftp.ensembl.org/pub/release-96/gtf/homo_sapiens/Homo_sapiens.GRCh38.96.gtf.gz
```
.
└── arboba-rnaseq
    └── humanGRCh38p12r96_ensembl
            ├── Homo_sapiens.GRCh38.96.gtf
            ├── decoys.ext
            └── gentrome.fa
```
- Descompactar arquivos do trancriptoma referência
```sh
tar -vzxf ~/datasets/arboba-rnaseq/humanGRCh38p12r96_ensembl.tar.gz -C ~/datasets/arboba-rnaseq/humanGRCh38p12r96_ensembl/
gunzip ~/datasets/arboba-rnaseq/humanGRCh38p12r96_ensembl/Homo_sapiens.GRCh38.96.gtf.gz
```
- Construir index com *salmon index*
```sh
nohup ~/softwares/salmon-0.14.0/bin/salmon index -t ~/datasets/arboba-rnaseq/humanGRCh38p12r96_ensembl/gentrome.fa -k 31 --keepDuplicates -p 20 --perfectHash -d ~/datasets/arboba-rnaseq/humanGRCh38p12r96_ensembl/decoys.txt -i arboba_index
```
- Quantificar os transcritos com *salmon quant*
```sh
#!/bin/bash

for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 13- | rev; done | sort | uniq);

do
nohup ~/softwares/salmon-0.14.0/bin/salmon quant -i *_index \
    -l A \
    -1 "$i"_R1.fastq.gz \
    -2 "$i"_R2.fastq.gz \
    -p 20 \
    --seqBias \
    --useVBOpt \
    --validateMappings \
    -g ~/datasets/arboba-rnaseq/humanGRCh38p12r96_ensembl/Homo_sapiens.GRCh38.96.gtf \
    -o salmon_quant/"$i"_quant

done
```
