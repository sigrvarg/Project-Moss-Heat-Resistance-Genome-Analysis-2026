#!/bin/bash

#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle 
#SBATCH -J braker3
#SBATCH -c 1
#SBATCH -t 24:00:00
#SBATCH --mem=96GB
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err

cd $SNIC_TMP

#set -euo pipefail

outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/BRAKER3/braker_3
masked_genome=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Repeatmasker/pilon.fasta.masked
prot_seq=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/BRAKER3/C_purpureus.faa
c1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/Control_1_f1_sorted.bam
c2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/control_2_sorted.bam
c3=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/Control_3_f1_sorted.bam
h1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/Heat_1_f1_sorted.bam
h2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/heat_2_sorted.bam
h3=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/heat_3_sorted.bam

# temporary working directory
#WORKDIR=$SNIC_TMP/braker3_run

#create temporary working directory
#mkdir -p $WORKDIR

#make path to braker so it can be used
export AUGUSTUS_CONFIG_PATH=$HOME/bin/augustus_config

#run braker
singularity exec \
    -B /gorilla/home/siva5061:/gorilla/home/siva5061 \
    --env AUGUSTUS_CONFIG_PATH=$AUGUSTUS_CONFIG_PATH \
    /crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/braker3.sif \
    braker.pl \
    --genome $masked_genome \
    --bam $c1,$c2,$c3,$h1,$h2,$h3 \
    --prot_seq=$prot_seq \
    --softmasking  \
    --min_contig 5000 \
    --species moss_1 \
    --AUGUSTUS_CONFIG_PATH=$AUGUSTUS_CONFIG_PATH \
    --threads 1 \
    --workingdir $outdir

# copy results back
#cp $WORKDIR/* $FINAL_OUT/
