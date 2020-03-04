YBoundData = load('../measurements/bound1_constantTorque_3.mat');
YBound = [YBoundData.Theta1.data, YBoundData.Theta2.data];
tout = linspace(0,10000,1000000);
Input = [tout', 0.8*ones(1000000,1)];
initSpeed = 1;
X0 = [9.8100,    0.1,    0.1000 ,   0.125,    0.05,   0.04,    0.0601,0.074,  0.0220    ,4.8, ...
    2.0000e-04,   -49.8449,    0.03];
Parameters = CoenParams(X0);
output1 = sim('boundedModel');
thetad = output1.Theta_d.data;
theta = output1.Theta.data;
[thetad, theta]