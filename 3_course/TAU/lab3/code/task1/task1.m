% clc;

A2 = [2 2; -2 2];
B2 = [1.5; -3.5];
a = 3;

cvx_begin sdp
  variable P(2,2) symmetric
  variable Y(1,2)
    
  minimize(norm(Y))

  P >= 0.0001*eye(2);
  P*A2' + A2*P + 2*a*P + Y'*B2' + B2*Y <= 0;
cvx_end

K = Y * inv(P)

Acl = A2 + B2*K;
eig(Acl)

% cd ~/cvx
% cvx_setup