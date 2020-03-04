load('measurements/blackbox/testlong.mat')
input = inputsignal.data;
theta1 = unwrap(Theta1.data);
theta2 = unwrap(Theta2.data);
theta1 = detrend(theta1);
theta2 = detrend(theta2);
output = [theta1, theta2];
Ts = 0.01;

datapart = iddata(output(1000:2000,:),input(1000:2000),Ts);
data = iddata(output,input,Ts);

%Ny = number of outputs, Nu is number of inputs

na=[3,3;10,10];       %order of polynomial A, Ny by Ny
nb=[3,10]';          %order of polynomial B, Ny by Nu
nc=[3,10]';          %order of polynomial C, vector of Ny length
nk =[1,1]';         %input-output delay, Ny by Nu
syspart = armax(datapart,[na nb nc nk]); %can add nk? has to do with delay of input output
sys = armax(data,[na nb nc nk]);
%[A,B,C,D,F,dA,dB,dC,dD,dF] = polydata(sys); 
%%
compare(datapart,sys)
figure
compare(data,sys)
