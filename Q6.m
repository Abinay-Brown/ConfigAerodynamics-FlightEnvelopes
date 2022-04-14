clear; clc;
%% Q6
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
V = X .* sqrt(gamma.*R.*temp); % Freestream Velocity
q = (V.^2).*rho./2;            % Dynamic Pressure
Cl = W./(q.*S);                % Lift Coefficient
Cd = dragpolar(Cl, X);         % Drag Coefficient
D = q.*S.*Cd;                  % Drag Force
L = q.*S.*Cl;                  % Lift Force                 
[Tmax, ~, ~] = jt8d(X, Y, 50*ones(size(X))); % Max Thrust
[Tmin, ~, ~] = jt8d(X, Y, 21*ones(size(X))); % Min Thrust
Pcode = (((D./2)-Tmin)./(Tmax-Tmin)).*(50-21) + 21; % Power Code
[Thrust, ~, TSFC] = jt8d(X, Y, Pcode.*ones(size(X))); 
Wf_dot = (2*TSFC).*(2*Thrust)./(60*60); 
SE = 1./Wf_dot;                % Specific Endurance
SR = V./(Wf_dot) /6076;        % Specific Range
%% Margins & Masking
M_b = [0.2, 0.4, 0.6, 0.7, 0.75, 0.78, 0.8, 0.82, 0.84, 0.86, 0.88, 0.9];
C_lb = [1.315, 1.131, 0.899, 0.721, 0.604, 0.512, 0.448, 0.382, 0.316,0.251,0.186, 0.122];
Cl_buffet = interp1(M_b, C_lb, Mach, 'Spline'); % Cl buffet Line

[T, ~, ~] = jt8d(X, Y, 50*ones(size(X))); 
TMargin = 2*T-D;           % Specific Excess Power Limit
CLMargin = Cl_buffet - Cl; % Cl margin

CLMargin(TMargin<=-0.0005) = nan;
TMargin(CLMargin<=-0.0005) = nan;

SE(CLMargin <= 0) = nan;
SE(TMargin  <= 0) = nan;
SR(CLMargin <= 0) = nan;
SR(TMargin  <= 0) = nan;
%% Plotting
% Part (a) Specific Endurance
subplot(1,2,1);
[c, handle] = contour(X, Y, SE, 'LineColor', 'k');
clabel(c, handle);
title('Specific Endurance (sec/lbs), W =100000lbs, S = 1100ft^2');
xlabel('Mach No.');
ylabel('Altitude (ft)');
axis([0 1 0 45000]);
hold on;
oC1 = ocontourc(Mach, Alt, CLMargin, [0, 0]);
handle1 = hatchedcontours(oC1, 'r');
oC2 = ocontourc(Mach, Alt, TMargin, [0, 0]);
handle2 = hatchedcontours(oC2, 'b');
hold off;
grid on;

% Part (b) Specific Range
subplot(1,2,2);
[c, handle] = contour(X, Y, SR, 'LineColor', 'k');
clabel(c, handle);
title('Specific Range (nm/lbs), W =100000lbs, S = 1100ft^2');
xlabel('Mach No.');
ylabel('Altitude (ft)');
axis([0 1 0 45000]);
hold on;
oC3 = ocontourc(Mach, Alt, CLMargin, [0, 0]);
handle3 = hatchedcontours(oC3, 'r');
oC4 = ocontourc(Mach, Alt, TMargin, [0, 0]);
handle4 = hatchedcontours(oC4, 'b');
hold off;
grid on;
disp("Endurance: Max End=0.35sec/lbs near 37000ft at M~0.6-0.7");
disp("Range: Max Range=0.035nm/lbs near 35000ft at Mach~0.7 ");