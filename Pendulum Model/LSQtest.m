
%% Load Data BOUND
[YUnbound, YBound] = LoadData();

%% LSQnonlin
func = @(x) LSQnonLinfunc(x,YBound, Input, true) + LSQnonLinfunc(x,YUnbound, Input, false);

% X = [ g, l1, l2, m1,  m2,  c1, c2, I1, I2,b1, b2, km, Te]
LB = [9.8, 0.05, 0.03, 0.05, 0.002,   0,  0,  0.02,  0,  0, 0,  -Inf, 0.01];
UB = [9.82, 0.2,0.2,0.4,0.2,0.2, 0.4,3, 3, 20, 1, 100, 1];  
X0 = [9.8101,    0.0500,    0.1000 ,   0.2481,    0.1131,   0.1013,    0.0621,0.8466,  0.4938   , 5.6359, ...
    0.0002,   -40.0385 ,    0.1474];
options = optimoptions('lsqnonlin', 'Display', 'iter', 'MaxIter', 30);

[x, resnorm] = lsqnonlin(func,X0,LB,UB, options)
%x = lsqnonlin(func,X0,[9.7, 0.09, 0.09, 0.03, 0.00001, -0.2, 0, 0.05, 0],[9.9,0.15,0.15,0.5, 0.5, 0, 0.1, 0.1], options)
