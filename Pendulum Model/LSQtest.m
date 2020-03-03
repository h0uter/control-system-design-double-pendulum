
%% Simulate Data;
%X = [9.81, 0.1, 0.1, 0.125, 0.05, -0.04, 0.06, 0.074, 0.00012, 4.8, 0.0002, 50, 0.03];
%Parameters = CoenParams(X);
%tout = linspace(0,10000,1000000);
%Input = [tout', 0.3*ones(1000000,1)];
%RealData = sim('woutModel');
%Input = RealData.Input; % Or something like that. 
%outModel = sim('woutModel');
%Realydata = RealData.Theta.data;
Dataset1 = load('../measurements/bound_constantTorque_1.mat');
Dataset2 = load('../measurements/bound_constantTorque_2.mat');
Dataset3 = load('../measurements/bound_constantTorque_3.mat');
Realydata1 = [Dataset1.Theta1.data, Dataset1.Theta2.data];
Realydata2 = [Dataset2.Theta1.data, Dataset2.Theta2.data];
Realydata3 = [Dataset3.Theta1.data, Dataset3.Theta2.data];
Realydata1 = unwrap(Realydata1);
Realydata2 = unwrap(Realydata2);
Realydata3 = unwrap(Realydata3);
Realydata = [Theta1.data, Theta2.data];
Realydata = unwrap(Realydata);
Theta1mean = mean([Realydata(:,1), Realydata1(:,1), Realydata2(:,1), Realydata3(:,1)], 2)
Realydataavg = [mean([Realydata(:,1), Realydata1(:,1), Realydata2(:,1), Realydata3(:,1)], 2), ...
    mean([Realydata(:,2), Realydata1(:,2), Realydata2(:,2), Realydata3(:,2)], 2)]
%% LSQnonlin
func = @(x) LSQnonLinfunc(x,Realydataavg, Input);

X0 = [9.81, 0.1, 0.1, 0.125, 0.05, -0.04, 0.06, 0.074, 0.00012, 4.8, 0.0002, 50, 0.03];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 8);
x = lsqnonlin(func,X0,[],[], options);
%x = lsqnonlin(func,X0,[9.7, 0.09, 0.09, 0.03, 0.00001, -0.2, 0, 0.05, 0],[9.9,0.15,0.15,0.5, 0.5, 0, 0.1, 0.1], options)
