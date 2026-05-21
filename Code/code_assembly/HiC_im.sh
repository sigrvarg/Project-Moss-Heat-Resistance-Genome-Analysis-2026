#!/bin/bash 

#SBATCH -A uppmax2026-1-61 
#project code #SBATCH -M pelle 
#SBATCH -t 1:00:00 # time limit 
#SBATCH -J hiC #Job name 
#SBATCH -c 2 # number of cores 
#SBATCH --mem 30G # requested memory 
#SBATCH -o %j.out # File to which standard output will be written 
#SBATCH -e %j.err # File to which standard error will be written 

cd $SNIC_TMP 

module load Java/25.36 
module load SAMtools/1.22.1-GCC-13.3.0 
module load pairtools/1.1.2 
JUICER=/home/siva5061/bin/juicer/juicer_tools.3.0.0.jar 

#input files 
hiC_bam=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/HiC_Scaffolding/hiC.sorted.bam 
yahs_scaffolds=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/HiC_Scaffolding/yahs.out_scaffolds_final.agp 
contigs=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta 
yahs_indexed=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/HiC_Scaffolding/yahs.out_scaffolds_final.fa.fai 
scaffolds=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/HiC_Scaffolding/yahs.out_scaffolds_final.fa 
#outdir 
outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/HiC_Image/HiC_Image_1 

#index contigs 
#samtools faidx $contigs 

#need a chromosome index 
cut -f1,2 $yahs_indexed > chrom.sizes 

#sort bam by name 
samtools sort -n -@ 2 -o hic.nsort.bam $hiC_bam

#create pairs 
pairtools parse \
--chroms-path chrom.sizes \
hic.nsort.bam \
> pairs.pairsam 

pairtools sort pairs.pairsam > pairs.sorted.pairsam
pairtools split --output-pairs pairs.txt pairs.sorted.pairsam 

#paris to hic 
java -Xmx24G -jar $JUICER pre \
pairs.txt \
out.hic \
chrom.sizes

cp -r * $outdir