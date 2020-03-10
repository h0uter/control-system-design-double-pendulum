%% Load Parameters
Parameters = EstimatedParams();
%% RETRIEVE TESTDATA 
h=0.01;
time=10;
lengthinput = 8;
ampl=0.02;
signal2 = [linspace(0,time,time*100/lengthinput)',  -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))'];
% out = sim('ParamEstimate.slx');
%% TEST MODEL
Thetadata = [Theta1.data, Theta2.data];
Theta.Time = Theta1.Time;
Theta.data = Thetadata;
Test = sim('LinearTopV2');