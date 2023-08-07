# EMOD Tutorial

This directory is also available [on our team's dropbox](https://www.dropbox.com/scl/fo/tqqdo0hz0n9p8it0ung7i/h?rlkey=7rr4jfye75rc2kp6dcwycn220&dl=0)

The purpose of this repo is as a tutorial for getting you started using EMOD

# Steps

1. Download and install EMOD-DTK according to [these instructions](https://www.dropbox.com/scl/fo/q0xz7rjct84bnh03osax6/h?rlkey=qclqhe60yjvqo7v8kv6zofqqo&dl=0)
2. Clone this repo into your personal directory in the `bershteynlab` directory on bigpurple: `/gpfs/data/bershteynlab/EMOD/<your KID>`
3. To run a simulation:

    1. Use `screen` to open a virtual machine
    2. Request a medium-sized compute node: `srun -p cpu_medium -n 2 --mem-per-cpu=8G --time=05-00:00:00 --pty bash`
    3. Use the `run_scenarios.py` script to run the simulation

4. Postprocessing

# Components of a model

1. Ingest form: `Data/calibration_ingest_form_Nyanza.xlsm`
    * Contains a great deal of information which the simulation uses as inputs, including
        * List of dynamic parameters which will be fit during the calibration stage
        * List of calibration target variables and how the calibration stage should weight them
        * List of "nodes" or sub-populations in the model, what we use to define geographically isolated metapopulations
        * All calibration target data (empirical data used to calibrate the model)
2. Input files:

    1. Demographics: `InputFiles/Static/Demographics.json`
        * Contains births, deaths, and other demographic data
    2. Campaign file: `InputFiles/Templates/campaign_Nyanza_baseline_202301.json`
        * Defines full structure of the cascade of events which occur in the simulation
        * Together, this set of events contains all events which define 
            * How the HIV care cascade occurs
            * How individuals interact with the healthcare system
            * When and how interventions are distributed - testing and treatment
    3. Accessiblity and Risk IP Overlay : `InputFiles/Templates/Accessibility_and_Risk_IP_Overlay.json`
        * Assigns *individual properties* to individuals
        * Includes risk levels and accessibility (whether or not person has access to care)
    4. PFA_Overlay: `InputFiles/Templates/PFA_Overlay.json`
        * Defines pair formation algorithm according to likelihood of pair formation between different demographic groups
    5. Risk_Assortivity_Overlay: `InputFiles/Templates/Risk_Assortivity_Overlay.json`
        * Defines how different risk groups form partnerships
    6. Configuration file: `InputFiles/Templates/config.json`
        * Overwrites all other parameter values, also useful for formatting outputs
        * (Not all of these parameters are required to build a functioning model, many of them are atavistic cruft relevant to other models that have been copy-pasted through)

# Other scripts and files

1. `optim_script.py` - this is used to calibrate the simulation, it contains a number of important parameters which are then referenced when the simulation is run
2. `run_scenarios.py` - this is a python script used to run scenarios
3. `scenarios.csv` - this is a spreadsheet which lists all of the scenarios. You can use this spreadsheet to adjust certain parameters depending on what the scenario needs - used as an input for `run_scenarios.py`
4. `simtools.ini` - this is a shell script which defines the paths to where outputs go, the type of compute nodes that are used to spin up simulation threads
5. `resampled_parameter_sets.csv` - spreadsheet of parameter sets, resampled from the distribution of possible parameter values - used as an input for `run_scenarios.py`

# What is EMOD doing when we run scenarios?

* Initializes an ensemble of simulation runs. Each simulation run takes its parameters from one of the lines from `resampled_parameter_sets.py`. Each simulation run spins up a job on BigPurple, so 250 simulation runs will require 250 separate threads on BigPurple, which uses [Slurm](https://slurm.schedmd.com/overview.html) to manage all of the jobs.
* For each simulation run 
    * EMOD builds a synthetic population
    * Seeds the HIV epidemic
    * Allows the epidemic to proceed forward in time
    * Writes to output certain *reports* documents which are formatted according to the specifications given in the `config.json` file

# Installation guide

It is recommended that you clone this repo in your personal folder in the Bershteyn lab group directory:

`/gpfs/data/bershteynlab/EMOD/[YOUR FOLDER]`

## Steps for Installing EMOD and DTK-Tools

Follow these steps to install EMOD and DTK-Tools on BigPurple (NYU Langone's cluster):

## Configure bash and python environment

1. `ssh` into BigPurple
2. Create a virtual python environment for the purpose of holding all the python packages that DTK-Tools depends on. Run the following in the command line:

```
python -m venv ~/environments/dtk-tools-p36
source ~/environments/dtk-tools-p36/bin/activate
```

3. Modify the bash environment to automatically launch the python environment just created. Paste the following into the `.bashrc` file:

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

Run in command line: `source ~/.bashrc`

## Install DTK-Tools and Disease-Specific Packages

Use git to install DTK-Tools and packages specific to HIV.

1. Make sure that you have access to the Institute for Disease Modeling's github repos. Both dtk-tools and HIV-Analyzers are private, so your github account must be given permission to view and clone 
2. Set up a public key on BigPurple and add the key to github. This will allow you to clone and directly download EMOD and DTK-Tools from github onto BigPurple.
    * [Generate a new ssh key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
    * [Add your key to your github account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
3. Clone the DTK-Tools repo.
In your `home` directory on BigPurple, run the following in the command line:
    ```
    cd ~
    git clone git@github.com:InstituteforDiseaseModeling/dtk-tools.git dtk-tools-p36
    cd dtk-tools-p36
    python setup_manual.py
    ```
In the command line run `dtk -h` to confirm installation.

4. Clone the HIV-analyzers repo
In your `home` directory on BigPurple, run the following in the command line:

    ```
    cd ~
    git clone git clone git@github.com:InstituteforDiseaseModeling/HIV-Analyzers.git
    cd HIV-Analyzers
    python setup.py develop
    ```

5. Install Docker image to run simulations.
The Docker image creates a virtual environment where all of the packages and extensions required to run EMOD smoothly already exist. This saves the trouble of needing to re-install and re-configure them. Run the following in the command line:

    ```
    cd ~
    mkdir images
    cd images
    singularity pull docker://idm-docker-public.packages.idmod.org/nyu/dtk:20200306
    ```
## Simulation Setup

The `simtools.ini` file defines the paths where the simulation looks for inputs and writes outputs.

It is recommended practice to store simulation outputs in the `scratch` directory on BigPurple. This is a private directory which can be used for temporary storage. In `simtools.ini`, set the simulation root path to this location:

```
# Path where the experiment/simulation outputs will be stored
sim_root = /gpfs/scratch/[YOUR NAME]/experiments`
```
    
Set the `input_root` as the path to the current directory:

```
input_root = /gpfs/data/bershteynlab/EMOD/[YOUR FOLDER]/malawi2022_tutorial/InputFiles/Static
```
    