# Troubleshooting EMOD-HIV

## Schema

The "schema" of the EMOD-DTK build is the easiest way to see how the various EMOD functions are formatted and what arguments they take.

For instance, if EMOD has been updated and I need to know whether a particular event handler takes table argument as a dictionary or a list of lists, this is how I find that out.

The problem is: EMOD will use default values for everything if it receives a campaign file with incorrect formatting. Sometimes this results in an error, but also sometimes it does not. The schema will make the debugging easier.

One of the things that makes looking at the schema tricky is that it is hidden inside a singularity image, so we need to pass commands to a path inside of that singularity image.

1. Find the simtools.ini `exe_path` (eg: `cd /gpfs/data/bershteynlab/EMOD/bin`)
2. Find and enter the singularity shell - this will have a .sif suffix (eg: `singularity shell /gpfs/data/bershteynlab/EMOD/singularity_images/centos_dtk-build.sif`)
3. Ask for the schema: `./EradicationMalaria-Ongoing_2023_01_05 --get-schema --schema-path test.json`

## Failures During Calibration

### Config file improperly formatted

In the error out files, "bad json_cast" is cited as the reason for the optimization script failing.

### Analyzers fail due to type mismatch during merge

Only the OnART observer sheet allows for anything other than integer years. So if the year 2015.5 is used in one of the other observer sheets this will cause an error.

### Analyzers fail due to mismatched age brackets

Need to make sure that the ages collected for Report_HIV_ByAgeAndGender in the `config.json` file (see: Report_HIV_ByAgeAndGender_Collect_Age_Bins_Data) line up with the age brackets in the ingest form.

### Calibration appears stuck

If the model parameters remain flat (In `Optimization_State_Evolution.pdf`) across multiple iterations, very likely this is because the initial conditions are in a very awkward local optimum and there's no direction that the calibration algorithm can move in that would lead to an improvement.

Recommended practices: try changing the starting conditions. Also, try changing the population scale factor

### Calibration does not recognize full list of dynamic parameters

If certain dynamic parameters are missing from the calibration

* Check that the KP_marker variables in the ingest file and `optim_script.py` correctly match the campaign file
* Check that the ingest file isn't corrupted; might need to re-build from scratch

## Run Scenarios 

### Does not download experiments

The simulations run but no output is created.

Often this is an error, driven by something that is wrong with the config file.

### Individual Properties not recognized
Individual properties are initially defined in Accessibility_and_Risk_IP_Overlay.json
These are stored as dictionaries and define the allowable properties. 
These need to be defined separately for *all* nodes in the simulation.

### Commissioning
Errors during commissioning occur when you run into space issues. Often this occurs if the simulation is being run on the login node instead of a compute node.

### Bus Error
`bus error` usually shows up when there's a memory problem in the login node, similar to errors during commissioning

### Container Not Found

This issue arises when the path to the singularity image is incorrect.

## Too slow

Remember: compute time scales with population size, so as long as population is growing the compute time will grow quadratically with the duration of the simulation. Can shorten the duration of the simulation in order to save compute time

## Other diagnostics

EMOD - add ReportSimulationStats to custom_reports.json - this is a way to create a report which will help diagnose what's gone wrong.