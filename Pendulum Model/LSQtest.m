%% Simulate Data;
Parameters.km = 2;
out = sim('Level2Model');
Realydata = out.Output2.data;
Parameters.km = 0;
%% LSQnonlin
func = @(x) LSQnonLinfunc(x,Realydata);
x0 = 1;
options = optimoptions('lsqnonlin', 'Display', 'iter');
x = lsqnonlin(func,x0,[],[], options)
