function err = LSQnonLinfunc(X, Realydata) 
% X = [ g, l1, l2, m1, m2, c1, c2, I1, I2,b1, b2, km, Te]
Parameters = CoenParams(X);
simOut = sim('Level2Model', 'SrcWorkspace', 'current');
ydata = simOut.Output2.data;
ydata(5);
err = ydata - Realydata;