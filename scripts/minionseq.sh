#!/bin/bash
cd $HOME/softwares/minionSeq
source $HOME/softwares/miniconda3/bin/activate minion-seq
nohup snakemake --use-conda --ignore-incomplete
