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
M_inv_T = Parameters.LinTopM * [1; 0];
Parameters.LinTopA = [-1/Parameters.Te,0,0,0,0,; 
    zeros(2,3), eye(2); 
     M_inv_T, Parameters.LinTopM \ -Parameters.LinTopG, Parameters.LinTopM \ -Parameters.LinTopC];

Parameters.LinTopB = [ Parameters.km /Parameters.Te; zeros(4,1)];
Parameters.LinTopXY  = [zeros(2,1), eye(2), zeros(2)];
Parameters.K = 1.0e+08 *[ 1.1105    0.0000   -0.0000    0.0118   -0.0212;
   -0.7320   -0.0000    0.0000   -0.0125    0.0243];
Parameters.PoleGain = [ -0.0141    0.7074    2.6846    0.1318    0.0168;
         0         0         0         0         0];
end