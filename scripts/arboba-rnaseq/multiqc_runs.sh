#!/bin/bash
cd $HOME/datasets/arboba-rnaseq/qc/qc-run1/ && nohup multiqc --fullnames --title ArbovirusBahiaRun1 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run1/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run2/ && nohup multiqc --fullnames --title ArbovirusBahiaRun2 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run2/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run3/ && nohup multiqc --fullnames --title ArbovirusBahiaRun3 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run3/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run4/ && nohup multiqc --fullnames --title ArbovirusBahiaRun4 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run4/
cd $HOME/datasets/arboba-rnaseq/qc/qc-run5/ && nohup multiqc --fullnames --title ArbovirusBahiaRun5 --interactive --export $HOME/datasets/arboba-rnaseq/qc/qc-run5/
#nohup: permite executar o comando em segundo plano
#--fullnames: manter o nome do arquivo que vai ser analisado
#--title: criar um titulo para o relatorio do multiqc
#--interactive: utilizar plots iterativos
#--export: exportar plots das analises do multiqc
