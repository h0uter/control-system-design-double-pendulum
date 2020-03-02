
%% Simulate Data;
%X = [9.81, 0.1, 0.1, 0.125, 0.05, -0.04, 0.06, 0.074, 0.00012, 4.8, 0.0002, 50, 0.03];
%Parameters = CoenParams(X);
% tout = linspace(0,10000,1000000);
% RealData = sim('woutModel');
% Input2 = RealData.Input; % Or something like that. 
Realydata = [Theta1.data, Theta2.data];
%Realydata2= RealData.Theta.data;
%% LSQnonlin
func = @(x) LSQnonLinfunc(selectParam(x),Realydata, Input);

X0 = [9.81, 0.1, 0.1, 0.06,0.074 ];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 30);
x = lsqnonlin(func,X0,[5, 0, 0, 0, 0],[15,1,1,1, 1], options)
