%% LOAD PARAM
clear all;
Parameters = EstimatedParams();
close all
%%
%% TRIAL AND ERROR
P1 = -[0.001, 1, 5, 6, 10];
P2 =  -[0.001, 1, 5, 6, 10];
P3 = -[0.01, 2, 500, 600, 1000];
%P3 = -[0.001, 0.01, 0.05, 0.06, 1];
P4 = -[0.001, 0.01, 0.05, 0.06, 1];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
D = [ 0 ; 0];
sys = ss(A, B, C,D);
K1 = [ 0, 0, 0 , 0 , 0];
%K1 = place(A, B, P1);
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
%step(sysCL1);
%figure;
%step(sysCL2);
%figure;
%step(sysCL3);
%figure;
%step(sysCL4);

%% RETRIEVING DATA FROM NL MODEL
firstLocation = [ 0 0.02];
h=0.01;
time=10;
lengthinput = 8;
ampl=0.5;
ERRORVAR = [linspace(0,time,time*100/lengthinput)',  -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', ...
     -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', ...
     -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))'];
%Input = Error(:, 1:2);
Input = [linspace(0,time,time*100/lengthinput)', 0*ones(1,time/(h*lengthinput))'];
Data = sim('woutModel', 'SrcWorkspace', 'current');
%Theta = Data.Theta;
%figure;
%plot(Data.Theta.data);
%% OBSERVE BEST MODEL
Parameters.PoleGain = K1;
Parameters.PoleReferenceGain = K1;
Test1 = sim('LinearTopTest');
figure;
subplot(2,2,1);
plot(Test1.Theta_Model.data(:,2:3))

Parameters.PoleGain = K2;
% Parameters.PoleReferenceGain = X2;
Test2 = sim('LinearTopTest');
subplot(2,2,2);
plot(Test2.Theta_Model.data(:,2:3))

Parameters.PoleGain = K3;
% Parameters.PoleReferenceGain = X1;
Test3 = sim('LinearTopTest');
subplot(2,2,3);
plot(Test3.Theta_Model.data(:,2:3))
Parameters.PoleGain = K4;
% Parameters.PoleReferenceGain = X1;
Test4 = sim('LinearTopTest');
subplot(2,2,4);
plot(Test4.Theta_Model.data(:,2:3));
figure;
plot(Test1.UnSaturatedInput.data);
hold on;
plot(Test2.UnSaturatedInput.data);
plot(Test3.UnSaturatedInput.data);
plot(Test4.UnSaturatedInput.data);
%% 
% P1 zijn de poles van de Observer. K1 wordt gebruikt.
