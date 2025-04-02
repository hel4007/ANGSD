#!/bin/bash
#SBATCH --job-name=STAR_alignment
#SBATCH --output=STAR_alignment.out
#SBATCH --error=STAR_alignment.err
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -p angsd_class

SAMPLES=("female_openEye_Z08_90" "female_occludedEye_Z08_88" "female_occludedEye_Z08_92")
ALIGN_DIR="/athena/angsd/scratch/hel4007/project/alignments"
GENOME_DIR="GRCg7b_STARindex"
THREADS=16

for SAMPLE in "${SAMPLES[@]}"; do
  STAR --runMode alignReads \
       --runThreadN "$THREADS" \
       --genomeDir "$GENOME_DIR" \
       --readFilesIn "${ALIGN_DIR}/${SAMPLE}_1.fastq.gz" "${ALIGN_DIR}/${SAMPLE}_2.fastq.gz" \
       --readFilesCommand zcat \
       --outFileNamePrefix "${ALIGN_DIR}/${SAMPLE}.star." \
       --outSAMtype BAM SortedByCoordinate \
       --genomeSAindexNbases 13
done