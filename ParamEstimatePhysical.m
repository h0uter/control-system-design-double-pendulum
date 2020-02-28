%% find double derivative of theta
theta1 = Theta1.data;
theta2 = Theta2.data;
dtheta2 = dTheta2.data;
ddtheta2 = ddTheta2.data;
dtheta1 = dTheta1.data;
avgdtheta1 = mean(dtheta1(35:end));
ddtheta1 = ddTheta1.data;
theta1fix = unwrap(theta1);
minmaxdtheta2 = max(-100,min(100,dtheta2));
rmd2 = hampel(dtheta2,9,1);
dtheta2 = rmd2;
ddtheta2 = hampel(gradient(rmd2)/h, 9,1);
%%
%variables=[b1, km, g, c1, m1, l1, m2, c2];
u =0.3; 
% fun2 = @(x) b1*avgdtheta1 -   km  *u - g   *sin(theta1)*(c1 *m1  +   l1 *m2) -    c2  *g  *m2  *sin(theta1);
  fun2 = @(x) x(1)*avgdtheta1 - x(2)*u - x(3)*sin(theta1)*(x(4)*x(5) + x(6)*x(7)) - x(8)*x(3)*x(7)*sin(theta1);
  fun3 = @(x) x(1)*dtheta2 + ddtheta2*(x(2)*x(3)^2 + x(4)) - x(3)*x(5)*x(2)*sin(theta2);
fun = @(x)ddtheta1*(x(1)*x(2)^2 + x(3)*x(1)*x(2) + x(4)) - x(2)*x(5)*x(1)*sin(theta1);
x0 = [0.0002, 0.05, 0.06, 0.00012, 9.81];
options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
x = lsqnonlin(fun3,x0,[0.0001, 0.03, 0.03, 0.00005, 9.7],[0.002, 0.07,0.1, 0.0005, 10], options)
