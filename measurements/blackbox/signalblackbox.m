time=100;
signal.time = linspace(0,100,10000);
signal.values = 0.1*ones(1,time/h);
lengthinput = 10;
ampl=1;
signal2 = [linspace(0,100,10000/lengthinput)',  -0.5+ampl*round(rand(1,time/(h*lengthinput)))'];