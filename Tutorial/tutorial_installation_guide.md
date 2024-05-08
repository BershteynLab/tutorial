# Installation Guide

## Download Tutorial Repo

Download the appropriate scripts, configuration files, and parameter sets for this tutorial by cloning this git repo onto BigPurple. BigPurple is the NYU Medical Center's high performance computing cluster. BigPurple is where EMOD is installed and where we run our simulation models. There are a number of ways to do this, one way is to use a command line interface (CLI) through Terminal or PuTTY. (Another way is to use VS Code's SSH capabilities.):

```
ssh <YOUR_KID>@bigpurple.nyumc.org
```

Create and navigate to your personal folder in our team's directory:

```
mkdir /gpfs/data/bershteynlab/EMOD/<YOUR_KID>

cd /gpfs/data/bershteynlab/EMOD/<YOUR_KID>
```

Make sure that you have access to git while you are logged in to BigPurple. To do this, you will need to [generate a public key on BigPurple](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and [add it to your account on Github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

Clone our git repository.

```
git clone https://github.com/BershteynLab/tutorial.git

cd tutorial
```

Create a new branch, to keep track of your edits as you work:

```
git branch <YOUR NAME>

git checkout <YOUR NAME>
```

You have downloaded the code, and have created your own personalized workspace for working with that code. Feel free to edit any documents you want and track your changes using git. The main branch will contain the original version of everything, which may help with debugging.

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

module load singularity/3.7.1
module load python/cpu/3.6.5
module load git/2.17.0

source ~/environments/dtk-tools-p36/bin/activate
export PYTHONPATH=~/environments/dtk-tools-p36/lib/python3.6/site-packages
```

4. Create a virtual environment by running each of the following commands in the CLI.

```
python -m venv ~/environments/dtk-tools-p36

source ~/environments/dtk-tools-p36/bin/activate

source ~/.bashrc
```

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
cd ..
```

Verify that the installation worked by running `dtk -h`. (If you do not get an error, you will know the installation has worked.)

4. Install HIV-specific repo from github:

```
git clone git@github.com:InstituteforDiseaseModeling/HIV-Analyzers.git
cd HIV-Analyzers
python setup.py develop
cd ..
```

5. Configuring DTK-Tools to use slurm

Slurm is the name of the high performance computing jobs scheduling system on BigPurple. Read more about it [here](https://hpcmed.org/guide/slurm).

DTK-Tools makes use of a file called `simtools.ini` in order to work with Slurm in Linux.

Rewrite the `simtools.ini` file in the following ways:
* Change the `sim_root` by adding in your KID - this is where the simulation outputs will go
* Change the `input_root` to point to the correct 
* Change the `notification_email` to your NYU email

### Configure Simulation Run Script

Open the file `script.sbatch` and edit the following lines to include your KID and your email where appropriate:

```
#SBATCH --chdir=/gpfs/data/bershteynlab/EMOD/<YOUR KID>/tutorial/

#SBATCH --mail-user=<YOUR EMAIL>

#SBATCH --output=/gpfs/data/bershteynlab/EMOD/<YOUR KID>/tutorial/slurm_%j.out
```

We will use this script to run our simulations.

## Next steps

After downloading the DTK-Tools repo, configuring your python environment, and configuring DTK-Tools to use Slurm on BigPurple, [you should now be ready to run your first EMOD simulation.](tutorial_usage_guide.md)
