YBoundData = load('../measurements/bound1_constantTorque_3.mat');
YBound = [YBoundData.Theta1.data, YBoundData.Theta2.data];
tout = linspace(0,10000,1000000);
Input = [tout', 0.0*ones(1000000,1)];
initSpeed = 1;
X0 = [9.8100,    0.0991,    0.1000 ,   0.1251,    0.050,   -0.040,    0.0600,    0.0744,   0.00012    ,4.8, ...
    0.0002,   -50,    0.0307];
Parameters = CoenParams(X0);
output1 = sim('boundedModel');
thetad = output1.Theta_d.data;
theta = output1.Theta.data;
[thetad, theta]