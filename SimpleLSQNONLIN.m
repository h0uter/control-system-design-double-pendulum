sim('SimpelModel');

fun = @(x) lsim(tf(1,[x(2) x(3)]), Input,tout)-Simple;
x0 = [1, 1,5];
x = lsqnonlin(fun,x0, [],[])