%% LOAD PARAM
Parameters = EstimatedParams();
PoleFunc = @(w,zeta) -w.*zeta+ [w.*sqrt(zeta.^2-1),-w.*sqrt(zeta.^2-1) ];
w = [4, 4, 3.75, 3]; % away from frequencies from the system. 
zeta = [ 0.6, 0.65, 0.7, 1.1];
P3 = [PoleFunc(w(3),zeta(3)), -50.0, -60.0, -100.0];
Parameters.PoleGain = place(A, B, P3);   
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
%% OBSERVE BEST MODEL
Parameters.K = K1;
Test1 = sim('LinearTopTest');
figure;
plot(Test1.Error.data);
figure;
plot(Test1.Theta_Model.data(:,2:3));
Parameters.K = K11;
Test2 = sim('LinearTopTest');
figure;
plot(Test2.Error.data);
figure;
plot(Test2.Theta_Model.data(:,2:3));
Parameters.K = K3;
Test3 = sim('LinearTopTest');
figure;
plot(Test3.Error.data);
figure;
plot(Test3.Theta_Model.data(:,2:3));
Parameters.K = K4;
Test4 = sim('LinearTopTest');
figure;
plot(Test4.Error.data);
figure;
plot(Test4.Theta_Model.data(:,2:3));
%% 
% P1 zijn de poles van de Observer. K4 wordt gebruikt.
