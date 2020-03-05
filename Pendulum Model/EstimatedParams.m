% X = [ g, l1, l2, m1, m2, c1, c2, I1, I2,b1, b2, km, Te]
function Parameters = EstimatedParams() 
X = [ 9.815, 0.0906, 0.1, 0.3758, 0.0459, 0,0126, 0.0660, 0.02, 2.8472e-05 , 8.4405, ... 
    2.1048e-05, -59.9794, 0.02];
Parameters = ConvertParams(X);
end