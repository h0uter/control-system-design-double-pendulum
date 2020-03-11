%% LOAD PARAM
Parameters = EstimatedParams();
close all
%% TRIAL AND ERROR
P1 = -[0.001, 20, 50, 60, 100];
P2 =  -[0.01, 2, 50, 60, 100];
P3 = -[0.01, 10, 500, 600, 1000];
P4 = -[0.001, 10, 500, 600, 1000];
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
step(sysCL1);
figure;
step(sysCL2);
figure;
step(sysCL3);
figure;
step(sysCL4);

%% RETRIEVING DATA FROM NL MODEL
firstLocation = [ 0 0];
h=0.01;
time=8;
lengthinput = 8;
ampl=0.01;
Error = [linspace(0,time,time*100/lengthinput)',  -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', ...
     -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', ...
     -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))', -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))'];
Input = Error(:, 1:3);
Input = [linspace(0,time,time*100/lengthinput)', ampl*ones(1,time/(h*lengthinput))'];
Data = sim('woutModel', 'SrcWorkspace', 'current');
%Theta = Data.Theta;
figure;
plot(Data.Theta.data);
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
plot(Test4.Theta_Model.data(:,1:2));
figure;
plot(Test1.UnSaturatedInput.data);
hold on;
plot(Test2.UnSaturatedInput.data);
plot(Test3.UnSaturatedInput.data);
plot(Test4.UnSaturatedInput.data);
%% 
% P1 zijn de poles van de Observer. K1 wordt gebruikt.
