

simOut = sim('closed_observer.slx', 'StopTime', '10');
t = simOut.x.time;

u = simOut.u.signals.values;

f1 = simOut.f1.signals.values;
f2 = simOut.f2.signals.values;
g = simOut.g.signals.values;

x = simOut.x.signals.values;
x_hat = simOut.x_hat.signals.values;
e_x = x - x_hat;

w = simOut.w.signals.values;
w_hat = simOut.w_hat.signals.values;
e_w = w - w_hat;

y = simOut.y.signals.values;
z = simOut.z.signals.values;

