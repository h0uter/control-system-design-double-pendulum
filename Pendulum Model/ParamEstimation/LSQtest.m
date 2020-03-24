%% Load Data BOUND
close all;
load('ParameterTest.mat');
[YUnbound, YBound, RealyBoundDataS, RealyUnboundS, time] = LoadData();
YNewData = LoadData2(); %Used in estimating 
firstLocation = YBound(1,:);
Parameters=EstimatedParams();

simOut = sim('woutModel', 'SrcWorkspace', 'current');

%% LSQnonlin
% We estimate the starting velocity (because we can't measure that)
% and the parameters given by the documents. 
% The accepted inputs are: Parameters, physical data (Y & Input, if the
% second bar is fixed to the first and the firstLocation of the 
func = @(x) LSQnonLinfunc(x,YBound, Input, true, firstLocation); % + LSQnonLinfunc(x,YUnbound, Input, false);

% X = [ g, l1, l2, m1,  m2,  c1, c2, I1, I2,b1, b2, km, Te, initialSpeed]
LB = [9.81,   0.09,0.09,   0.05,0.03,   0.01,0.05,  0.02,2.30e-05,    3, 2.1048e-05,  -60, 0.01, -15.3840];
UB = [9.815,   0.11,0.11,   0.4,0.05,   0.1,0.08,   0.2,2.8472e-05,    10,2.1048e-05,   -40, 0.1, -15.3840];  

%X0 = [9.8125,   0.09,0.1,   0.3,0.0471,  0.0987,0.0737,   0.0786,2.8472e-05,   4.8016,2.1048e-05, ...
%   -59.9994,0.0500, -15.3840];
X0 = [ 9.8150    0.0922    0.1000    0.3797    0.0461    0.0100    0.0643    0.0319, 2.3000e-05 , 5.7811, ... 
    2.1048e-05, -41.1161, 0.0216, -15.3840];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 5);

[x2, resnorm] = lsqnonlin(func,X0,LB,UB, options)
%x = lsqnonlin(func,X0,[9.7, 0.09, 0.09, 0.03, 0.00001, -0.2, 0, 0.05, 0],[9.9,0.15,0.15,0.5, 0.5, 0, 0.1, 0.1], options)
%% Simulating Constant Torque
Parameters = ConvertParams(x2);
initSpeed = x2(14);
simOut = sim('boundedModel', 'SrcWorkspace', 'current');
ydata = simOut.Theta.data;
mse = zeros(2,4);
mse(:,1) = MSEDATA(YBound,ydata);

plotData(ydata, YBound, time);
%% Sinusoidal
Inputzero = Input;
Input = [linspace(0,10,1000); sin(linspace(0,10,1000))]'; 
simOut = sim('boundedModel', 'SrcWorkspace', 'current');
ydata = simOut.Theta.data;
mse(:, 2) = MSEDATA(RealyBoundDataS,ydata);
plotData(ydata, RealyBoundDataS, time);
%% UNBOUND
firstLocation = YUnbound(1,:)
Input = Inputzero;
simOut = sim('woutModel', 'SrcWorkspace', 'current');
ydata = simOut.Theta.data;
mse(:, 3) = MSEDATA(YUnbound,ydata);
plotData(ydata, YUnbound, time);
%% Simulating Sinusoidal Torque
Input = [linspace(0,10,1000); sin(linspace(0,10,1000))]'; 
firstLocation = RealyUnboundS(1,:);
simOut = sim('woutModel', 'SrcWorkspace', 'current');
ydata = simOut.Theta.data;
mse(:, 4) = MSEDATA(RealyUnboundS,ydata)
plotData(ydata, RealyUnboundS, time);
%% 
function YNewData = LoadData2() 
% In this case, only 1 dataset can be used, because the results are wildly
% different each time. In this setup, we let the second bar swing from an
% intial position to estimate g, c2, m2, I2, b2. Because we started
% recording after the bar started swinging to prevent errors in the
% modeling because of external disturbances (our hands) the initial
% position is different for every recording. Because that is a very big
% influence, it is impractical to average over the different measurements. 
Dataset1 = load('measurements/whitebox/bound1_constantTorque_1.mat');
YNewData = unwrap([Dataset1.Theta1.data, Dataset1.Theta2.data]);
end
function mseMean = MSEDATA(RealData, ModelData) 
diff = RealData - ModelData(1:10:end,:);
mseMean = mean(diff .* diff);
end
function [] = plotData(ydata, Realdata, time) 
y1 = timeseries(ydata(1:10:end,1), time);
y2 = timeseries(ydata(1:10:end,2), time);
Ry1 = timeseries(Realdata(:,1), time);
Ry2 = timeseries(Realdata(:,2), time);
figure;
subplot(2,1,1)
plot(y1); hold on;
plot(Ry1);
legend('Model Data','Measured Data');
xlabel('Time [s]');
ylabel('angle [rad]');
subplot(2,1,2)

plot(y2); hold on;
plot(Ry2);
legend('Model Data','Measured Data');
xlabel('Time [s]');
ylabel('angle [rad]');
end