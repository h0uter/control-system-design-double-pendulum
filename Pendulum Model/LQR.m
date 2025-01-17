%% load Params
clear all;
close all;
Parameters = EstimatedParams();
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A,B,C,D);
h = Parameters.h;

%% LQR params Wout        
% Q = [0.01 0 0 0 0; % penalize T error
%      0 100 0 0 0; % penalize theta_1 error
%      0 0 100 0 0; % penalize theta_2 error
%      0 0 0 0.01 0; % penalize d_theta_1 error
%      0 0 0 0 0.1]; % penalize d_theta_2 error

Q = [1 0 0 0 0; % penalize T error
     0 1000 0 0 0; % penalize theta_1 error
     0 0 100 0 0; % penalize theta_2 error
     0 0 0 1 0; % penalize d_theta_1 error
     0 0 0 0 1]; % penalize d_theta_2 error

     
R = 2000; % penalize motor effort 100

% determine polegain with LQR solver
[K,S,e] = dlqr(Parameters.Ad, Parameters.Bd, Q, R);

Parameters.PoleGain = K;
A_cl = A - B*K;
sys_cl = ss(A_cl, B, C, 0);

%% initial conditions
X_0 = [ 0, -0.3, 0.1, 0, 0]; % slightly ofcenter

%% RETRIEVING DATA FROM NL MODEL
firstLocation = [ -0.3 0.1];
firstLocationFull = [ 0 , firstLocation, 0, 0];

%% run response to initial conditions
[Y, T, X] = initial(sys_cl, X_0);

%% plotting performance without noise
% response to initial conditions theta1 & theta2
subplot(2, 2, 1)
plot(T, Y(:,1), 'LineWidth', 1)
hold
plot(T, Y(:,2), 'r', 'LineWidth', 1)
legend('theta1','theta2')
xlabel('time')
ylabel('angle (rad)')
title('Response to initial condition')

% actuator effort
subplot(2, 2, 2)
plot(T, -K * X', 'LineWidth', 1)
xlabel('time')
ylabel('effort')
title('actuator effort')

% Pole zero map
subplot(2, 2, [3, 4])
pzmap(sys_cl)
title('pole zero map')

%% CHeck for closed loop eigenvalues
E_cl = eig(A_cl);

%% Make Systems+Controller + design reference gain
Kdc = dcgain(sys_cl);
Kr = 1/Kdc(1);
sys_cl_scaled = ss(A_cl, B*Kr, C, D);

% % compare the step responses to see why scaled ref gain is neccesary to
% % correct steady state error
% figure(4)
% subplot(2, 1, 1);
% step(sys_cl);
% title('Step Response without ref gain')
% subplot(2, 1, 2);
% step(sys_cl_scaled);
% title('Step Response with scaled ref gain')

%% run the linear top model
test_lin_top = sim('LinearTopTest');

%% RETRIEVING DATA FROM NL MODEL
firstLocation = [0 0];
firstLocationFull = [ 0 , firstLocation, 0, 0];
time=10;
lengthinput = 8;
lengthSpace = int32(time/(h*lengthinput));
Input = [linspace(0,time,lengthSpace)', 0*ones(1,lengthSpace)'];

%% OBSERVE BEST MODEL
t=linspace(0,10,10/h);
Reference = [t;zeros(1,length(t));0.3*sin(t);-0.3*sin(t);zeros(1,length(t));zeros(1,length(t))]';
Parameters.Lff = [0;Kr;0;0;0]';
test_ref_track = sim('reftracking_LinearTopTest');
timesim=linspace(0,10,length(test_ref_track.Theta_Model.data(:,2:3)));

%% plot
figure(3)
plot(timesim,test_ref_track.Theta_Model.data(:,2:3))
hold on
ref = 0.3*sin(timesim);
plot(timesim,ref)
legend('Theta1','Theta2','Reference');
xlabel('Time [s]');
ylabel('Angle [rad]');
title('Reference tracking LQR')

%% plotting performance with noise
T = test_lin_top.Theta_Model.time;
u = test_lin_top.UnSaturatedInput;
Y = test_lin_top.Theta_Model.data(:,2:3);

% response to initial conditions theta1 & theta2
figure
subplot(2, 1, 1)
plot(T, Y(:,1), 'LineWidth', 1)
hold
plot(T, Y(:,2), 'r', 'LineWidth', 1)
legend('theta1','theta2')
xlabel('time')
ylabel('angle (rad)')
title('Response to initial condition')

% actuator effort
subplot(2, 1, 2)
plot(u, 'LineWidth', 1)
xlabel('time')
ylabel('effort')
title('actuator effort')

%% plot settling time from noisy model

S2 = SettlingTime(test_lin_top.Theta_Model.data(:,2:3));
settling_time = test_lin_top.Theta_Model.time(S2)
power = CalcInputPower(test_lin_top)

function SettleTime = SettlingTime(data) 
margin = 0.08;
Part1 = find(abs(data(:,1)) > margin);
Part2 = find(abs(data(:,2)) > margin);
SettleTime =  max([Part1; Part2]);
end

function Power = CalcInputPower(dataset) 
Power = rms(dataset.UnSaturatedInput.data)^2;
end