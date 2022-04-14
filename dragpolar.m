function CD = dragpolar(CL, Mach)

b = 92; % span
A = 1100; % area

Mcr = 0.73; % critical mach
e = 0.86; % oswald eff
AR = (b^2)/A; % Aspect Ratio
Cd0 = 0.022;
[r,c] = size(Mach);
Cdw = zeros(r,c);
Cdw(Mach>= Mcr) = 20.*(Mach(Mach>=Mcr)-Mcr).^4;


K = 1/(pi*e*AR);
CD = Cdw + Cd0 + K.*CL.^2;
end
