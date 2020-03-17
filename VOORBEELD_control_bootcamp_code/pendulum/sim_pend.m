% clear all, close all, clc

% m = 1;
% M = 5;
% L = 2;
% g = -10;
% d = 1;

% tspan = 0:.1:10;
% y0 = [0; 0; pi; .5];
% [t,y] = ode45(@(t,y)cartpend(y,m,M,L,g,d,0),tspan,y0);

t = Test2.Theta_Model.Time;
y = Test2.Theta_Model.Data(:, 2:3);

for k=1:length(t)
    if mod(k, 25) == 0
        drawpend(y(k,:));
    end
end

% function dy = pendcart(y,m,M,L,g,d,u)