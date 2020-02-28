function err = LSQnonLinfunc(x, Realydata) 
time = 1:10;
Parameters = [x, x; x,x];
simOut = sim('Level2Model', 'SrcWorkSpace', 'current');
ydata = simOut.Output2.data;
ydata(5);
err = ydata - Realydata;