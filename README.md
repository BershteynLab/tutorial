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

1. Ingest form - contains calibration target data: `Data/calibration_ingest_form_Nyanza.xlsm`
2. Input files:

    1. Demographics - contains births, deaths, and other demographic data: `InputFiles/Static/Demographics.json`
    2. Campaign file - contains all of the interventions which define a model: `InputFiles/Templates/campaign_Nyanza_baseline_202301.json`
    3. PFA_Overlay - defines pair formation algorithm: `InputFiles/Templates/PFA_Overlay.json`
    4. Accessiblity and Risk IP Overlay - assigns *individual properties* to individuals: `InputFiles/Templates/Accessibility_and_Risk_IP_Overlay.json`
    5. Risk_Assortivity_Overlay - defines how different risk groups form partnerships: `InputFiles/Templates/Risk_Assortivity_Overlay.json`
    6. Configuration file - overwrites all other parameter values, also useful for formatting outputs: `InputFiles/Templates/config.json`