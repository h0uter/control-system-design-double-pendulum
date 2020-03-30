%% LOAD PARAM
clear all;
Parameters = EstimatedParams();
h=0.00002;
close all

%% Define controller gains and statespace model parameters for simulation
K = [-0.0148 8.7739 7.3655 1.3853 0.6376]; %pole gains determined from testing LQR.m
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);

%% Design reference gain
Ac2 = A - B*K;
sysCL = ss(Ac2, B, C, D);
Kdc = dcgain(sysCL);
Kr = 1/Kdc(1);

%% Initialize position
firstLocation = [0 0];
firstLocationFull = [ 0 , firstLocation, 0, 0];

%% OBSERVE BEST MODEL
t=linspace(0,10,10/h);
Reference = [t;zeros(1,length(t));0.3*sin(t);-0.3*sin(t);zeros(1,length(t));zeros(1,length(t))]';
Parameters.Lff = [0;Kr;0;0;0]';
Parameters.PoleGain = K;
Test = sim('reftracking_LinearTopTest');

%% plot
figure(1)
plot(Test.sim_time.data , Test.Theta_Model.data(:,2:3))
hold on
plot(Reference(:,1),Reference(:,3))
legend('Theta1','Theta2','Reference');
xlabel('Time [s]');
ylabel('Angle [rad]');
title('Reference tracking LQR controller')