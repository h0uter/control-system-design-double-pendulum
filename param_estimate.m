%%
% clc; clear all;
syms l1 l2 m1 m2 c1 c2 I1 I2 b1 b2 km Te dTe theta1 theta2 dtheta1 dtheta2 ddtheta1 ddtheta2 u g
%%
P1 = m1*c1^2 + m2*l1^2 + I1;
P2 = m2*c2^2 + I2;
P3 = m2*l1*c2;
g1 = (m1*c1 + m2*l1)*g;
g2 = m2*c2*g;
theta=[theta1; theta2];
dtheta=[dtheta1; dtheta2];
ddtheta=[ddtheta1; ddtheta2];

M = [P1 + P2 + 2*P3*cos(theta2), P2 + P3 * cos(theta2);
     P2 + P3*cos(theta2), P2];
C = [b1 - P3*dtheta2*sin(theta2), -P3*(dtheta1+dtheta2)*sin(theta2);
     P3*dtheta1*sin(theta2), b2];
G = [-g1*sin(theta1) - g2*sin(theta1+theta2);
     -g2*sin(theta1+theta2)];
T = km*u - Te*dTe;
Tvec = [T; 0];

%%
func = M*ddtheta + C*dtheta + G - Tvec; %func = 0 according to dynamics

%% theta 2 = pi, dtheta2 = 0; ddtheta2 = 0;
theta2 = 0;
dtheta2 = 0;
ddtheta2 = 0;
func_if_theta2_zero = simplify(eval(func));

%% find double derivative of theta
h = 0.01; %timestep!
%theta = linspace(0.01,1); % is actually data
dtheta1 = round(gradient(theta1/h),4);
ddtheta1 = gradient(dtheta1/h);

%%
%variables=[m2, c2, l1, I2, g];
fun = @(x)double(ddtheta1*(x(1)*x(2)^2 + x(3)*x(1)*x(2) + x(4)) - x(2)*x(5)*x(1)*sin(theta1));
x0 = [0.05, 0.06, 0.1, 0.00012, 9.81];
options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
x = lsqnonlin(fun,x0,[],[],options); 



