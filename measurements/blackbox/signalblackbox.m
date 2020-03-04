time=20;
lengthinput = 8;
ampl=0.3;
signal2 = [linspace(0,time,time*100/lengthinput)',  -0.15+ampl*round(rand(1,time/(h*lengthinput)))'];
sim('ParamEstimate');