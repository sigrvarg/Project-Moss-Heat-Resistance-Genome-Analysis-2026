#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 3:00:00 		# time limit
#SBATCH -J hiC    #Job name
#SBATCH -c 2 		# number of cores
#SBATCH --mem 30G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

cd $SNIC_TMP

#load yahs, samtools, bwa for mapping?
module load BWA/0.7.18-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0
module load YaHS/1.2.2-foss-2024a
module load Java/17.0.6

#input files- yahs wahts fasta with contigs, bam with contigs aligned to HiC reads
contigs=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta
hiC_R1=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_hiC_R1.fastq.gz
hiC_R2=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_hiC_R2.fastq.gz

#output directory
outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/HiC_Scaffolding

#index contigs
bwa index $contigs
samtools faidx $contigs

#map HiC reads to contigs and index it 
#5:prioritize 5' end, S:correct secondary split alignment, P:no paired end rescue-can be bad for HiC
bwa mem -5SP -t 2 $contigs $hiC_R1 $hiC_R2 \
    | samtools view -b - \
    | samtools sort -@ 2 -o hiC.sorted.bam

samtools index hiC.sorted.bam

#.bam QC
samtools flagstat hiC.sorted.bam > mapping_stats.txt

#scaffolding with yahs
yahs -l 5000 $contigs hiC.sorted.bam

# YaHS outputs are:
# yahs.out_scaffolds_final.fa
# yahs.out_scaffolds_final.agp

#index scaffolding output
samtools faidx yahs.out_scaffolds_final.fa

#create juicer files
juicer pre \
    hiC.sorted.bam \
    yahs.out_scaffolds_final.agp \
    yahs.out_scaffolds_final.fa.fai \
    > alignments.txt

JUICER=/home/siva5061/bin/juicer/juicer_tools.1.22.01.jar

java -Xmx24G -jar $JUICER pre \
    alignments.txt \
    out.hic \
    yahs.out_scaffolds_final.fa.fai

#copy to uppmax home 
cp -r * $outdir

