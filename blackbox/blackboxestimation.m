load('measurements/blackbox/ampl04_time10_avg8.mat')
input = inputsignal.data;
theta1 = unwrap(Theta1.data);
theta2 = unwrap(Theta2.data);
output = [theta1, theta2];
Ts = 0.01;
data1 = iddata(output,input,Ts);

%Ny = number of outputs, Nu is number of inputs
na=[1,1;4,4];       %order of polynomial A, Ny by Ny
nb=[2,3]';          %order of polynomial B, Ny by Nu
nc=[1,3]';          %order of polynomial C, vector of Ny length
nk =[1,3]';         %input-output delay, Ny by Nu

sys1 = armax(data1,[na nb nc nk]);
 
figure(1)
compare(data1,sys1)

%%
 load('measurements/blackbox/ampl04_time10_avg8_2.mat')
 input = inputsignal.data;
 theta1 = unwrap(Theta1.data);
 theta2 = unwrap(Theta2.data);
 output = [theta1, theta2];
 data2 = iddata(output,input,Ts);
 sys2 = armax(data2,[na nb nc nk]);
% %[A,B,C,D,F,dA,dB,dC,dD,dF] = polydata(sys);
figure(2)
compare(data2,sys2)
figure(3)
compare(data1,sys2)
figure(4)
compare(data2,sys1)
%%
G =  idss(sys1);

