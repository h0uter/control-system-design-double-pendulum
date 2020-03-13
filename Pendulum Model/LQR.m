%% load Params
close all;
Parameters = EstimatedParams();
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
sys = ss(A,B,C,0);
h = Parameters.h;

%% LQR params
Q = diag([0, 10, 10^5, 10000, 100]);
R = 1000;
[K,S,e] = dlqr(Parameters.Ad, Parameters.Bd, Q,R);
[K2, S2, e2] = lqrd(A, B, Q, R, Parameters.h);
Parameters.PoleGain = K;
Ac = A - B*K;
sys2 = ss(Ac, B, C, 0);
figure;
step(sys2);
%% Simulate variance
firstLocationFull = [ 0, -0.4, 0.4, 0 ,0];
firstLocation = [-0.3, 0.4];
time=10;
lengthinput = 8;
lengthSpace = int32(time/(h*lengthinput));
ampl=0.001;
ERRORVAR = [linspace(0,time,lengthSpace)',  -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))'];
%% 

tic;
%figure;
%plot(Theta_Model.data(:,2:3))
%figure;
%plot(UnSaturatedInput);
%% 
Parameters.PoleGain = K2;
tic;
Test2 = sim('LinearTopTest');
toc;
figure;
plot(Test2.Theta_Model.data(:, 2:3));
figure; 
plot(Test2.UnSaturatedInput)