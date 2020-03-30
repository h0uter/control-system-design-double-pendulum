%% LOAD PARAM
clear all;
Parameters = EstimatedParams();
h=0.00002;
close all
%% Setting up the system
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
sys = ss(A, B, C,0);
damp(sys)
%% Setting up formulas and do it the right way


PoleFunc = @(w,zeta) -w.*zeta+ [w.*sqrt(zeta.^2-1),-w.*sqrt(zeta.^2-1) ];
w = [4, 4, 3.75, 3]; % away from frequencies from the system. 
zeta = [ 0.6, 0.65, 0.7, 1.1];
PoleFunc(w',zeta')
P1 = [PoleFunc(w(1),zeta(1)), -50.0, -60.0, -100.0];
P2 = [PoleFunc(w(2),zeta(2)), -50.0, -60.0, -100.0];
P3 = [PoleFunc(w(3),zeta(3)), -50.0, -60.0, -100.0];
P4 = [PoleFunc(w(4),zeta(4)), -50.0, -60.0, -100.0];

%% TRIAL AND ERROR
%P1 = -[1, 6, 50.0, 60.0, 100.0];
%P2 =  -[1, 12, 50, 60, 100];
%P3 = -[complex(1, 4) , complex(1, -4), 50, 60, 100];
%P4 = -[complex(2, 2) , complex(2, -2), 50, 60, 100];
%% Place Poles
K1 = place(A, B, P1);
K2 = place(A, B, P2);
K3 = place(A, B, P3);   
K4 = place(A, B, P4);
% %% CHeck for closed loop eigenvalues
% Ac1 = A - B*K1;
% Ac2 = A - B*K2;
% Ac3 = A - B*K3;
% Ac4 = A - B*K4;
% %% Make Systems+Controller
% sysCL1 = ss(Ac1, B, C, 0);
% sysCL2 = ss(Ac2, B, C, 0);
% sysCL3 = ss(Ac3, B, C, 0);
% sysCL4 = ss(Ac4, B, C, 0);
%  figure;
%  subplot(2,2,1);
%  impulse(sysCL1);
%  subplot(2,2,2);
%  impulse(sysCL2);
%  subplot(2,2,3);
%  impulse(sysCL3);
%  subplot(2,2,4);
%  impulse(sysCL4);

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
%% Additional Figures
figure;
plot(Test1.UnSaturatedInput);hold on;
plot(Test2.UnSaturatedInput);
plot(Test3.UnSaturatedInput);
plot(Test4.UnSaturatedInput); 
title('INPUT');
legend('Controller 1', 'Controller 2', 'Controller 3', 'Controller 4');
axis([0 10 -1 1]);
%% Calculating the table

S1 = SettlingTime(Test1.Theta_Model.data(:,2:3));
S2 = SettlingTime(Test2.Theta_Model.data(:,2:3));
S3 = SettlingTime(Test3.Theta_Model.data(:,2:3));
S4 = SettlingTime(Test4.Theta_Model.data(:,2:3));
SettlingTimes = [Test1.Theta_Model.time(S1);
    Test2.Theta_Model.time(S2);
    Test3.Theta_Model.time(S3);
    Test4.Theta_Model.time(S4)]
InputPower = [CalcInputPower(Test1),CalcInputPower(Test2), ...
    CalcInputPower(Test3),CalcInputPower(Test4)]
function SettleTime = SettlingTime(data) 
margin = 0.05;
Part1 = find(abs(data(:,1)) > margin);
Part2 = find(abs(data(:,2)) > margin);
SettleTime =  max([Part1; Part2]);
end
function Power = CalcInputPower(dataset) 
Power = rms(dataset.UnSaturatedInput.data)^2;
end
