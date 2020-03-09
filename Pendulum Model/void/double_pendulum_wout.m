syms theta_1(t) theta_2(t) L_1 L_2 m_1 m_2 g

% Define the displacements of the double pendulum in Cartesian coordinates.
x_1 = L_1*sin(theta_1);
y_1 = -L_1*cos(theta_1);
x_2 = x_1 + L_2*sin(theta_2);
y_2 = y_1 - L_2*cos(theta_2);

% Find the velocities by differentiating the displacements with respect to time using the diff function.
vx_1 = diff(x_1)
vy_1 = diff(y_1);
vx_2 = diff(x_2);
vy_2 = diff(y_2);

% Find the accelerations by differentiating the velocities with respect to time.
ax_1 = diff(vx_1);
ay_1 = diff(vy_1);
ax_2 = diff(vx_2);
ay_2 = diff(vy_2);

% tension in rods
syms T_1 T_2

% eqs of motion
eqx_1 = m_1*ax_1(t) == -T_1*sin(theta_1(t)) + T_2*sin(theta_2(t))
eqy_1 = m_1*ay_1(t) == T_1*cos(theta_1(t)) - T_2*cos(theta_2(t)) - m_1*g
eqx_2 = m_2*ax_2(t) == -T_2*sin(theta_2(t))
eqy_2 = m_2*ay_2(t) == T_2*cos(theta_2(t)) - m_2*g

% reduce eqs
Tension = solve([eqx_1 eqy_1],[T_1 T_2])
eqRed_1 = subs(eqx_2,[T_1 T_2],[Tension.T_1 Tension.T_2]);
eqRed_2 = subs(eqy_2,[T_1 T_2],[Tension.T_1 Tension.T_2]);

%% Solve
L_1 = 1;
L_2 = 1.5;
m_1 = 2;
m_2 = 1;
g = 9.8;
eqn_1 = subs(eqRed_1);
eqn_2 = subs(eqRed_2);

[V,S] = odeToVectorField(eqn_1,eqn_2);

% convert to matlab function
M = matlabFunction(V,'vars',{'t','Y'});

% initial conditions
initCond = [pi/4 0 pi/6 0];
sols = ode45(M,[0 10],initCond);

% Animate
x_1 = @(t) L_1*sin(deval(sols,t,3));
y_1 = @(t) -L_1*cos(deval(sols,t,3));
x_2 = @(t) L_1*sin(deval(sols,t,3))+L_2*sin(deval(sols,t,1));
y_2 = @(t) -L_1*cos(deval(sols,t,3))-L_2*cos(deval(sols,t,1));

fanimator(@(t) plot(x_1(t),y_1(t),'ro','MarkerSize',m_1*10,'MarkerFaceColor','r'));
axis equal;

hold on;
fanimator(@(t) plot([0 x_1(t)],[0 y_1(t)],'r-'));
fanimator(@(t) plot(x_2(t),y_2(t),'go','MarkerSize',m_2*10,'MarkerFaceColor','g'));
fanimator(@(t) plot([x_1(t) x_2(t)],[y_1(t) y_2(t)],'g-'));

fanimator(@(t) text(-0.3,0.3,"Timer: "+num2str(t,2)));
hold off;