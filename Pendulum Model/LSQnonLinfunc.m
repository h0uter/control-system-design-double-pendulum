function err = LSQnonLinfunc(x, Realydata) 
Parameters = [x, x; x,x];
simOut = sim('Level2Model');
ydata = simOut.Output2.data;
ydata(5);
err = ydata - Realydata;