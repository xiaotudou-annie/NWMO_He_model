# NWMO_He_model

NWMO funded research project aiming to constrain porewater ages using helium isotopes. The Monte Carlo model models the diffusive transport of helium through the precambrian basement.

Version 0.0.1

Authors `Anran Cheng`

Email `annie512cheng@gmail.com`

## Table of Contents

- [Installation](#installation)
- [Scripts](#scripts)
- [Steps](#steps)
- [Results](#results)

## Installation

The model requires MATLAB (2019 and later versions) to be installed and the toolbox 'Statistics and Machine Learning Toolbox' to be added.

## Scripts

- `R0_mc.m`: the script to start the Monte Carlo model, in which user can define the number of trials for the Monte Carlo model, and plots the results.
- `R0_simple_box_constant_flux_He.m`: the script called by R0_mc, the main script that defines input parameters for each Monte Carlo trials. 
- `Import_parameters.m`: extract input parameters, including helium flux, age etc, from 'Porewater report BH04.xlsx'.
- `build_parameter_matrix.m`: build parameters into matrix for each length and time step.
- `Calc_cold_flux_RRa_conc.m`: calculate the helium concentration for each time step.
- `Cgroup_RRa_pro_flush_differentDe.m`: defines the parameter of each rock unit and calls 'Calc_cold_flux_RRa_conc.m'.
- `diagA.m`: build a matrix of constant for diffusion calculation.
- `frequency_plot_transparency.m`: plot the result with transparency reflecting the frenquency.
- `He_acc.m`: calculate radiogenic helium production.
- `plot_4He_end.m`: plot helium distribution for each trial run for the Monte Carlo model.
- `sw_dens0.m`: density of seawater at atmospheric pressure.
- `sw_smow.m`: denisty of standard mean ocean water (pure water).

## Steps
1. Open 'Porewater report BH04.xlsx' and change the parameters as desired.
2. Open R0_mc.m in MATLAB and click run.

## Results
1. When the program finishes running, a figure demonstrating the vertical distribution of helium concentration will be plot with higher transparency indicating the lower freqency. 
2. 'mc_parameters_collection.mat' is generated upon completion. It contains variable'Conc_He4_collection' which is a matrix of the vertical distribution of helium concentration in cm3 STP/cm3 for the 200 trials.
