%% load Params
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
Q = [1 0 0 0 0; % penalize T error
     0 1 0 0 0; % penalize theta_1 error
     0 0 1 0 0; % penalize theta_2 error
     0 0 0 1 0; % penalize d_theta_1 error
     0 0 0 0 1]; % penalize d_theta_2 error
     
R = 1; % penalize motor effort

[K,S,e] = dlqr(Parameters.Ad, Parameters.Bd, Q,R);
% [K2, S2, e2] = lqrd(A, B, Q, R, Parameters.h);

Parameters.PoleGain = K;
A_cl = A - B*K;
sys_cl = ss(A_cl, B, C, 0);
figure;
step(sys_cl);

% run response to initial conditions
[Y, T, X] = initial(sys_cl, X_0);


% Parameters.PoleGain = K;
% Ac = A - B*K;
% sys2 = ss(Ac, B, C, 0);
% figure;
% step(sys2);

%% plotting
subplot(2, 2, 1)
plot(T, Y(:,1))
% xlabel('time')
% ylabel('position (m)')
% axis([0, 10, 0, 1])
title('Response to initial condition')
% grid on

subplot(2, 2, 2)
plot(T, -K * X')

% xlabel('time')
% ylabel('speed (m/s)')
axis([0, 10, -1.5, 1.5])
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
