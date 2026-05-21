#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 18:00:00 		# time limit
#SBATCH -J 2eggNOG    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 35G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

cd $SNIC_TMP

#input proteins from braker
proteins=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/BRAKER3/braker_3/braker.aa

#braker gtf 
gtf=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/BRAKER3/braker_3/braker.gtf

#output
outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/eggNOG/egg_2

#load eggNOGmapper
module load eggnog-mapper/2.1.13-gfbf-2024a

#where eggNog is maybe
database=/sw/data/uppnex/eggNOG/5.0/rackham/

#run mapper
#i:inout, --itype:input type almost always protein, m:database mode,goevidence:only annotations with experimental support
#-o: outputnamn?
emapper.py \
    -i $proteins \
    --itype proteins \
    --output eggNOG_annotation \
    --output_dir $outdir \
    --data_dir $database \
    --go_evidence experimental \
    --decorate_gff $gtf \
    --decorate_gff_ID_field ID \
    --cpu 1 \
    -m diamond