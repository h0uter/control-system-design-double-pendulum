%% LOAD PARAM
clear all;
Parameters = EstimatedParams();
Parameters.disturbance = 1;
h=0.00002;
close all

%% TRIAL AND ERROR
P2 =  -[5, 12, 50, 60, 100];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);
K2 = place(A, B, P2);
%% CHeck for closed loop eigenvalues
Ac2 = A - B*K2;
Ec2 = eig(Ac2);
%% Make Systems+Controller + design reference gain
sysCL2 = ss(Ac2, B, C, D);
figure(1)
impulse(sysCL2);
figure(2)
step(sysCL2);
%% RETRIEVING DATA FROM NL MODEL
firstLocation = [0 0];
firstLocationFull = [ 0 , firstLocation, 0, 0];
time=10;
lengthinput = 8;
lengthSpace = int32(time/(h*lengthinput));
ampl=0.005;
ERRORVAR = [linspace(0,time,lengthSpace)',  -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))'];
Error = ERRORVAR;
Input = [linspace(0,time,lengthSpace)', 0*ones(1,lengthSpace)'];
%% OBSERVE BEST MODEL
t=linspace(0,10,10/h);
Parameters.PoleGain = K2;
Test2 = sim('LinearTopTest');

%% plot
figure(3)
plot(Test2.sim_time.data,Test2.Theta_Model.data(:,2:3))
legend('Theta1','Theta2','Reference');
xlabel('Time [s]');
ylabel('Angle [rad]');
title('Stabilizing pole controller after disturbance of second link at t = 1 second')