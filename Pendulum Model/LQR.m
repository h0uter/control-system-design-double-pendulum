%% load Params
close all;
Parameters = EstimatedParams();
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
sys = ss(A,B,C,0);
h = 0.00001;
%% LQR params
Q = [zeros(1,5);
    zeros(2,1), 1000*eye(2), zeros(2);
    zeros(2,5);];
R = 0.51;
[K,S,e] = lqr(sys, Q,R);
Parameters.PoleGain = K;
Ac = A - B*K;
sys2 = ss(Ac, B, C, 0);
figure;
step(sys2);
%% Simulate variance
firstLocation = [ -0.00 0];

time=10;
lengthinput = 8;
lengthSpace = int32(time/(h*lengthinput));
ampl=0.001;
ERRORVAR = [linspace(0,time,lengthSpace)',  -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))', ...
     -1/2*ampl+ampl*round(rand(1,lengthSpace))', -1/2*ampl+ampl*round(rand(1,lengthSpace))'];
%% 

tic;
Test1 = sim('LinearTopTest');
toc;
figure;
plot(Test1.Theta_Model.data(:,2:3))