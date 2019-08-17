#!/bin/bash
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
#--fullname:s manter o nome do arquivo que vai ser analisado
#--title: criar um titulo para o relatorio do multiqc
#--interactive: utilizar plots iterativos
#--export: exportar plots das analises do multiqc
