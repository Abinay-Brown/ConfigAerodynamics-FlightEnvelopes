clear; clc;
%% Q3
%% Aircraft Parameters
W = 100000;                      % (lb) MTOGW-Fuel_TO_CLimb
S = 1100;                        % Area (ft^2)
R = 1717;                        % Gas Constant
gamma = 1.4;                     % Specific Heat Ratio
%% Altitude & Mach Ranges
Alt = 0:20:45000;                   % Alt (ft)
Mach = linspace(0, 1, length(Alt)); % Mach 
[X, Y] = meshgrid(Mach, Alt);
%% Calculation
[temp, ~, rho, ~, ~] = atmosphere(Y);
V = X .* sqrt(gamma.*R.*temp); % Freestream Velocity (ft/s)
q = (V.^2).*rho./2;            % Dynamic Pressure
Cl = W./(q.*S);                % Lift Coefficient
Cd = dragpolar(Cl, X);         % Drag Coefficient
D = q.*S.*Cd;                  % Drag Force
[T, ~, ~] = jt8d(X, Y, 50*ones(size(X)));  % Max Thrust
Z =  (2*T-D).*V./W.*60; % Specific Excess Power

%% Margins & Masking
Tmargin = (2*T-D); % Specific Excess Power Limit
Z(Tmargin<0) = nan;   % Masking negative results

%% Plotting
[c, handle] = contour(X, Y, Z, 'LineColor', 'k');
clabel(c, handle);
title('Specific Excess Power (ft/min), W =100000lbs, S = 1100ft^2, PC = 50');
xlabel('Mach No.');
ylabel('Altitude (ft)');
axis([0 1 0 45000]);
hold on;
grid on;
% Plotting Hatched Line Thrust margin
oC = ocontourc(Mach, Alt, Tmargin, [0, 0]);
handle2 = hatchedcontours(oC, 'r');
hold off;