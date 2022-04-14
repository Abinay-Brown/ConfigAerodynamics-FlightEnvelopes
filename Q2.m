clear; clc;
%% Q2
%% part a)

Cl = 0.1;
M = 0:0.01:0.86;
Cd = dragpolar(Cl, M);
subplot(1,2,1);
plot(M, Cd);
hold on;
Cl = 0.2;
Cd = dragpolar(Cl, M);
plot(M, Cd);
hold on;
Cl = 0.3;
Cd = dragpolar(Cl, M);
plot(M, Cd);
grid on;
legend('Cl = 0.1', 'Cl = 0.2', 'Cl = 0.3');
xlabel('Mach No.');
ylabel('C_D');
title('C_D vs. Mach');
%% part b)
subplot(1,2,2);
Cl = 0:0.001:0.4;
M = 0.7;
Cd = dragpolar(Cl, M);
plot(Cd, Cl);
hold on;
M = 0.75;
Cd = dragpolar(Cl, M);
plot(Cd, Cl);
hold on;
M = 0.8;
Cd = dragpolar(Cl, M);
plot(Cd, Cl);
hold on;
M = 0.85;
Cd = dragpolar(Cl, M);
plot(Cd, Cl);
hold on;
legend('0.7', '0.75', '0.8', '0.85');
xlabel('C_D');
ylabel('C_L');
title('C_L vs. C_D');
grid on;
disp("There is a Sharp rise in Drag Coefficient when Mach Number Approaches 0.76");