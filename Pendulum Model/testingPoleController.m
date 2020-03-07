%% LOAD PARAM
Parameters = EstimatedParams();
close all
%% TRIAL AND ERROR
P1 = -[1, 2, 3, 4, 5];
P2 = -[1, 2, 30, 40, 50];
P3 = -[1, 2, 300, 400, 500];
P4 = -[80, 100, 1200, 1400, 1600];
A = Parameters.LinTopA';
B = Parameters.LinTopXY';
K1 = place(A, B, P1);
K2 = place(A, B, P2);
K3 = place(A, B, P3);
K4 = place(A, B, P4);
%% RETRIEVING DATA FROM NL MODEL
firstLocation = [ 0 0];
h=0.01;
time=10;
lengthinput = 8;
ampl=0.01;
Input = [linspace(0,time,time*100/lengthinput)',  -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))'];
Data = sim('woutModel');
Theta = Data.Theta;
%% OBSERVE BEST MODEL
Parameters.PoleGain = K1;
Parameters.PoleReferenceGain = X1;
Test1 = sim('LinearTopV2');
figure;
plot(Test1.Error.data);

Parameters.PoleGain = K2;
Parameters.PoleReferenceGain = X2;
Test2 = sim('LinearTopV2');
figure;
plot(Test2.Error.data);

Parameters.PoleGain = K1;
Parameters.PoleReferenceGain = X1;
Test1 = sim('LinearTopV2');
figure;
plot(Test1.Error.data);Parameters.PoleGain = K1;
Parameters.PoleReferenceGain = X1;
Test1 = sim('LinearTopV2');
figure;
plot(Test1.Error.data);
%% 
% P1 zijn de poles van de Observer. K1 wordt gebruikt.
