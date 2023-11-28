# Tutorial: Using EMOD

## Running a Simulation

1. Log on to BigPurple
2. Use `screen` to open a virtual machine - this way if you disconnect from BigPurple for any reason you can return to your work.
3. Request a short- or medium-sized compute node: `srun -p cpu_medium -n 2 --mem-per-cpu=8G --time=05-00:00:00 --pty bash`
4. Use the `run_scenarios.py` script to run the simulation

### What is EMOD doing when we run scenarios?

* Initializes an ensemble of simulation runs. Each simulation run takes its parameters from one of the lines from `resampled_parameter_sets.py`. Each simulation run spins up a job on BigPurple, so 250 simulation runs will require 250 separate threads on BigPurple, which uses [Slurm](https://slurm.schedmd.com/overview.html) to manage all of the jobs.
* For each simulation run 
    * EMOD builds a synthetic population
    * Seeds the HIV epidemic
    * Allows the epidemic to proceed forward in time
    * Writes to output certain *reports* documents which are formatted according to the specifications given in the `config.json` file
* The reason why you request a compute node is because the main simulation script will be running on that node while the other simulation runs on the other threads. The reason why that compute node runs in a screen is to make sure the job doesn't get killed in the event that you become disconnected from BigPurple.

## Postprocessing

After running the simulation, the next step will [postprocessing](tutorial_postprocessing.md)
