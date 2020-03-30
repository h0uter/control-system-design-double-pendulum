%% Load parameters
clear all;
Parameters = EstimatedParams(); %use estimated parameters
Parameters.disturbance = 1;     %toggle on disturbance in NLmodel.slx. See matlab function 4 block in NLmodel for disturbance specification
h=0.00002;
close all

%% Define controller gains and statespace model parameters for simulation
K =  [0.0849 2.6780 2.4547 -0.3203 0.1625]; %pole gains determined form testingpolecontroller.m
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);

%% Initialize position
firstLocation = [0 0];
firstLocationFull = [ 0 , firstLocation, 0, 0];

%% Simulation
Parameters.PoleGain = K;
Test = sim('LinearTopTest');

%% plot
figure(1)
plot(Test.sim_time.data,Test.Theta_Model.data(:,2:3))
legend('Theta1','Theta2','Reference');
xlabel('Time [s]');
ylabel('Angle [rad]');
title('Stabilizing pole controller after disturbance of second link at t = 1 second')