%% load Params
clear all;
close all;
Parameters = EstimatedParams();
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
sys = ss(A,B,C,0);
h = Parameters.h;
% bode(sys)
%% LQR params orig
% Q = diag([0, 10, 10^5, 10000, 100]);
% R = 1000;
% [K,S,e] = dlqr(Parameters.Ad, Parameters.Bd, Q,R);
% [K2, S2, e2] = lqrd(A, B, Q, R, Parameters.h);
% Parameters.PoleGain = K;
% Ac = A - B*K;
% sys2 = ss(Ac, B, C, 0);
% figure;
% step(sys2);
%% initial conditions
X_0 = [ 0, -0.4, 0.4, 0, 0]; % slightly ofcenter

%% LQR params Wout        
Q = [0.01 0 0 0 0; % penalize T error
     0 100 0 0 0; % penalize theta_1 error
     0 0 100 0 0; % penalize theta_2 error
     0 0 0 0.01 0; % penalize d_theta_1 error
     0 0 0 0 0.1]; % penalize d_theta_2 error
     
R = 100; % penalize motor effort

[K,S,e] = dlqr(Parameters.Ad, Parameters.Bd, Q, R);
% [K2, S2, e2] = lqrd(A, B, Q, R, Parameters.h);

Parameters.PoleGain = K;
A_cl = A - B*K;
sys_cl = ss(A_cl, B, C, 0);
figure;
step(sys_cl);

% run response to initial conditions
[Y, T, X] = initial(sys_cl, X_0);
%% plotting
subplot(2, 2, 1)
plot(T, Y(:,1), 'LineWidth', 1)
hold
plot(T, Y(:,2), 'r', 'LineWidth', 1)
legend('theta1','theta2')
xlabel('time')
ylabel('angle (rad)')
% axis([0, 10, 0, 1])
title('Response to initial condition')
% grid on

subplot(2, 2, 2)
plot(T, -K * X', 'LineWidth', 1)

xlabel('time')
ylabel('effort')
% axis([0, 0.1, -2, 2])
title('actuator effort')
% grid on

subplot(2, 2, [3, 4])
pzmap(sys_cl)

% xlabel('time')
% ylabel('speed (m/s)')
% axis([0, 10, -1.5, 1.5])
title('pole zero map')
% grid on
%% Simulate variance
% firstLocationFull = [ 0, -0.4, 0.4, 0 ,0];
% firstLocation = [-0.3, 0.4];
% time=10;
% lengthinput = 8;
% lengthSpace = int32(time/(h*lengthinput));
% ampl=0.001;
% ERRORVAR = [linspace(0,time,lengthSpace)',  -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
%      -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
%      -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))'];
%% 
% tic;
%figure;
%plot(Theta_Model.data(:,2:3))
%figure;
%plot(UnSaturatedInput);
%% 
% Parameters.PoleGain = K2;
% tic;
% Test2 = sim('LinearTopTest');
% toc;
% figure;
% plot(Test2.Theta_Model.data(:, 2:3))
% 
% figure; 
% plot(Test2.UnSaturatedInput);

%% animate the pendulum from data

% t = Test2.Theta_Model.Time;
% y = Test2.Theta_Model.Data(:, 2:3);
% 
% for k=1:length(t)
%     % plot only the fifth step each time
%     if mod(k, 15) == 0
%         drawpend(y(k,:));
%     end
% end

%%
% P2 =  K;
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);
K2 = K;
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
title('Reference tracking LQR')
