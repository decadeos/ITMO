W1 = tf([-10 -2 142 218 372], den);
W3 = tf([16 154 428 374 372], den);

figure
bode(W1, W3)
grid on
legend('Object 1','Object 3')
