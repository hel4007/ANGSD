#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH --output=multiqc.out
#SBATCH --error=multiqc.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH -p angsd_class

set -euo pipefail

# Initialize conda in this shell
eval "$(conda shell.bash hook)"

# Activate the MultiQC env
conda activate multiqc

# Config
MULTIQC_OUT="multiqc_results"

echo "[$(date)] Creating output dir and running MultiQC"
mkdir -p "$MULTIQC_OUT"
multiqc . -o "$MULTIQC_OUT" --filename "multiqc_report.html"

echo "[$(date)] MultiQC done → $MULTIQC_OUT/multiqc_report.html"
