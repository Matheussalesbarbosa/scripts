#!/bin/bash

cd /$HOME/softwares/minionSeq

export PATH=$PATH:/$HOME/softwares/nanopolish
export PATH=$PATH:/$HOME/softwares/miniconda3/bin

source activate minion-seq

snakemake --use-conda
