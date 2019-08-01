#!/bin/bash

#SBATCH --account=snechem
#SBATCH --time=2-00:00:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=16
#SBATCH --mem=0
#SBATCH --mail-type=ALL
#SBATCH --mail-user=caleb.hill@uwyo.edu

f=$1

infile="${f%????}.mph"
outfile="${f%????}_out.mph"
logfile="${f%????}.log"   

module load comsol
scontrol show hostnames | uniq > slurm_hostfile

comsol -nn $SLURM_JOB_NUM_NODES -nnhost 1 -np 16 batch -mpibootstrap slurm -mpifabrics tcp \
    -inputfile $infile \
    -outputfile $outfile \
    -batchlog $logfile \
    -f slurm_hostfile \
    -mpmode owner