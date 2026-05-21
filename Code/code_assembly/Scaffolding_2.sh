#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -t 04:00:00
#SBATCH -J hic_scaffold
#SBATCH -c 4
#SBATCH --mem=32G
#SBATCH -o %j.out
#SBATCH -e %j.err

set -euo pipefail

module load BWA/0.7.18-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0
module load YaHS/1.2.2-foss-2024a

cd $SNIC_TMP

# INPUT
contigs=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta

hiC_R1=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_hiC_R1.fastq.gz

hiC_R2=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_hiC_R2.fastq.gz

outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/HiC_Scfaffolding_2

#mkdir -p "$outdir"

cp "$contigs" .

contigfile=pilon.fasta

echo "Indexing"

bwa index "$contigfile"
samtools faidx "$contigfile"

echo "Mapping HiC"

bwa mem \
   -5SP \
   -t $SLURM_CPUS_PER_TASK \
   "$contigfile" \
   "$hiC_R1" \
   "$hiC_R2" |
samtools view -u - |
samtools sort \
   -@ $SLURM_CPUS_PER_TASK \
   -m 4G \
   -o hiC.sorted.bam -

echo "Validate sorted BAM"

samtools quickcheck hiC.sorted.bam
samtools index hiC.sorted.bam

samtools flagstat hiC.sorted.bam > mapping_stats.txt

echo "Run YaHS"

yahs -l 5000 \
      "$contigfile" \
      hiC.sorted.bam

echo "Name-sort"

samtools sort -n \
    -@ $SLURM_CPUS_PER_TASK \
    -m 4G \
    -o hiC.namesort.bam \
    hiC.sorted.bam

echo "Validate namesort"

samtools quickcheck hiC.namesort.bam

echo "Read counts"

samtools view -c hiC.namesort.bam

echo "Run juicer"

juicer pre \
   -a \
   -q 0 \
   -o out \
   hiC.namesort.bam \
   yahs.out_scaffolds_final.agp \
   pilon.fasta.fai

echo "Check output"

ls -lh out*

cp hiC.sorted.bam "$outdir"
cp hiC.namesort.bam "$outdir"
cp mapping_stats.txt "$outdir"
cp yahs.out* "$outdir"
cp out* "$outdir"
