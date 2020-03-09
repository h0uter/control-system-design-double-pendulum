%% Load Data BOUND
[YUnbound, YBound] = LoadData();
YNewData = LoadData2();
firstLocation = YBound(1,:);
simOut = sim('woutModel', 'SrcWorkspace', 'current');
%% LSQnonlin
func = @(x) LSQnonLinfunc(x,YBound, Input, true, firstLocation); % + LSQnonLinfunc(x,YUnbound, Input, false);

% X = [ g, l1, l2, m1,  m2,  c1, c2, I1, I2,b1, b2, km, Te, initialSpeed]
LB = [9.81,   0.09,0.09,   0.05,0.03,   0.01,0.05,  0.02,2.8472e-05,    3, 2.1048e-05,  -60, 0.01, -15.3840];
UB = [9.815,   0.11,0.11,   0.4,0.05,   0.1,0.08,   0.2,2.8472e-05,    10,2.1048e-05,   -10, 0.1, -15.3840];  

%X0 = [9.8125,   0.09,0.1,   0.3,0.0471,  0.0987,0.0737,   0.0786,2.8472e-05,   4.8016,2.1048e-05, ...
%   -59.9994,0.0500, -15.3840];
X0 = [ 9.815, 0.0906, 0.1, 0.3758, 0.0459, 0,0126, 0.0660, 0.02, 2.8472e-05 , 8.4405, ... 
    2.1048e-05, -59.9794, 0.02];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 5);

[x2, resnorm] = lsqnonlin(func,X0,LB,UB, options)
%x = lsqnonlin(func,X0,[9.7, 0.09, 0.09, 0.03, 0.00001, -0.2, 0, 0.05, 0],[9.9,0.15,0.15,0.5, 0.5, 0, 0.1, 0.1], options)
%% Simulating
Parameters = ConvertParams(x2);
initSpeed = x2(14);
firstLocation = YUnbound(1,:)
simOut = sim('woutModel', 'SrcWorkspace', 'current');
ydata = simOut.Theta.data;
%% PLOTTING
figure;
subplot(2,1,1)
plot(ydata(9:10:end-1,1)); hold on;
plot(YUnbound(:,1))
subplot(2,1,2)
plot(ydata(9:10:end-1,2)); hold on;
plot(YUnbound(:,2))
%% 
function YNewData = LoadData2() 
Dataset1 = load('measurements/whitebox/bound1_constantTorque_1.mat');
YNewData = unwrap([Dataset1.Theta1.data, Dataset1.Theta2.data]);
end

function [Transformed] =  transformdata(Dataset1, Dataset2, Dataset3)
Realydata1 = [Dataset1.Theta1.data, Dataset1.Theta2.data];
Realydata2 = [Dataset2.Theta1.data, Dataset2.Theta2.data];
Realydata3 = [Dataset3.Theta1.data, Dataset3.Theta2.data];
Theta1 = [Realydata1(:,1), Realydata2(:,1), Realydata3(:,1)];
Theta2 = [Realydata1(:,2), Realydata2(:,2), Realydata3(:,2)];
Theta1avg = mean(unwrap(Theta1),2);
Theta2avg = mean(unwrap(Theta2),2);
Transformed = [Theta1avg, Theta2avg];

end