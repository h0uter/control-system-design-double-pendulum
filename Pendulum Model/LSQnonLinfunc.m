function err = LSQnonLinfunc(x, Realydata) 
Parameters.km = x;
simOut = sim('Level2Model', 'SrcWorkspace', 'current');
ydata = simOut.Output2.data;
ydata(5);
err = ydata - Realydata;