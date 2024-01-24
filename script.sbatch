#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --partition=cpu_short
#SBATCH --mem=8GB
#SBATCH --job-name=EMOD_tutorial
#SBATCH --mail-type=END

#SBATCH --chdir=/gpfs/data/bershteynlab/EMOD/<YOUR KID>/tutorial/

#SBATCH --mail-user=<YOUR EMAIL>

#SBATCH --output=/gpfs/data/bershteynlab/EMOD/<YOUR KID>/tutorial/slurm_%j.out

# This line is used when optimizing
# python optim_script.py

# This line is used when there are provided tables of parameters
python run_scenarios.py -c optim_script_transmission.py --resample-method provided --samples resampled_parameter_sets.csv --output-dir sim_output --suite-name sim_output --table scenarios.csv

# This line is used when instead you want to sample from the distribution of parameters
#python run_scenarios.py -c optim_script.py --resample-method roulette --nsamples 250 --output-dir sim_output --suite-name sim_output --table scenarios.csv --calib-dir <CALIB_DIR>