#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/ && \
multiqc --fullnames --title ArbovirusBahiaRNASeq --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-concatenated/
#--fullnames: manter o nome do arquivo que vai ser analisado
#--title: criar um titulo para o relatorio do multiqc
#--interactive: utilizar plots iterativos
#--export: exportar plots das analises do multiqc
