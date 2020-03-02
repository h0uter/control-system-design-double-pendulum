
%% Simulate Data;
%X = [9.81, 0.1, 0.1, 0.125, 0.05, -0.04, 0.06, 0.074, 0.00012, 4.8, 0.0002, 50, 0.03];
%Parameters = CoenParams(X);
%tout = linspace(0,10000,1000000);
%Input = [tout', 0.3*ones(1000000,1)];
%RealData = sim('woutModel');
%Input = RealData.Input; % Or something like that. 
%outModel = sim('woutModel');
%Realydata = RealData.Theta.data;
Realydata = [Theta1.data, Theta2.data];
Realydata = unwrap(Realydata);
%% LSQnonlin
func = @(x) LSQnonLinfunc(x,Realydata, Input);

X0 = [9.81, 0.1, 0.1, 0.125, 0.05, -0.04, 0.06, 0.074, 0.00012, 4.8, 0.0002, 50, 0.03];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 19);
x = lsqnonlin(func,X0,[9.7, 0.07, 0.07, 0.03, 0.00001],[9.9,0.15,0.07,0.1, 0.0005], options)
