%% Simulate Data;
X = [9.81, 0.1, 0.1, 0.125, 0.05, -0.04, 0.06, 0.074, 0.00012, 4.8, 0.0002, 50, 0.03];
Parameters = CoenParams(X);
out = sim('woutModel');
Realydata = out.Theta.data;
Parameters.km = 0;
%% LSQnonlin
func = @(x) LSQnonLinfunc(selectParam(x),Realydata);

X0 = [0.12, 0.04, 4.7, 0.0001];
options = optimoptions('lsqnonlin', 'Display', 'iter');
x = lsqnonlin(func,X0,[],[], options)
