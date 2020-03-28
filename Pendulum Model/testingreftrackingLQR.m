%% LOAD PARAM
clear all;
Parameters = EstimatedParams();
h=0.00002;
close all

%% TRIAL AND ERROR
w = [4, 4, 3.75, 3]; % away from frequencies from the system. 
zeta = [ 0.6, 0.65, 0.7, 1.1];
PoleFunc = @(w,zeta) -w.*zeta+ [w.*sqrt(zeta.^2-1),-w.*sqrt(zeta.^2-1) ];
P2 = [PoleFunc(w(3),zeta(3)), -50.0, -60.0, -100.0];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);
%K2 = place(A, B, P2);
K2 = [-0.0148 8.7739 7.3655 1.3853 0.6376];
%% CHeck for closed loop eigenvalues
Ac2 = A - B*K2;
Ec2 = eig(Ac2);
%% Make Systems+Controller + design reference gain
sysCL2 = ss(Ac2, B, C, D);
figure(1)
impulse(sysCL2);
figure(2)
step(sysCL2);
Kdc = dcgain(sysCL2);
Kr = 1/Kdc(1);
sysCL2_scaled = ss(Ac2, B*Kr, C, D);
figure(4)
step(sysCL2_scaled);
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
Reference = [t;zeros(1,length(t));0.3*sin(t);-0.3*sin(t);zeros(1,length(t));zeros(1,length(t))]';
Parameters.Lff = [0;Kr;0;0;0]';
Parameters.PoleGain = K2;
Test2 = sim('reftracking_LinearTopTest');
timesim=linspace(0,10,length(Test2.Theta_Model.data(:,2:3)));

%% plot
figure(3)
plot(timesim,Test2.Theta_Model.data(:,2:3))
hold on
ref = 0.3*sin(timesim);
plot(timesim,ref)
legend('Theta1','Theta2','Reference');
xlabel('Time [s]');
ylabel('Angle [rad]');
title('Reference tracking pole controller')