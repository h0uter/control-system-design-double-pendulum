%% find double derivative of theta
theta1 = Theta1.data;
theta2 = Theta2.data;
dtheta1 = round(gradient(theta1/h),4);
ddtheta1 = gradient(dtheta1/h);

rightIndices = find(abs(dtheta1) < 15);
theta1 = theta1(rightIndices);
dtheta1 = dtheta1(rightIndices);
ddtheta1 = ddtheta1(rightIndices);
%%
%variables=[m2, c2, l1, I2, g];
m2 = 0.05; c2 = 0.06; g = 9.81;
fun = @(x)ddtheta1*(x(1)*x(2)^2 + x(3)*x(1)*x(2) + x(4)) - x(2)*x(5)*x(1)*sin(theta1);
fun2 = @(x) x(2)*x(5)*x(1)*sin(theta1)/(x(1)*x(2)^2+x(3)*x(1)*x(2)+x(4))-ddtheta1;
x0 = [0.05, 0.06, 0.1, 0.00012, 9.81];
options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
x = lsqnonlin(fun2,x0,[0.02, 0.02, 0.09, 0.00008, 9.8],[2,2,0.12,0.002,9.85]); 
%%
fun3 = @(theta1) x0(2)*x0(5)*x0(1)*sin(theta1)/(x0(1)*x0(2)^2+x0(3)*x0(1)*x0(2)+x0(4))
ddtheta1fake = fun3(theta1);
fun4 =  @(x) x(2)*x(5)*x(1)*sin(theta1)/(x(1)*x(2)^2+x(3)*x(1)*x(2)+x(4))-ddtheta1fake;
x = lsqnonlin(fun4,x0,[],[]); 