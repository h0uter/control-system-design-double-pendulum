function [RealyUnboundData, RealyBoundData, RealyBoundDataS, RealyUnboundS, time] = LoadData() 
% Load the data used in the Parameter Estimation. We use 3 averaged sets of
% to make sure measurement noise (assumed to be white noise) has as little
% influence as possible. Also, the measurements are unwrapped. 
Dataset1 = load('measurements/whitebox/bound_constantTorque_1.mat');
Dataset2 = load('measurements/whitebox/bound_constantTorque_2.mat');
Dataset3 = load('measurements/whitebox/bound_constantTorque_3.mat');
time = Dataset1.Theta1.time;
RealyBoundData = transformdata(Dataset1, Dataset2, Dataset3);
Dataset1S = load('measurements/whitebox/bound_sinTorque_1.mat');
Dataset2S = load('measurements/whitebox/bound_sinTorque_2.mat');
Dataset3S = load('measurements/whitebox/bound_sinTorque_3.mat');

RealyBoundDataS = transformdata(Dataset1S, Dataset2S, Dataset3S);

Dataset1Unbound = load('measurements/whitebox/unbound_constantTorque_1.mat');
Dataset2Unbound = load('measurements/whitebox/unbound_constantTorque_2.mat');
Dataset3Unbound = load('measurements/whitebox/unbound_constantTorque_3.mat'); 
RealyUnboundData = transformdata(Dataset1Unbound, Dataset2Unbound, Dataset3Unbound);

Dataset1UnboundS = load('measurements/whitebox/unbound_sinTorque_1.mat');
Dataset2UnboundS = load('measurements/whitebox/unbound_sinTorque_2.mat');
Dataset3UnboundS = load('measurements/whitebox/unbound_sinTorque_3.mat'); 
RealyUnboundS = transformdata(Dataset1UnboundS, Dataset2UnboundS, Dataset3UnboundS);
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