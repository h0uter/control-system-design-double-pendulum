function err = LSQnonLinfunc(X, Realydata, Input, bounded) 
% X = [ g, l1, l2, m1, m2, c1, c2, I1, I2,b1, b2, km, Te]
Parameters = CoenParams(X);
initSpeed = X(14);
if (bounded)
simOut = sim('boundedModel', 'SrcWorkspace', 'current');
else 
    simOut = sim('woutModel', 'SrcWorkspace', 'current');
end
ydata = simOut.Theta.data;
ydata = ydata(10:10:length(ydata), :);
err = ydata - Realydata(1:end-1, :);