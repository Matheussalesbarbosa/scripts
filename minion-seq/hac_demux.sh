#!/bin/bash

THREADS="12" #12
NUMCALLER="46" #NVIDIAGeForceRTX2060=60; NVIDIAGeForceRTX2080=46
GPUPERDEVICE="64" #NVIDIAGeForceRTX2060=32; NVIDIAGeForceRTX2080=64

RAWDIR="/path/directory/"
HACDEMUXDIR="/path/directory/"

BARCODEKIT="" #EXP-NBD104
FLOWCELL="" #FLO-MIN106
SEQKIT="" #SQK-LSK109

LIBNAME=""

SAMPLEID1=""
SAMPLEID2=""
SAMPLEID3=""
SAMPLEID4=""
SAMPLEID5=""
SAMPLEID6=""
SAMPLEID7=""

guppy_basecaller -r -i ${RAWDIR} -s ${HACDEMUXDIR} --flowcell ${FLOWCELL} --kit ${SEQKIT} --barcode_kits ${BARCODEKIT} --require_barcodes_both_ends --trim_barcodes --qscore_filtering --num_barcode_threads ${THREADS} -x auto --gpu_runners_per_device 32 --num_callers 60 --verbose_logs
source activate pycoQC
pycoQC -q -f ${HACDEMUXDIR}/sequencing_summary.txt -o ${LIBNAME}_qc.html --report_title ${LIBNAME}
[ -d "${HACDEMUXDIR}/pass/barcode*" ] && cat ${HACDEMUXDIR}/pass/barcode01/*.fastq ${HACDEMUXDIR}/pass/barcode02/*.fastq > ${SAMPLEID1}.fastq
[ -d "${HACDEMUXDIR}/pass/barcode*" ] && cat ${HACDEMUXDIR}/pass/barcode03/*.fastq ${HACDEMUXDIR}/pass/barcode04/*.fastq > ${SAMPLEID2}.fastq
[ -d "${HACDEMUXDIR}/pass/barcode*" ] && cat ${HACDEMUXDIR}/pass/barcode05/*.fastq ${HACDEMUXDIR}/pass/barcode06/*.fastq > ${SAMPLEID3}.fastq
[ -d "${HACDEMUXDIR}/pass/barcode*" ] && cat ${HACDEMUXDIR}/pass/barcode07/*.fastq ${HACDEMUXDIR}/pass/barcode08/*.fastq > ${SAMPLEID4}.fastq
[ -d "${HACDEMUXDIR}/pass/barcode*" ] && cat ${HACDEMUXDIR}/pass/barcode09/*.fastq ${HACDEMUXDIR}/pass/barcode10/*.fastq > ${SAMPLEID5}.fastq
[ -d "${HACDEMUXDIR}/pass/barcode*" ] && cat ${HACDEMUXDIR}/pass/barcode11/*.fastq ${HACDEMUXDIR}/pass/barcode12/*.fastq > ${SAMPLEID6}.fastq
[ -d "${HACDEMUXDIR}/pass/unclassified" ] && cat ${HACDEMUXDIR}/pass/unclassified/*.fastq > ${SAMPLEID7}.fastq