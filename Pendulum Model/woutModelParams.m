
syms l1 l2 c1 c2 I1 I2 b1 b2 km Te dTe theta1 theta2 dtheta1 dtheta2 ddtheta1 ddtheta2 u


m1 = 1; m2 =1;
L = 0.6;
g = 9.81;
km =1;

P1 = m1*c1^2 + m2*l1^2 + I1;
P2 = m2*c2^2 + I2;
P3 = m2*l1*c2;
g1 = (m1*c1 + m2*l1)*g;
g2 = m2*c2*g;
theta=[theta1; theta2];
dtheta=[dtheta1; dtheta2];
ddtheta=[ddtheta1; ddtheta2];

