Welcome! You are looking at the source files of ROT2.1. 

In this ReadME, a small overview of our files will be given. This will follow our report closely.
Map structure: 
 - BlackBox: This contains the scripts necessary to do a black-box estimation
 - Linearization: These files will be used in explaining the linearization of our white-box model. 
 - measurements: A couple of measurements (in .mat files of the physical pendulum)
 - Pendulum Model: All white-box scripts. Almost all files used for creating our report are in here. 
 - Physical Parts: These files contain the physcial model to control the pendulum. It is not necessary to run any of these files in here. 
Scripts directly used for the report: 
2.2: Parameter estimation: Pendulum_Model/ParamEstimation/LSQtest.m
2.3: NL-model: 

Auxillary files: (These files are not needed to be run directly. These are called by other scripts or are purely used in a physical context) 
- calibration2.m and measureAngles: these were used for calibrating the pendulum.
- blackbox/ParamEstimatebb.slx (used for blackbox) 
- Linearisation/LoadTopEstParameters.m
- measurements/* 
- Pendulum_Model/
    - ConvertParams.m: This converts an array of estimated parameters into a struct that is easy to understand and it contains various other parameters for our scripts. (for example, the observer gains if we want to test a controller)
    - EstimatedParams: This contains our results from the parameter estimation
    - RotPendulumV2.slx: This is a simulink shell for the physical pendulum
    - Any Simulink file in general: None of them needs to run by hand. 
- Pendulum_Model/ParamEstimation/
    - LoadData: This file loads the measurements in a smart format. 
    - LSQnonLinFunc: This calculates the error for a given set of parameters.

