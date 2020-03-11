load('measurements/blackbox/ampl04_time10_avg8_copy.mat')
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
nk =[1,1]';         %input-output delay, Ny by Nu

sys1 = armax(data1,[na nb nc nk]);

figure(1)
compare(data1,sys1)

%%
 load('measurements/blackbox/ampl04_time10_avg8_2copy.mat')
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
G1 =  idss(sys1);
Co1 = ctrb(G1)
unco1 = length(G1.A) - rank(Co1)
save('DT_SS_model_G1','G1')

%% check controlability
G2 = idss(sys2);
Co2 = ctrb(G2)
unco2 = length(G2.A) - rank(Co2)
% bad shit cause the black box models are not controllable
