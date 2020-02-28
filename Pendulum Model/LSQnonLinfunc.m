function err = LSQnonLinfunc(X, Realydata) 
% X = [ g, l1, l2, m1, m2, c1, c2, I1, I2,b1, b2, km, Te]
Parameters.g = X(1);
Parameters.l1 = X(2);
Parameters.l2 = X(3);
Parameters.m1 = X(4);
Parameters.m2 = X(5);
Parameters.c1 = X(6); 
Parameters.c2 = X(7);
Parameters.I1 = X(8);
Parameters.I2 = X(9);
Parameters.b1 = X(10);
Parameters.b2 = X(11);
Parameters.km = X(12);
Parameters.Te = X(13);
[Parameters.P1,Parameters.P2,Parameters.P3,Parameters.g1,Parameters.g2] = ...
CoenParams(X);
simOut = sim('Level2Model', 'SrcWorkspace', 'current');
ydata = simOut.Output2.data;
ydata(5);
err = ydata - Realydata;