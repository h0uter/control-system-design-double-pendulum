%% Simulate Data;
Parameters = [2,2; 2,2];
out = sim('Level2Model');
Realydata = out.Output2.data;
Parameters = [0,0;0,0];
Realydata(5)
%% LSQnonlin
func = @(x) LSQnonLinfunc(x,Realydata);
x0 = 1;
options = optimoptions('lsqnonlin', 'Display', 'iter');
x = lsqnonlin(func,x0,[],[], options)
