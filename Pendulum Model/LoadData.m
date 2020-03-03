function [RealyUnboundData, RealyBoundData] = LoadData() 
Dataset1 = load('../measurements/bound_constantTorque_1.mat');
Dataset2 = load('../measurements/bound_constantTorque_2.mat');
Dataset3 = load('../measurements/bound_constantTorque_3.mat');
RealyBoundData = transformdata(Dataset1, Dataset2, Dataset3);
Dataset1Unbound = load('../measurements/unbound_constantTorque_1.mat');
Dataset2Unbound = load('../measurements/unbound_constantTorque_2.mat');
Dataset3Unbound = load('../measurements/unbound_constantTorque_3.mat'); 
RealyUnboundData = transformdata(Dataset1Unbound, Dataset2Unbound, Dataset3Unbound);
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