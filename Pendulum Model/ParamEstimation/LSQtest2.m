
%% Load Data BOUND
% [YUnbound, YBound] = LoadData();
YBoundData = load('../../measurements/bound1_constantTorque_1.mat');
YBound = [YBoundData.Theta1.data, YBoundData.Theta2.data];
tout = linspace(0,10000,1000000);
Input = [tout', 0.0*ones(1000000,1)];

%% LSQnonlin
func = @(x) LSQnonLinfunc(selectParam(x),YBound, Input, true); % + LSQnonLinfunc(x,YUnBound, Input, true);
initSpeed = 1;
X0 = [9.81, 0.1, 0.01, 0.06,0.00012,0.0002, initSpeed];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 50);
x = lsqnonlin(func,X0,[],[], options);
%x = lsqnonlin(func,X0,[9.7, 0.09, 0.09, 0.03, 0.00001, -0.2, 0, 0.05, 0],[9.9,0.15,0.15,0.5, 0.5, 0, 0.1, 0.1], options)
