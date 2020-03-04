function err = LSQnonLinfunc(X, Realydata, Input, bounded, firstLocation) 
% X = [ g, l1, l2, m1, m2, c1, c2, I1, I2,b1, b2, km, Te]
Parameters = CoenParams(X);
initSpeed = X(14);
if (bounded)
simOut = sim('boundedModel', 'SrcWorkspace', 'current');
else 
    simOut = sim('woutModel', 'SrcWorkspace', 'current');
end
ydata = simOut.Theta.data;
ydata2 = ydata(9:10:end-1, :);
sumError = sum(ydata2-Realydata(2:end, :));
err = ydata2-Realydata(2:end, :);
