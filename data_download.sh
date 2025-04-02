#!/bin/bash
#SBATCH --job-name=data_download     
#SBATCH --output=Data_download.out
#SBATCH --error=Data_download.err 
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -p angsd_class


SRA_LIST=("SRR28279790" "SRR28279788" "SRR28279792")
declare -A NAME_MAP=(
  ["SRR28279790"]="female_openEye_Z08_90"
  ["SRR28279788"]="female_occludedEye_Z08_88"
  ["SRR28279792"]="female_occludedEye_Z08_92"
)

DEST_DIR="/athena/angsd/scratch/hel4007/project/alignments"
mkdir -p "${DEST_DIR}"

# Download, rename, and bgzip
for RUN_ID in "${SRA_LIST[@]}"; do
  NEW_NAME="${NAME_MAP[$RUN_ID]}"

  echo "=== Processing $RUN_ID -> $NEW_NAME ==="

  # Download
  fastq-dump --split-3 --outdir "${DEST_DIR}" "${RUN_ID}"

  # Rename
  mv "${DEST_DIR}/${RUN_ID}_1.fastq" "${DEST_DIR}/${NEW_NAME}_1.fastq"
  mv "${DEST_DIR}/${RUN_ID}_2.fastq" "${DEST_DIR}/${NEW_NAME}_2.fastq"

  # bgzip
  bgzip -@ 16 "${DEST_DIR}/${NEW_NAME}_1.fastq"
  bgzip -@ 16 "${DEST_DIR}/${NEW_NAME}_2.fastq"
done

echo "All downloads and compressions done in ${DEST_DIR}."

