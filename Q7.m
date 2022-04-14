clear; clc;
%% Q7
MTOGW = 115000; % Max Take-Off Gross Weight (lbs)
MFW = 25000;    % Max Fuel Weight (lbs) 
OEW = 65000;    % Operational Empty Weight (lbs)
MPW = 35000;    % Max Payload Weight (lbs)
TOCFW = 2000;   % Take-off & Climb Fuel Weight (lbs)
RFACP = 4000;   % Reserve Fuel after Cruise (lbs)

%% Point 1
TOGW1 = MTOGW;   
PW1 = MPW;
FW1 = TOGW1 - OEW - MPW; 
ZFW = TOGW1 - FW1;
% Initial & Final Weights
WI1 = TOGW1 - TOCFW; 
WF1 = MTOGW - FW1 + RFACP;
disp(sprintf("Point 1 : Wi = %0.2f (lbs), Wf = %0.2f (lbs)", WI1, WF1));
%% Point 2
TOGW2 = MTOGW;
FW2 =MFW;
PW2 =  MTOGW - MFW - OEW;
ZFW2 = OEW + PW2;
% Initial & Final Weights
WI2 = TOGW1 - TOCFW;
WF2 = MTOGW - FW2 + RFACP;
disp(sprintf("Point 2 : Wi = %0.2f (lbs), Wf = %0.2f (lbs)", WI2, WF2));
%% Point 3
FW3 = MFW;
PW3 = 0;
TOGW3 = OEW + MFW;
ZFW3= OEW;
% Initial & Final Weights
WI3 = TOGW3 - TOCFW;
WF3 = TOGW3 + RFACP - FW3;
disp(sprintf("Point 3 : Wi = %0.2f (lbs), Wf = %0.2f (lbs)", WI3, WF3));
save('Q7_Points.mat', 'WI1', 'WF1', 'WI2', 'WF2', 'WI3', 'WF3');