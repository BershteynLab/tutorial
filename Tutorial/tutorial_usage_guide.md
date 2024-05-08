# Tutorial: Using EMOD

## Running a Simulation

1. Log on to BigPurple - either through SSH or VS Code's SSH function

2. Navigate to the tutorial directory in the command line

3. Run the simulation:
```
sbatch script.sbatch
```
The command `sbatch` is a Slurm command that runs `script.sbatch`. Within that script is an un-commented line which tells python to run your EMOD simulation.

### How do I know it is working?

Within your `tutorial` directory, the `sbatch` command will generate a file with a name like `slurm_[numbers].out`. This is a text file that catches all of the output from the simulation.

Wait about a minute, then open that file. If an error has occurred, you will see the error messages there.

If you see a very long message with the line `Waiting 60 seconds for experiments to complete...` at the bottom, that means the simulation is running.

### What is EMOD doing when we run scenarios?

* Initializes an ensemble of simulation runs. Each simulation run takes its parameters from one of the lines from `resampled_parameter_sets_short.py`. That file contains 100 lines, each of which represents one set of parameters for EMOD. Each simulation run spins up a job on BigPurple, so 100 simulation runs will require 100 separate threads on BigPurple, which uses [Slurm](https://slurm.schedmd.com/overview.html) to manage all of the jobs.
* For each simulation run 
    * EMOD builds a synthetic population
    * Seeds the HIV epidemic
    * Allows the epidemic to proceed forward in time
    * Writes to output certain *reports* documents which are formatted according to the specifications given in the `config.json` file

## Postprocessing

After running the simulation, the next step will [postprocessing](tutorial_postprocessing.md)
