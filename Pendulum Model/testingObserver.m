%% LOAD PARAM
Parameters = EstimatedParams();
close all
%% TRIAL AND ERROR
P1 = -[10, 15, 300000, 400000, 500000];
P2 = -[15, 150, 3000, 4000, 5000];
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
Parameters.K = K1;
Test1 = sim('LinearTopObserver');
figure;
plot(Test1.Error.data);
Parameters.K = K2;
Test2 = sim('LinearTopObserver');
figure;
plot(Test2.Error.data);
Parameters.K = K3;
Test3 = sim('LinearTopObserver');
figure;
plot(Test3.Error.data);
Parameters.K = K4;
Test4 = sim('LinearTopObserver');
figure;
plot(Test4.Error.data);
%% 
% P1 zijn de poles van de Observer. K1 wordt gebruikt.
