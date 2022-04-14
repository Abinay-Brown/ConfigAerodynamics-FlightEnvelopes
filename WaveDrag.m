clear; clc;
Sweep_1 = 20.54948;
tc_1 = 0.0998;
Cl_1 = 0.5305;

Sweep_2 = 23.4846;
tc_2 = 0.0998;
Cl_2 = 0.693;

ka = 0.95;

Mdd1 = (ka - (Cl_1/(10*cosd(Sweep_1)^2)) - (tc_1/cosd(Sweep_1)))/cosd(Sweep_1);
Mcr1 = Mdd1 - (0.1/80)^(1/3);

Mdd2 = (ka - (Cl_2/(10*cosd(Sweep_2)^2)) - (tc_2/cosd(Sweep_2)))/cosd(Sweep_2);
Mcr2 = Mdd2 - (0.1/80)^(1/3);
M = 0.84;
A1 = 1600/6000;
A2 = 1400/6000;
Cdw1 = 20*(M-Mcr1)^4;
Cdw2 = 20*(M-Mcr2)^4;

CDW = 2*((Cdw1*A1) + (Cdw2*A2));

