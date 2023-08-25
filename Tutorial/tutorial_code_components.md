# Components of an EMOD model

EMOD requires a large set of configuration files.

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