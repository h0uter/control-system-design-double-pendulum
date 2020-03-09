%% LOAD PARAM
Parameters = EstimatedParams();
close all
%% TRIAL AND ERROR
P1 = -[0.5, 0.9, 1.5, 1.9, 5];
P2 = -[0.01, 0.02, 0.03, 0.04, 0.05];
P3 = -[100, 1100, 1200, 1300, 1400];
P4 = -[1, 2, 3, 4, 5];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
K1 = place(A, B, P1);
K2 = place(A, B, P2);
K3 = place(A, B, P3);
K4 = place(A, B, P4);
%% RETRIEVING DATA FROM NL MODEL
firstLocation = [ 0 0];
h=0.001;
time=10;
lengthinput = 8;
ampl=0.8;
% Input = [linspace(0,time,time*1000/lengthinput)',  -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))'];
Input = [linspace(0,time,time*1000/lengthinput)', ampl*ones(1,time/(h*lengthinput))'];
Data = sim('woutModel');
Theta = Data.Theta;
figure;
plot(Data.Theta);
%% OBSERVE BEST MODEL
Parameters.PoleGain = K1;
Parameters.PoleReferenceGain = K1;
Test1 = sim('LinearTopV2');
figure;
subplot(2,2,1);
plot(Test1.Theta_Model.data(:,1:2))

Parameters.PoleGain = K2;
% Parameters.PoleReferenceGain = X2;
Test2 = sim('LinearTopV2');
subplot(2,2,2);
plot(Test2.Theta_Model.data(:,1:2))

Parameters.PoleGain = K3;
% Parameters.PoleReferenceGain = X1;
Test3 = sim('LinearTopV2');
subplot(2,2,3);
plot(Test3.Theta_Model.data(:,1:2))
Parameters.PoleGain = K4;
% Parameters.PoleReferenceGain = X1;
Test4 = sim('LinearTopV2');
subplot(2,2,4);
plot(Test4.Theta_Model.data(:,1:2))
%% 
% P1 zijn de poles van de Observer. K1 wordt gebruikt.
