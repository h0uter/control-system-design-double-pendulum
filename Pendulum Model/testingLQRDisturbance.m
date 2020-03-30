%% Load parameters
clear all;
Parameters = EstimatedParams();         %use estimated parameters
Parameters.disturbance = 1;             %toggle on disturbance in NLmodel.slx. See matlab function 4 block in NLmodel for disturbance specification
h=0.00002;
close all

%% Define controller gains and statespace model parameters for simulation
K =  [-0.0148 8.7739 7.3655 1.3853 0.6376];    %pole gains determined from testing LQR.m
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
legend('Theta1','Theta2');
xlabel('Time [s]');
ylabel('Angle [rad]');
title('Stabilizing LQR controller after disturbance of second link at t = 1 second')