function Parameters = ConvertParams(X) 
Parameters.g = X(1);
Parameters.l1 = X(2);
Parameters.l2 = X(3);
Parameters.m1 = X(4);
Parameters.m2 = X(5);
Parameters.c1 = X(6); 
Parameters.c2 = X(7);
Parameters.I1 = X(8);
Parameters.I2 = X(9);
Parameters.b1 = X(10);
Parameters.b2 = X(11);
Parameters.km = X(12);
Parameters.Te = X(13);
% X = [g, l1, l2, m1, m2, c1, c2, I1, I2, b1, b2, km, Te];
Parameters.P1 = X(4)*X(6)^2 + X(5)*X(2)^2 + X(8);
Parameters.P2 = X(5)*X(7)^2 + X(9);
Parameters.P3 = X(5)*X(2)*X(7);
Parameters.g1 = X(1)*(X(4)*X(6) + X(5)*X(2));
Parameters.g2 = X(5)*X(7)*X(1);
Parameters.LinTopM = [Parameters.P1 + Parameters.P2 + 2*Parameters.P3, Parameters.P2 + Parameters.P3;
                      Parameters.P2 + Parameters.P3, Parameters.P2];
 
 Parameters.LinTopC =  [Parameters.b1 , 0;
                        0, Parameters.b2];

g1 = Parameters.g1;
g2 = Parameters.g2;
Parameters.LinTopG = [ -g1-g2, -g2; -g2, -g2;];
Parameters.LinTopGConstant = [ -pi*g2; -pi*g2];
M_inv_T = Parameters.LinTopM \ [1; 0];
Parameters.LinTopA = [-1/Parameters.Te,0,0,0,0,; 
    zeros(2,3), eye(2); 
     M_inv_T, Parameters.LinTopM \ -Parameters.LinTopG, Parameters.LinTopM \ -Parameters.LinTopC];

Parameters.LinTopB = [ Parameters.km /Parameters.Te; zeros(4,1)];
Parameters.LinTopXY  = [zeros(2,1), eye(2), zeros(2)];
Parameters.K =  1.0e+04 * [
   2.0116    0.0688   -0.0193    1.0469   -2.6729;
   -4.1368   -0.0185    0.1018   -2.1912    6.1719 ]; % K3 in the observerdesign
%Parameters.PoleGain = 1.0e+02  *[
%    -0.000067591280490  -0.969428411401532  -1.022005191642317  -0.193438191643539  -0.089193487968499];
sys = ss(Parameters.LinTopA, Parameters.LinTopB, Parameters.LinTopXY, 0);
Parameters.h = 0.0001;
sysd = c2d(sys, Parameters.h);
Parameters.Ad = sysd.A;
Parameters.Bd = sysd.B;
Parameters.Cd = sysd.C;
Parameters.PoleGainLQR = [ -0.2058   90.6459   80.9736   14.0066    7.0228];
Parameters.PoleGainPolePlace = [ 0.0810    4.9899    4.0572    0.1231    0.3565];
switch 'FixedParam'
    case 'Setup'
    Parameters.ErrorGains = 0.95 +  0.1*rand(1,5);
    case 'FixedParam'
        % This way, you can find exactly the same results as we have in our
        % report. You can choose if you prefer to use random gains or use
        % the same ones. 
    Parameters.ErrorGains = [0.9852  1.0331  1.0085  1.0050  1.0417];
end


% To make exactly the same graphs as we did. 
Parameters.disturbance = 0;
end