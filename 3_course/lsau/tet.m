A = [5 -2 8;
      4 -3 4;
     -4 0 -7];
B = [-1; -3; 3];
C = [0 3 5;
    0 14 9];

U = [C*B, C*A*B, C*A^2*B];
r = rank(U);

D = [1; 0];
Uy_ext = [D, C*B, C*A*B, C*A^2*B];
rank(Uy_ext)  