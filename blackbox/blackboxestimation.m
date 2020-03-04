load('measurements/blackbox/test2.mat')
input = inputsignal.data;
% theta1 = Theta1.data;
% theta2 = Theta2.data;
theta1 = unwrap(Theta1.data);
theta2 = unwrap(Theta2.data);
%  theta1 = detrend(theta1);
%  theta2 = detrend(theta2);
output = [theta1, theta2];
Ts = 0.01;

datapart = iddata(output(1:1000,:),input(1:1000),Ts);
data = iddata(output,input,Ts);

%Ny = number of outputs, Nu is number of inputs
na=[1,1;4,4];       %order of polynomial A, Ny by Ny
nb=[2,3]';          %order of polynomial B, Ny by Nu
nc=[1,3]';          %order of polynomial C, vector of Ny length
nk =[1,3]';         %input-output delay, Ny by Nu
syspart = armax(datapart,[na nb nc nk]);
sys = armax(data,[na nb nc nk]);
%[A,B,C,D,F,dA,dB,dC,dD,dF] = polydata(sys); 
%%
%compare(datapart,sys)
figure(1)
compare(data,sys)
figure(2)
compare(datapart,syspart)
figure(3)
compare(data,syspart)
figure(4)
compare(datapart,sys)