function drawpend(y)

% y = [phi1 phi2]

% th = y(3);
phi1 = y(1);
phi2 = y(2);

% kinematics
% x = 3;        % cart position
% th = 3*pi/2;   % pendulum angle

% dimensions
L1 = 1; % pendulum length
L2 = 1;
m = 0.5;
% W = 1*sqrt(M/5);  % cart width
% H = .5*sqrt(M/5); % cart height
% wr = .2; % wheel radius
mr = .3*sqrt(m); % mass radius

% positions
% y = wr/2; % cart vertical position
% y = wr/2+H/2; % cart vertical position
% w1x = x-.9*W/2;
% w1y = 0;
% w2x = x+.9*W/2-wr;
% w2y = 0;

% px = x + L*sin(th);
% py = y - L*cos(th);

x1 = L1*sin(phi1);
y1 = L2*cos(phi1);
x2 = x1 + L2*sin(phi2);
y2 = y1 + L2*cos(phi2);

plot([-10 10],[0 0],'k','LineWidth',2)
hold on
% rectangle('Position',[x-W/2,y-H/2,W,H],'Curvature',.1,'FaceColor',[1 0.1 0.1])
% rectangle('Position',[w1x,w1y,wr,wr],'Curvature',1,'FaceColor',[0 0 0])
% rectangle('Position',[w2x,w2y,wr,wr],'Curvature',1,'FaceColor',[0 0 0])

% beam 1
plot([0 x1],[0 y1],'k','LineWidth',2)
% beam 2
plot([x1 x2],[y1 y2],'k','LineWidth',2)

% rectangle('Position',[x-mr/2,py-mr/2,mr,mr],'Curvature',1,'FaceColor',[.1 0.1 1])

% set(gca,'YTick',[])
% set(gca,'XTick',[])
xlim([-5 5]);
ylim([-2 2.5]);
set(gcf,'Position',[100 550 1000 400])
% box off
drawnow
hold off