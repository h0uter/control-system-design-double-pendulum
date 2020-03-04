function err = LSQnonLinfunc(X, Realydata, Input, bounded) 
% X = [ g, l1, l2, m1, m2, c1, c2, I1, I2,b1, b2, km, Te]
Parameters = CoenParams(X);
if (bounded)
simOut = sim('boundedModel', 'SrcWorkspace', 'current');
else 
    simOut = sim('woutModel', 'SrcWorkspace', 'current');
end
ydata = simOut.Theta.data;
sumError = sum(ydata-Realydata);
err = ydata - Realydata;
