function measureAngles = measureAngles() 
block1 = 'rotCalibration/Theta1';
rto = get_param(block1, 'RuntimeObject');
Theta1 = rto.InputPort(1).Data;
block2 = 'rotCalibration/Theta2';
rto = get_param(block2, 'RuntimeObject');
Theta2 = rto.InputPort(1).Data;
measureAngles = [Theta1,Theta2];
end