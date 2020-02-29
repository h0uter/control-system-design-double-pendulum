function err = LSQnonLinfunc(X, Realydata, Input) 
% X = [ g, l1, l2, m1, m2, c1, c2, I1, I2,b1, b2, km, Te]
Parameters = CoenParams(X);
simOut = sim('woutModel', 'SrcWorkspace', 'current');
ydata = simOut.Theta.data;
err = (ydata - Realydata)/100; %% TODO: MAKE 100 the duration of the simulation