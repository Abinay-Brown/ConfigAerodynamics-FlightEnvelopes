% 1976 US Standard Atmosphere
% http://www.atmosculator.com/The%20Standard%20Atmosphere.html?
% David Pate and Michael Patterson
%
%INPUTS
%  h = altitude in feet
%OUTPUTS
%  temp = temperature in °R
%  pres = pressure in lb/ft^2
%  rho = density in slug/ft^3
%  mu = viscosity in slug/(ft-s)
%  a = sound speed ft/s assuming R=1716 ft-lb/(slugs-°R) and gamma = 1.4

function [temp,pres,rho,mu,a] = atmosphere(h)

dims = size(h);     %what shape is h?
h = h(:);           %turns it into a column vector

R = 1716;
gamma = 1.4;


T_SL = 518.69;      %°R
T0 = 491.6;         %°R
p_SL = 2116.2;      %lb/ft^2
rho_SL = .0023769;  %slug/ft^3
mu0 = 3.58394051e-7;    %slug/(ft-s)
% 3.7373e-7;    %slug/(ft-s)
S = 199;            %Sutherland's Constant °R

a = h <= 36809;
    theta(a) = 1 - h(a) ./ 145442;
    delta(a) = (1 - h(a) ./ 145442).^5.255876;
    sigma(a) = (1 - h(a) ./ 145442).^4.255876;
    

% Isothermal
b = (36089 < h) & (h <= 65617);
    theta(b) = 0.751865;
    delta(b) = 0.223361 .* exp(-(h(b)-36089)./20806);
    sigma(b) = 0.297076 .* exp(-(h(b)-36089)./20806);
    

% (Inversion)
c = (65617 < h) & (h <= 104987);
    theta(c) = 0.682457 + h(c) ./ 945374;
    delta(c) = (0.988626 + h(c) ./ 652600).^(-34.16320);
    sigma(c) = (0.978261 + h(c) ./ 659515).^(-35.16320);


% (Inversion)
d = (104987 < h) & (h <= 154199);
    theta(d) = 0.482561 + h(d) ./ 337634;
    delta(d) = (0.898309 + h(d) ./ 181373).^(-12.20114);
    sigma(d) = (0.857003 + h(d) ./ 190115).^(-13.20114);


% (Isothermal)
e = (154199 < h) & (h <= 167323);
    theta(e) = 0.939268;
    delta(e) = 0.00109456 .* exp(-(h(e)-154199)./25992);
    sigma(e) = 0.00116533 .* exp(-(h(e)-154199)./25992);


f = (167323 < h) & (h <= 232940);
    theta(f) = 1.434843 - h(f) ./ 337634;
    delta(f) = (0.838263 - h(f) ./ 577922).^12.20114;
    sigma(f) = (0.798990 - h(f) ./ 606330).^11.20114;


g = (232940 < h) & (h <= 278386);
    theta(g) = 1.237723 - h(g) ./ 472687;
    delta(g) = (0.917131 - h(g) ./ 637919).^17.08160;
    sigma(g) = (0.900194 - h(g) ./ 649922).^16.08160;


temp = theta .* T_SL;
pres = delta .* p_SL;
rho = sigma .* rho_SL;
mu = mu0 .* (temp/T0).^(3/2) .* (T0 + S) ./ (temp + S);
    
temp = reshape(temp,dims);  %turns these into the form of input h
pres = reshape(pres,dims); 
rho = reshape(rho,dims); 
mu = reshape(mu,dims); 
a = (gamma .* R .* temp).^(0.5);
    
