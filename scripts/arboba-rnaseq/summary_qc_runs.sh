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
#--fullnames: manter o nome do arquivo que vai ser analisado
#--title: criar um titulo para o relatorio do multiqc
#--interactive: utilizar plots iterativos
#--export: exportar plots das analises do multiqc
