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
