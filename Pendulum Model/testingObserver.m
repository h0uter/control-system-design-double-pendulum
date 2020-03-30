%% LOAD PARAM
Parameters = EstimatedParams();
PoleFunc = @(w,zeta) -w.*zeta+ [w.*sqrt(zeta.^2-1),-w.*sqrt(zeta.^2-1) ];
w = [4, 4, 3.75, 3]; % away from frequencies from the system. 
zeta = [ 1.05, 1, 1.5, 2.1];
PR3 = [PoleFunc(3.75,0.7), -50.0, -60.0, -100.0];
Parameters.PoleGain = place(A, B, PR3);   
close all
%% TRIAL AND ERROR
P1 = [PoleFunc(25,zeta(1)), -200.0, -300.0, -500.0];
P2 = [PoleFunc(25,zeta(2)), -200.0, -300.0, -500.0];
P3 = [PoleFunc(25,zeta(3)), -500.0, -600.0, -1000.0];
P4 = [PoleFunc(40,zeta(4)), -500.0, -600.0, -1000.0];
A = Parameters.LinTopA;
B = Parameters.LinTopB;
Parameters.PoleGain = place(A, B, PR3);   
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
firstLocation = [ -0.3 0.1];
firstLocationFull = [ 0 firstLocation 0.1 0.0];
%% OBSERVE BEST MODEL
Parameters.K = K1;
Test1 = sim('LinearTopTest');
figure;

plot(Test1.Error.data);
figure;
subplot(2,1,1);
plot(Test1.RealTheta);
subplot(2,1,2);
plot(Test1.Theta_Model.time,Test1.Theta_Model.data(:,2:3));
Parameters.K = K11;
Test2 = sim('LinearTopTest');
figure;
plot(Test2.Error)
figure;
subplot(2,1,1);
plot(Test2.RealTheta);
subplot(2,1,2);
plot(Test2.Theta_Model.time,Test2.Theta_Model.data(:,2:3));

Parameters.K = K3;
Test3 = sim('LinearTopTest');
figure;
plot(Test3.Error.data);
figure;
subplot(2,1,1);
plot(Test3.RealTheta);
subplot(2,1,2);
plot(Test3.Theta_Model.time, Test3.Theta_Model.data(:,2:3));
Parameters.K = K4;
Test4 = sim('LinearTopTest');
figure;
plot(Test4.Error.data);
figure;
subplot(2,1,1);
plot(Test4.RealTheta);
subplot(2,1,2);
plot(Test4.Theta_Model.time,Test4.Theta_Model.data(:,2:3));
%% 
% P1 zijn de poles van de Observer. K4 wordt gebruikt.
