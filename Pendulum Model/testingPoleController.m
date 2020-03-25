%% LOAD PARAM
clear all;
Parameters = EstimatedParams();
h=0.00002;
close all
%%
%% TRIAL AND ERROR
P1 = -[1, 6, 50.0, 60.0, 100.0];
P2 =  -[1, 12, 50, 60, 100];
P3 = -[2, 10, 50.0, 60.0, 100.0];
P4 = -[10, 16, 50, 60, 100];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);
K1 = place(A, B, P1);
K2 = place(A, B, P2);
K3 = place(A, B, P3);   
K4 = place(A, B, P4);
%% CHeck for closed loop eigenvalues
Ac1 = A - B*K1;
Ac2 = A - B*K2;
Ac3 = A - B*K3;
Ac4 = A - B*K4;
Ec1 = eig(Ac1)
Ec2 = eig(Ac2)
Ec3 = eig(Ac3)
Ec4 = eig(Ac4)
%% Make Systems+Controller
sysCL1 = ss(Ac1, B, C, D);
sysCL2 = ss(Ac2, B, C, D);
sysCL3 = ss(Ac3, B, C, D);
sysCL4 = ss(Ac4, B, C, D);
 figure;
 subplot(2,2,1);
 impulse(sysCL1);
 subplot(2,2,2);
 impulse(sysCL2);
 subplot(2,2,3);
 impulse(sysCL3);
 subplot(2,2,4);
 impulse(sysCL4);

%% RETRIEVING DATA FROM NL MODEL
firstLocation = [ -0.3 0.1];
firstLocationFull = [ 0 , firstLocation, 0, 0];

%% OBSERVE BEST MODEL
Parameters.PoleGain = K1;
tic;
Test1 = sim('LinearTopTest');
Test1time = toc;
figure;
subplot(2,2,1);
plot(Test1.Theta_Model.time,Test1.Theta_Model.data(:,2:3))
title('Model 1');
xlabel('Time [s]');
ylabel('angle [rad]');

Parameters.PoleGain = K2;
Test2timestart = toc;
Test2 = sim('LinearTopTest');
subplot(2,2,2);
plot(Test2.Theta_Model.time,Test2.Theta_Model.data(:,2:3))
title('Model 2');
xlabel('Time [s]');
ylabel('angle [rad]');

Parameters.PoleGain = K3;
Test3 = sim('LinearTopTest');
subplot(2,2,3);
plot(Test3.Theta_Model.time,Test3.Theta_Model.data(:,2:3))
title('Model 3');
xlabel('Time [s]');
ylabel('angle [rad]');

Parameters.PoleGain = K4;
 Test4 = sim('LinearTopTest');
subplot(2,2,4);
plot(Test4.Theta_Model.time,Test4.Theta_Model.data(:,2:3));
title('Model 4');
xlabel('Time [s]');
ylabel('angle [rad]');

figure;
plot(Test1.UnSaturatedInput);hold on;
plot(Test2.UnSaturatedInput);
plot(Test3.UnSaturatedInput);
% plot(Test4.UnSaturatedInput.data); -> Not shown because it is very far
% off. 
title('INPUT');
legend('Controller 1', 'Controller 2', 'Controller 3');
axis([0 10 -1 1]);

figure; 
plot(Test1.Error.data);
title('Error');
figure;
plot(Test2.Error.data);
title('Error');
figure;
plot(Test3.Error.data);
title('Error');
