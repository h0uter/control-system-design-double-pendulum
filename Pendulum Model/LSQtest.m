
%% Load Data BOUND
[YUnbound, YBound] = LoadData();

%% LSQnonlin
func = @(x) LSQnonLinfunc(x,YBound, Input, true); % + LSQnonLinfunc(x,YUnBound, Input, true);

X0 = [9.8100,    0.0991,    0.1000 ,   0.1251,    0.050,   -0.040,    0.0600,    0.0744,   0.00012    ,4.8, ...
    0.0002,   -50,    0.0307];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 50);
x = lsqnonlin(func,X0,[9, 0,0, 0, 0, -0.5, -0.5, 0,0],[10, 0.15, 0.15, 0.2, 0.1, 0.1, 0.1, 0.1, 0.00013,5, 0.0002, -40, 0.04], options);
%x = lsqnonlin(func,X0,[9.7, 0.09, 0.09, 0.03, 0.00001, -0.2, 0, 0.05, 0],[9.9,0.15,0.15,0.5, 0.5, 0, 0.1, 0.1], options)
