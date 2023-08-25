# Installation Guide

## Download Tutorial Repo

Download the appropriate scripts, configuration files, and parameter sets for this tutorial by cloning this git repo onto BigPurple

Create and navigate to your personal folder in our team's directory:

```
mkdir /gpfs/data/bershteynlab/EMOD/<YOUR_KID>

cd /gpfs/data/bershteynlab/EMOD/<YOUR_KID>

git clone https://github.com/BershteynLab/tutorial.git

cd tutorial
```

## Download and install EMOD-DTK

### Configure bash and python environments

Running EMOD requires a certain python environment. The first step is to modify your `.bashrc` file such that you open the correct python environment each time you log on to BigPurple.

1. ssh into BigPurple
2. Open your `.bashrc` file using the editor of your choice. I recommend `code ~/.bashrc` if you're working in VSC, but you can also use `emacs` or `nano` to do the same thing.
3. Paste the following text into your `.bashrc` file: 

```
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

module load singularity/3.1
module load python/cpu/3.6.5
module load git/2.17.0

source ~/environments/dtk-tools-p36/bin/activate
export PYTHONPATH=~/environments/dtk-tools-p36/lib/python3.6/site-packages
```

4. Create a virtual environment by running each of the following commands

* `python -m venv ~/environments/dtk-tools-p36`
* `source ~/environments/dtk-tools-p36/bin/activate`
* `source ~/.bashrc `

Now, every time you log on to BigPurple you will be working inside the right python environment. All of your python work (e.g. installing packages, sourcing packages) will use the environment “dtk-tools-p36” because of the final source command above.

### Installing DTK-Tools and Disease-Specific Packages

1. Request permissions

Write to Clark Kirkman <Clark.Kirkman@gatesfoundation.org> to request permission to clone the following repos:
* <https://github.com/InstituteforDiseaseModeling/dtk-tools>
* <https://github.com/InstituteforDiseaseModeling/HIV-Analyzers>

2. Pick an appropriate directory to download these repos

We recommend installing these in your home directory, located at `/gpfs/home/<Your_KID>`. Navigate there (you can use `cd ~`) before the following steps.

3. Clone dtk-tools repo from github:

```
git clone git@github.com:InstituteforDiseaseModeling/dtk-tools.git dtk-tools-p36
cd dtk-tools-p36
python setup_manual.py
```

Verify that the installation worked by running `dtk -h`

4. Install HIV-specific repo from github:

```
git clone git clone git@github.com:InstituteforDiseaseModeling/HIV-Analyzers.git
cd HIV-Analyzers
python setup.py develop
```

5. Configure Docker image

IDM provides Docker image files that contain the EMOD executable binary and execution environment for easy runtime and environment management. University cluster environments typically have Singularity installed which is able to run Docker images. Docker is unlikely to be available itself.

To obtain the Docker image needed for building and executing EMOD, run:

```
mkdir images
cd images
singularity pull docker://idm-docker-public.packages.idmod.org/nyu/dtk:20200306
```

This will create file: dtk_20200306.sif. It will be referenced when configuring DTK-Tools to run EMOD.

6. Configuring DTK-Tools to use slurm

Slurm is the name of the high performance computing jobs scheduling system on BigPurple. Read more about it [here](https://hpcmed.org/guide/slurm).

DTK-Tools makes use of a file called `simtools.ini` in order to work with Slurm in Linux.

Rewrite the `simtools.ini` file in the following ways:
* Change the `sim_root` by adding in your KID - this is where the simulation outputs will go
* Change the `input_root` to point to the correct 
* Change the `notification_email` to your NYU email

## Running a Simulation

1. Use `screen` to open a virtual machine - this way if you disconnect from BigPurple for any reason you can return to your work.
2. Request a medium-sized compute node `srun -p cpu_medium -n 2 --mem-per-cpu=8G --time=05-00:00:00 --pty bash`
3. Use the `run_scenarios.py` script to run the simulation

### What is EMOD doing when we run scenarios?

* Initializes an ensemble of simulation runs. Each simulation run takes its parameters from one of the lines from `resampled_parameter_sets.py`. Each simulation run spins up a job on BigPurple, so 250 simulation runs will require 250 separate threads on BigPurple, which uses [Slurm](https://slurm.schedmd.com/overview.html) to manage all of the jobs.
* For each simulation run 
    * EMOD builds a synthetic population
    * Seeds the HIV epidemic
    * Allows the epidemic to proceed forward in time
    * Writes to output certain *reports* documents which are formatted according to the specifications given in the `config.json` file

## Postprocessing

Postprocessing is the final step, where we read in, aggregate, and interpret the simulation results. You can conduct postprocessing using any tools you like. Our team also has an R library with predefined functions for postprocessing simulation results. (Github repo [here](https://github.com/BershteynLab/EMODAnalyzeR/tree/main).)

[Here](https://rstudio.hpc.nyumc.org/) is a tool for running a remote RStudio server on BigPurple. Start a "Standard R Job" with R version 4.0 or later. An RStudio server will open in your browser. From there, you can open [this notebook](tutorial_postprocessing.rmd) to get started with postprocessing. (You have the option of running postprocessing locally on your own machine, but it's not recommended as it would require downloading many gigabytes of files.)
