#install conda
CONDA

# create conda file environment
cat > seq.yml <<EOF
name: seq
channels:
  - conda-forge
  - bioconda
  - r
dependencies:
  - artic-porechop
  - bcftools
  - biopython
  - bwa
  - canu
  - fastp
  - fastqc
  - gnuplot
  - libiconv
  - nanopolish
  - minimap2
  - parallel
  - perl-vcftools-vcf
  - porechop
  - python
  - racon
  - ragtag
  - r-base
  - r-optparse
  - r-reshape
  - r-reshape2
  - readucks
  - samtools
  - seqkit
  - snakemake
  - vcftools
EOF

# create conda environment
conda env create -f seq.yml

# activate conda environment
source activate seq

# install Guppy (Oxford Nanopore Technologies)
curl https://mirror.oxfordnanoportal.com/software/analysis/ont-guppy_4.2.2_linux64.tar.gz -o $HOME/softwares/ont-guppy.tar.gz
cd $HOME/softwares/ && tar -vzxf ont-guppy.tar.gz && mv ont-guppy/ guppy/ && rm -rf ont-guppy.tar.gz
export PATH=$HOME/softwares/guppy/bin:/usr/local/share/rsi/idl/bin:$PATH
echo 'export PATH=$HOME/softwares/guppy/bin:/usr/local/share/rsi/idl/bin:$PATH' >> $HOME/.bashrc
echo 'export PATH=$HOME/softwares/guppy/bin:/usr/local/share/rsi/idl/bin:$PATH' >> $HOME/.zshrc