#!/bin/bash

#SBATCH --job-name=cow_demux
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=amilan
#SBATCH --time=03:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anthony.grigsby@colostate.edu
#SBATCH --output=data_processing_%j.out

#Activate qiime
module purge
module load qiime2/2024.10_amplicon

mkdir demux

qiime demux emp-paired \
--m-barcodes-file barcodes.txt \
--m-barcodes-column barcode \
--p-rev-comp-mapping-barcodes \
--p-rev-comp-barcodes \
--i-seqs cow_sequences.qza \
--o-per-sample-sequences demux/demux_cow.qza \
--o-error-correction-details demux/cow_demux_error.qza

qiime demux summarize \
--i-data demux/demux_cow.qza \
--o-visualization demux/demux_cow.qzv
