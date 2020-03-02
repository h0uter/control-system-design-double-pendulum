
%% Simulate Data;
X = [9.81, 0.1, 0.1, 0.125, 0.05, -0.04, 0.06, 0.074, 0.00012, 4.8, 0.0002, 50, 0.03];
Parameters = CoenParams(X);
tout = linspace(0,10000,1000000);
Input = [tout', 0.3*ones(1000000,1)];
% RealData = sim('RealModel');
% Input = RealData.Input; % Or something like that. 
outModel = sim('woutModel');
Realydata = outModel.Theta.data;
%% LSQnonlin
func = @(x) LSQnonLinfunc(selectParam(x),Realydata, Input);

X0 = [0.08, 0.04, 4.7, 0.0001];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 30);
x = lsqnonlin(func,X0,[0, 0, 1, 0],[1,1,20,1], options)
