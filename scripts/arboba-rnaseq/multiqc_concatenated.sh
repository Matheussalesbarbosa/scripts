#!/bin/bash
cd $HOME/datasets/arboba-rnaseq-fastQC/
nohup multiqc --fullnames --title ArbovirusBahiaRNASeq --interactive --export $HOME/datasets/arboba-rnaseq-fastQC/
#--fullname:s manter o nome do arquivo que vai ser analisado
#--title: criar um titulo para o relatorio do multiqc
#--interactive: utilizar plots iterativos
#--export: exportar plots das analises do multiqc
