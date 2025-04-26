#!/bin/bash
#SBATCH --job-name=fastqc_pipeline
#SBATCH --output=FastQC_Pipeline.out
#SBATCH --error=FastQC_Pipeline.err
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH -p angsd_class

set -euo pipefail

# ─── CONFIG ────────────────────────────────────────────────────────────────────
THREADS=$SLURM_CPUS_PER_TASK
GTF="chickannotation.gtf"

FASTQC_OUT="fastqc_results"
# ─── PREP ──────────────────────────────────────────────────────────────────────
echo "[$(date)] Creating output directories"
mkdir -p "$FASTQC_OUT" 

# ─── 1) FASTQC ────────────────────────────────────────────────────────────────
echo "[$(date)] Running FastQC (angsd env)"
conda run -n angsd \
  fastqc -t "$THREADS" -o "$FASTQC_OUT" *.fastq.gz *.fastq
