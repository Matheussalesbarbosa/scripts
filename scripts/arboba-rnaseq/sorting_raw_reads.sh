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
