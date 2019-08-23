#!/bin/bash
# criar diretorio
mkdir $HOME/datasets/arboba-rnaseq/concatenated
# copiar as lanes para diretorios de cada corrida (run1, run2, run3, run4, run5)
find $HOME/datasets/arboba-rnaseq/run -type f -name '*.fastq.gz' -exec cp -at $HOME/datasets/arboba-rnaseq/concatenated {} +
