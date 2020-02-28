function [P1, P2, P3, g1, g2] = CoenParams(X) 
% X = [g, l1, l2, m1, m2, c1, c2, I1, I2, b1, b2, km, Te];
P1 = X(4)*X(6)^2 + X(5)*X(2)^2 + X(8);
P2 = X(5)*X(7)^2 + X(9);
P3 = X(5)*X(2)*X(7);
g1 = X(1)*(X(4)*X(6)+X(5)*X(2));
g2 = X(5)*X(7)*X(1);
end