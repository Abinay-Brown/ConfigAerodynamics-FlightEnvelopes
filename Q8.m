clear; clc;
load('Q7_Points.mat', 'WI1', 'WF1', 'WI2', 'WF2', 'WI3', 'WF3');
%% Q8
%% Aircraft Parameters
Alt = 30000;
Mach= 0.76;

Wi = [WI1, WI2, WI3];
Wf = [WF1, WF2, WF3];
S = 1100; % Area (ft^2)
R = 1717; % Gas Constant
gamma = 1.4; % Specific Heat Ratio

%% Calculations
[temp, ~, rho, ~, ~] = atmosphere(Alt);
V = (Mach .* sqrt(gamma.*R.*temp)); % Freestream velocity (ft/s)
q = (V.^2).*rho./2;         % Dyanamic Pressure   
Cl = Wi./(q.*S);            % Lift Coefficient
Cd = dragpolar(Cl, Mach);   % Drag Coefficient
D = q.*S.*Cd;               % Drag Force
L = q.*S.*Cl;               % Lift Force

[Tmax, ~, ~] = jt8d(Mach, Alt, 50); % Max Thrust
[Tmin, ~, ~] = jt8d(Mach, Alt, 21); % Min Thrust
Tmax = Tmax*2;
Tmin = Tmin*2;
Pcode = (((D./2)-Tmin)./(Tmax-Tmin)).*(50-21) + 21; % Power Code
[~, ~, TSFC] = jt8d(Mach*ones(1,3), Alt*ones(1,3), Pcode); % TSFC

R = (((V.*(L./D))./(2*TSFC/(60*60))).*log(Wi./Wf))/6076; % Range Equation
