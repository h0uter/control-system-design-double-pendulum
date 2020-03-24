%% LOAD PARAM
clear all;
Parameters = EstimatedParams();
h=0.00002;
close all
%%
%% TRIAL AND ERROR
P1 = -[.5, 1.2, 50.0, 60.0, 100.0];
P2 =  -[5, 12, 50, 60, 100];
%P3 = -[0.01, 2, 500, 600, 1000];
P3 = -[10, 16, 500, 600, 1000];
P4 = -[10, 16, 50, 60, 100];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);
%K1 = [ 0, 0, 0 , 0 , 0];
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
firstLocation = [ 0 0];
firstLocationFull = [ 0 , firstLocation, 0, 0];
time=10;
lengthinput = 8;
lengthSpace = int32(time/(h*lengthinput));
ampl=0.005;
ERRORVAR = [linspace(0,time,lengthSpace)',  -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))'];
Error = ERRORVAR;
 %Input = Error(:, 1:2);
Input = [linspace(0,time,lengthSpace)', 0*ones(1,lengthSpace)'];
%Data = sim('woutModel', 'SrcWorkspace', 'current');
%Theta = Data.Theta;
%figure;
%plot(Data.Theta.data);
%% OBSERVE BEST MODEL
t=linspace(0,10,10/h);
Reference = [t;0.3*sin(t)]';

Parameters.PoleGain = K1;
Parameters.PoleReferenceGain = K1;
tic;
Test1 = sim('reftracking_LinearTopTest');
Test1time = toc;
%figure(1)
%subplot(2,1,1);
%plot(Test1.Theta_Model.data(:,2:3))

Parameters.PoleGain = K2;
% Parameters.PoleReferenceGain = X2;

Test2timestart = toc;
Test2 = sim('reftracking_LinearTopTest');
timesim=linspace(0,10,length(Test2.Theta_Model.data(:,2:3)));

figure(2)
plot(timesim,Test2.Theta_Model.data(:,2:3))
hold on
ref = 0.3*sin(timesim);
plot(timesim,ref)
legend('Theta1','Theta2','Reference');
xlabel('Time [s]');
ylabel('Angle [rad]');
title('Reference tracking pole controller')

%Parameters.PoleGain = K3;
% Parameters.PoleReferenceGain = X1;
% Test3 = sim('LinearTopTest');
%subplot(2,2,3);
%plot(Test3.Theta_Model.data(:,2:3))
%Parameters.PoleGain = K4;
% Parameters.PoleReferenceGain = X1;
% Test4 = sim('LinearTopTest');
%subplot(2,1,4);
%plot(Test4.Theta_Model.data(:,2:3));
%figure(3)

%plot(Test1.UnSaturatedInput.data);
%title('INPUT');
%hold on;
%plot(Test2.UnSaturatedInput.data);
%plot(Test3.UnSaturatedInput.data);
%plot(Test4.UnSaturatedInput.data);
%figure(4); 
%plot(Test1.Error.data);
%hold on;
%plot(Test2.Error.data);
%plot(Test3.Error.data);
%plot(Test4.Error.data);

%title('Error');
%figure;

%plot(Test2.RealTheta.data);
%title('TRUE THETA');
%% 
% P1 zijn de poles van de Observer. K1 wordt gebruikt.
