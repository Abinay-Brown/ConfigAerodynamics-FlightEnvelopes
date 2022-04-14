clear; clc;
%% Q4
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
[T, ~, ~] = jt8d(X, Y, 50*ones(size(X))); 
D = q.*S.*Cd;
%% Margins & Masking
C_lb = [1.315, 1.131, 0.899, 0.721, 0.604, 0.512, 0.448, 0.382, 0.316,0.251,0.186, 0.122];
M_b = [0.2, 0.4, 0.6, 0.7, 0.75, 0.78, 0.8, 0.82, 0.84, 0.86, 0.88, 0.9];

Cl_buffet = interp1(M_b, C_lb, Mach, 'Spline'); % Cl buffet Line

TMargin = 2*T-D;    % Specific Excess Power Limit
CLMargin = Cl_buffet - Cl;

CLMargin(TMargin<=-0.0005) = nan;
TMargin(CLMargin<=-0.0005) = nan;
Cl(CLMargin<0) = nan;
Cl(TMargin<0) = nan;
Z = Cl;
%% Plotting
[c, handle] = contour(X,Y,Z, 'LineColor', 'k');
clabel(c, handle);
title('Lift Coefficient C_L, W =100000lbs, S = 1100ft^2, PC = 50');
xlabel('Mach No.');
ylabel('Altitude (ft)');
axis([0 1 0 45000]);
grid on;
hold on;
% Plotting Hatched Lines Cl Margin
oC1 = ocontourc(Mach, Alt, CLMargin, [0, 0]);
handle1 = hatchedcontours(oC1, 'r');
hold on;
% Plotting hatched Lines T Margin
oC2 = ocontourc(Mach, Alt, TMargin, [0, 0]);
handle2 = hatchedcontours(oC2, 'b');
hold off;
