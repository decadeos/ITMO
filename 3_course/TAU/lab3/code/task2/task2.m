clc;

Aj3 = [4 0 0; 0 8 0; 0 0 20];
Cj3 = [0 8 0; 4 0 12];
aL1 = 10;

cvx_begin sdp
    variable Q(3,3) symmetric
    variable Y(3,2)
    
    Q >= 1e-4*eye(3);
    Aj3*Q + Q*Aj3' + 2*aL1*Q + Y*Cj3 + Cj3'*Y' <= 0;
cvx_end

Lj = inv(Q) * Y

