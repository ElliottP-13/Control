clear all;
close all;
%% Problem 1
G = zpk([-3], [0,-2,-5],50)
K = 1;
sys = K*G;

figure
bode(sys); margin(sys)
[Gm, Pm, Wcg, Wcp] = margin(sys);

% Design C
a = 1/3
T = 1/(Wcp * sqrt(a))
phi_max = rad2deg(asin((1-a)/(1+a)))
C = tf([T, 1], [a * T, 1])

sys2 = K*C*G;
figure
bode(sys); margin(sys)
hold on
bode(sys2); margin(sys2)

[Gm2, Pm2, Wcg2, Wcp2] = margin(sys2);
Pm2

% compute bandwidth, use CL system
[mag, phase, wout] = bode(sys2/(1+sys2), 15.9:0.001:16.1);
mag = mag(:);
err = abs(mag - sqrt(2)/2);
[m, idx] = min(err);
bandwidth = wout(idx)  % bandwidth is omega that comes closest to sqrt(2)/2

%% Problem 2
clear all;
close all;
G = zpk([], [0,-5, -250],5*250)
K = 101;  % K > 100 for steady state tracking error

sys = K*G;
figure
bode(sys); margin(sys)
[Gm, Pm, Wcg, Wcp] = margin(sys);
Pm  % this is > 40, so we are just done??

new_gc = 5;
[mag, phase, wout] = bode(sys, new_gc);
mag_db = 20 * log10(mag);

a = 15;
lower_db_enough = 20 * log10(1/a) < -mag_db

T = 6;

pt1_gc = 0.1 * new_gc
one_on_T = 1/T

Tgc = T * new_gc

C = tf([T, 1], [a*T, 1])

sys2 = K*C*G;
figure
bode(sys); margin(sys)
hold on
bode(sys2); margin(sys2)
%% Problem 3
% do the matrix multiplication
A = [2 1;-1 1];
B = [1;2];
C = [1 1];
F = [4 1];
L = [-12; 19];

result = [A-B*F, -B*F; zeros(2), A-L*C]