h=0.01;
time=10;
lengthinput = 8;
ampl=0.4;
signal2 = [linspace(0,time,time*100/lengthinput)',  -1/2*ampl+ampl*round(rand(1,time/(h*lengthinput)))'];
mean(signal2(:,2))
signal2=signal2 - mean(signal2(:,2));
%%
sim('ParamEstimatebb');
save('C:\Users\rrooijmans\Github\CSL-ROT2.1-CoenRobWout\measurements\blackbox\test.mat')