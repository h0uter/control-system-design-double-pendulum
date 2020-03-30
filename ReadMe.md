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
2.3: NL-model: Check out Pendulum_Model/NLmodel.slx to see the implementation of it. 
2.4: Linearization: Linearisation/LoadTopEstParameters.m
3: Black-Box: blackbox/blackboxestimation.m
4: Pole-placement controller: 
    - Pendulum_Model/testingPoleController.m
    -reference: Pendulum_Model/testingreftracking_pole
    - Disturbance: Pendulum_Model/testingPoleControllerDisturbance.m
5: LQR:
    - Pendulum_Model/LQR.m
    - reference: Pendulum_Model/testingreftrackingLQR.m
    - Disturbance: testingLQRDisturbance.m
6: Observer: Pendulum_Model/testingObserver.m

Auxillary files: (These files are not needed to be run directly. These are called by other scripts or are purely used in a physical context) 
- calibration2.m and measureAngles: these were used for calibrating the pendulum.
- blackbox/ParamEstimatebb.slx (used for blackbox) 
- Linearisation/LoadTopEstParameters.m
- measurements/* 
- Pendulum_Model/
    - ConvertParams.m: This converts an array of estimated parameters into a struct that is easy to understand and it contains various other parameters for our scripts. (for example, the observer gains if we want to test a controller)
    - EstimatedParams: This contains our results from the parameter estimation
    - RotPendulumV2.slx: This is a simulink shell for the physical pendulum
    - Any Simulink file in general: None of them needs to run by hand. However, some might be interesting to deepen the understanding of the scripts. 
- Pendulum_Model/ParamEstimation/
    - LoadData: This file loads the measurements in a smart format. 
    - LSQnonLinFunc: This calculates the error for a given set of parameters.

