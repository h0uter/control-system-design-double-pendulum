%% LOAD PARAM
Parameters = EstimatedParams();
close all
%% TRIAL AND ERROR
P1 = -[0.0001, 0.00155, 6000, 9000, 10000];
P2 = -[1000, 1500, 3000, 4000, 5000];
P3 = -[50, 90, 300, 400, 500];
P4 = -[50, 75, 600, 700, 800];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
sys = ss(A, B, C,0);

h=0.001;
sysd = c2d(sys,h);
Ad = sysd.A;
Bd = sysd.B;
Cd = sysd.C;
Parameters.Ad = Ad;
Parameters.Bd = Bd;

P1disc = exp(P1.*h);
K1 = place(Ad', Cd', P1disc);
K11 = place(A', C', P1);
K2 = place(A', C', P2);
K3 = place(A', C', P3);
K4 = place(A', C', P4);
%% RETRIEVING DATA FROM NL MODEL
firstLocation = [ 0 0];
time=10;
lengthinput = 8;
ampl=0.001;
lengthSpace = int32(time/(h*lengthinput));
Input = [linspace(0,time,lengthSpace)',  -1/2*ampl+ampl*round(rand(1,lengthSpace))'];
Data = sim('woutModel');
Theta = Data.Theta;
%% OBSERVE BEST MODEL
Parameters.K = K1;
Test1 = sim('LinearTopObserverDisc');
figure;
plot(Test1.Error.data);
figure;
plot(Test1.Theta_Model.data(:,4:5));
Parameters.K = K11;
Test2 = sim('LinearTopObserver');
figure;
plot(Test2.Error.data);
figure;
plot(Test2.Theta_Model.data(:,4:5));
Parameters.K = K3;
Test3 = sim('LinearTopObserver');
figure;
plot(Test3.Error.data);
figure;
plot(Test3.Theta_Model.data(:,4:5));
Parameters.K = K4;
Test4 = sim('LinearTopObserver');
figure;
plot(Test4.Error.data);
figure;
plot(Test4.Theta_Model.data(:,4:5));
%% 
% P1 zijn de poles van de Observer. K1 wordt gebruikt.
