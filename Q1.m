%% Q1

Mach = 0:0.01:0.8;
Alt1 = zeros(1, length(Mach));
Alt2 = ones(1, length(Mach))*35000;
Alt3 = 0:1:35000;

Pcode1 = 50 * ones(1, length(Mach));
Mach0 = zeros(1, length(Alt3));
Mach8 = 0.8*ones(1, length(Alt3));
Pcode2 = ones(1, length(Alt3))*50;

[T1, ~, TSFC1] = jt8d(Mach, Alt1, Pcode1);
[T2, ~, TSFC2] = jt8d(Mach, Alt2, Pcode1);
[T3, ~, TSFC3] = jt8d(Mach0, Alt3, Pcode2);
[T4, ~, TSFC4] = jt8d(Mach8, Alt3, Pcode2);
%% Part (a)
subplot(2, 2, 1);
plot(Mach, T1, 'LineWidth', 1);
hold on;
plot(Mach, T2, 'LineWidth', 1);
xlabel("Mach No");
ylabel("Max Thrust (lbs)");
legend('Sea-level','Alt = 35000ft');
title("Max Thrust vs. mach");
grid on;
%% Part (b)
subplot(2, 2, 2);
plot(Alt3, T3, 'LineWidth', 1);
hold on;
plot(Alt3, T4, 'LineWidth', 1);
xlabel("Alt (ft)");
ylabel("Max Thrust (lbs)");
legend('Mach = 0','Mach = 0.8');
title("Max Thrust vs. Alt");
grid on;
%% Part (c)
subplot(2, 2, 3);
plot(Mach, TSFC1, 'LineWidth', 1);
hold on;
plot(Mach, TSFC2, 'LineWidth', 1);
xlabel("Mach Number");
ylabel("TSFC (lbs/lbs-hr)");
legend('Sealevel','Alt = 35000')
title("TSFC vs. Mach");
grid on;

%% Part (d)
subplot(2, 2, 4);
plot(Alt3, TSFC3, 'LineWidth', 1); 
hold on;
plot(Alt3,TSFC4, 'LineWidth', 1);
xlabel("Alt (ft)");
ylabel("TSFC (lbs/lbs-hr)");
legend('Mach = 0','Mach = 0.8');
title("TSFC vs. Alt");
grid on;