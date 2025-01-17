%% EXPLANATION
fprintf('THIS IS THE CALIBRATION FILE OF THE ROTATIONAL PENDULUM (ROT 2.1)\n');
fprintf('IT IS MEANT THAT THIS FILE IS RUN ONCE AT THE START OF A LAB-SESSION\n');
fprintf('TO DETERMINE IF WE CAN DO WITH ONLY 1 OR 3 ROUNDS OF THE CALIBRATION, THIS WILL DO BOTH\n');

fprintf('IN THIS SETUP WE WILL CONTINOUSLY ASK YOU TO MANUALLY MOVE THE BARS IN THE CORRECT POSITION.\n');
fprintf('THE SMALL BAR WILL BE HANGING FREE, I.E. POINTING DOWNWARDS DURING THE ENTIRE OPERATION\n');
fprintf('MAKE SURE IT IS COMPLETELY STILL AND DOES NOT SWING\n');
%% Startup

%% CHANGE TO REFLECT REALITY

% Choose only 0, 1/2 pi, pi, 1.5 pi. it should be 0 and pi, if the docs are
% correct. 
offsetLargeBar = 0; 

offsetsmallBar = pi;
% Choose only 1 or -1. According to the docs, gainLarge should be 1 and
% gainSmall should be -1.
gainLargeBar = 1;

gainSmallBar = -1;
angles = zeros(1, 4, 2);
% variable = get_param('rotpentemplate','theta1')
rounds = 3;
gain = zeros(rounds,2);
offset = zeros(rounds,2);
x = [0, 0.5*pi, pi, 1.5*pi];
xLarge = gainLargeBar*x + offsetLargeBar;
xSmall = gainSmallBar*x + offsetsmallBar;

%% MEASUREMENTS
for i = 1:rounds
    
    fprintf('\n\n\n PLACE THE LARGE BAR AT THE TOP AND PRESS ENTER TO CONTINUE...');
    input('','s');
    angles(i,1, :) = measureAngles();

    fprintf('\n\n\n PLACE THE LARGE BAR AT THE RIGHT AND PRESS ENTER TO CONTINUE...');
    input('','s');
    angles(i,2, :) = measureAngles();

    fprintf('\n\n\n PLACE THE LARGE BAR AT THE BOTTOM AND PRESS ENTER TO CONTINUE...');
    input('','s');

    angles(i,3, :) = measureAngles();

    fprintf('\n\n\n PLACE THE LARGE BAR AT THE LEFT AND PRESS ENTER TO CONTINUE...');
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
for i = 1:rounds
   for j = 2:4 
       while (gainLargeBar*angles(i,j,1) < gainLargeBar*angles(i,j-1,1)) 
           angles(i,j,1) = angles(i,j,1) + gainLargeBar*2*pi;
       end
       while (gainSmallBar*angles(i,j,2) < gainSmallBar*angles(i,j-1,2)) 
           angles(i,j,2) = angles(i,j,2) + gainSmallBar*2*pi;
       end
   end
%% CALCULATE OFFSET & GAIN

 % Als we de code echt netjes maken, voegen we alle i=1:3 samen
    p1 = polyfit(angles(i,:,1), xLarge,1);
    gain(i,1) = p1(1);
    offset(i,1) = p1(2);
    p2 = polyfit(angles(i,:,2), xSmall,1);
    gain(i,2) = p2(1);
    offset(i,2) = p2(2);
%% Normalize offset to something between -pi and pi

   while(offset(i,1) > pi)
      offset(i,1) = offset(i,1) - 2*pi; 
   end
   while(offset(i,1) < -pi)
       offset(i,1) = offset(i,1) + 2*pi;
   end
   
end
%%
gainmid = mean(gain) %% EXPLICITELY WITHOUT ;
offsetmean = mean(offset)%% EXPLICITELY WITHOUT ;