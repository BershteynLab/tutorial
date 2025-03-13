# Postprocessing 

Postprocessing is the final step, where we read in, aggregate, and interpret the simulation results. You can conduct postprocessing using any tools you like. Our team also has an R library with predefined functions for postprocessing simulation results. (Github repo [here](https://github.com/BershteynLab/EMODAnalyzeR/tree/main).)

[Here]([https://rstudio.hpc.nyumc.org/](https://ondemand.hpc.nyumc.org/)) is a tool for running a remote RStudio server on BigPurple. Start a "Standard R Job" with R version 4.0 or later. An RStudio server will open in your browser. From there, you can change your working directory to `/gpfs/data/bershteynlab/EMOD/<YOUR KID>/tutorial/` and open an R notebook titled [Tutorial/tutorial_postprocessing.rmd](Tutorial/tutorial_postprocessing.rmd) to get started with postprocessing. (You have the option of running postprocessing locally on your own machine, but it's not recommended as it would require downloading many gigabytes of files.)

## Interpreting Simulation Results

For this simulation, we will examine HIV prevalence, incidence, and mortality for all adults. Depending on what research questions you have, you might want to estimate other metrics, or within a specific demographic within your population. Depending on what you want to do, you might need to [alter the configuration files](tutorial_code_components.md).
