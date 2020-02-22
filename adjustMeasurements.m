function theta = adjustMeasurements(oldTheta) 
%% TODO: FILL IN
offset1 = 0;
offset2 = 0;
gain1 = 1;
gain2 = 1;
%% UPDATE THETA
theta(1) = (oldTheta(1) + offset1)/gain1;
theta(2) = (oldTheta(2) + offset2)/gain2;
end