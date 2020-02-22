%% EXPLANATION
fprintf("THIS IS THE CALIBRATION FILE OF THE ROTATIONAL PENDULUM (ROT 2.1)");
fprintf("IT IS MEANT THAT THIS FILE IS RUN ONCE AT THE START OF A LAB-SESSION");
fprintf("TO DETERMINE IF WE CAN DO WITH ONLY 1 OR 3 ROUNDS OF THE CALIBRATION, THIS WILL DO BOTH");

fprintf("IN THIS SETUP WE WILL CONTINOUSLY ASK YOU TO MANUALLY MOVE THE BARS IN THE CORRECT POSITION.");
fprintf("THE SMALL BAR WILL BE HANGING FREE, I.E. POINTING DOWNWARDS DURING THE ENTIRE OPERATION");
fprintf("MAKE SURE IT IS COMPLETELY STILL AND DOES NOT SWING");

%% CHANGE TO REFLECT REALITY

% Choose only 0, 1/2 pi, pi, 1.5 pi
offsetLargeBar = 0; 
offsetsmallBar = pi;
% Choose only 1 or -1
gainLargeBar = 1;
gainSmallBar = 1;
angles = zeros(3, 4, 2);
%% MEASUREMENTS
for i = 1:3
fprintf("\n\n\n PLACE THE LARGE BAR AT THE TOP AND PRESS ENTER TO CONTINUE...");
input('','s');
angles(i,1, :) = measureAngles();

fprintf("\n\n\n PLACE THE LARGE BAR AT THE RIGHT AND PRESS ENTER TO CONTINUE...");
input('','s');
angles(i,2, :) = measureAngles();

fprintf("\n\n\n PLACE THE LARGE BAR AT THE BOTTOM AND PRESS ENTER TO CONTINUE...");
input('','s');
angles(i,3, :) = measureAngles();

fprintf("\n\n\n PLACE THE LARGE BAR AT THE LEFT AND PRESS ENTER TO CONTINUE...");
input('','s');
angles(i,4, :) = measureAngles();
end
%% FIGURE CHECK 
% FF een klein figuurtje zodat we zien dat het klopt waar we mee bezig zijn
figure;
plot(angles(1,:,1), 'o'); hold on;
plot(angles(1,:,2), 'o');
%% SANITIZING
% Het idee van dit stukje code is dat er geen sprongen in de measurements
% zitten omdat de sensor van 2pi naar 0 springt (of van pi naar -pi, etc)
for i = 1:3 
   for j = 2:4 
       while (gainLargeBar*angles(i,j,1) < gainLargeBar*angles(i,j-1,1)) 
           angles(i,j,1) = angles(i,j,1) + gainLargeBar*2*pi;
       end
       while (gainsmallBar*angles(i,j,2) < gainsmallBar*angles(i,j-1,2)) 
           angles(i,j,2) = angles(i,j,2) + gainsmallBar*2*pi;
       end
   end
end
%% CALCULATE OFFSET & GAIN
gain = zeros(3,2);
offset = zeros(3,2);
x = [0, 0.5*pi, pi, 1.5*pi];
xLarge = gainLargeBar*x + offsetLargeBar;
xSmall = gainSmallBar*x + offsetsmallBar;
for i = 1:3 % Als we de code echt netjes maken, voegen we alle i=1:3 samen
    [gain(i,1), offset(i,1)] = polyfit(angles(i,:,1), xLarge);
    [gain(i,2), offset(i,2)] = polyfit(angles(i,:,2), xSmall);
end