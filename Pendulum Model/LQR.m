%% load Params
close all;
Parameters = EstimatedParams();
A = Parameters.LinTopA;
B = Parameters.LinTopB;
C = Parameters.LinTopXY;
sys = ss(A,B,C,0);
h = Parameters.h;

%% LQR params
Q = [zeros(1,5);
    zeros(2,1),0.1*eye(2), zeros(2);
    zeros(2,5);];
R = 10^7;
[K,S,e] = dlqr(Parameters.Ad, Parameters.Bd, Q,R);
Parameters.PoleGain = K;
%Ac = A - B*K;
%sys2 = ss(Ac, B, C, 0);
%figure;
%step(sys2);
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
Test1 = sim('LinearTopTest_discrete');
toc;
figure;
plot(Theta_Model.data(:,2:3))
figure;
plot(UnSaturatedInput);