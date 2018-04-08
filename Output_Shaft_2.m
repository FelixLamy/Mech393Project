%% Output Shaft 2
clc

x = 0:0.001:gearbox.shaft.O2.geometry.length;

%Generate Shear and BendO2g Moment Diagrams
[VY, VZ, MY, MZ] = O2_VBD(gearbox, x);

% Plot BendO2g Moment Diagram
plot(x,VY,x,MY, x, VZ, x, MZ);
title('Shear and Bending Moment Diagram');
xlabel('Position along shaft [O2]');
ylabel('Shear - lb, Moment - lbO2');
legend('Shear XY Plane', 'Moment XY Plane', 'Shear XZ Plane', 'Moment XZ Plane');
grid on;

%% Calculate diameter of shaft at point 1

%calculate shear and bending at point 1

P1_x = 3;

[VY, VZ, MY, MZ] = O2_VBD(gearbox, P1_x);


%Uncorrected Endurance Limit
gearbox.shaft.O2.material.uncorrected_enduranceP1 = 0.5*gearbox.shaft.O2.material.UTS;
gearbox.shaft.O2.factors.CloadP1 = 1; %torsion and bendO2g
gearbox.shaft.O2.factors.CsizeP1 = 1; %assumed 1
gearbox.shaft.O2.factors.CsurfP1 = 2.7*(gearbox.shaft.O2.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.O2.factors.CtempP1 = 1;
gearbox.shaft.O2.factors.CreliabP1 = 0.868; %assume 90% reliability

gearbox.shaft.O2.material.enduranceP1 = gearbox.shaft.O2.factors.CloadP1 * gearbox.shaft.O2.factors.CsizeP1*...
                                        gearbox.shaft.O2.factors.CsurfP1 * gearbox.shaft.O2.factors.CtempP1*...
                                        gearbox.shaft.O2.factors.CreliabP1 * gearbox.shaft.O2.material.uncorrected_enduranceP1;
%Notch Sensitivity factors
gearbox.shaft.O2.factors.qP1 = 0.85; %assuming notch radius of 0.05 
gearbox.shaft.O2.factors.ktP1 = 4; %assumed at 4 since we have a keyway
gearbox.shaft.O2.factors.ktsP1 = 2; %assumO2g

gearbox.shaft.O2.factors.kfP1 = 1 + gearbox.shaft.O2.factors.qP1*(gearbox.shaft.O2.factors.ktP1 - 1);
gearbox.shaft.O2.factors.kfsP1 = 1 + gearbox.shaft.O2.factors.qP1*(gearbox.shaft.O2.factors.ktsP1 - 1);
gearbox.shaft.O2.factors.safety = 2;

gearbox.shaft.O2.TMP1 = gearbox.gear1.loads.T;
gearbox.shaft.O2.MAP1 = sqrt(MY^2 + MZ^2); 

gearbox.shaft.O2.dP1 = ((32*gearbox.shaft.O2.factors.safety/pi)*sqrt((gearbox.shaft.O2.factors.kfP1*gearbox.shaft.O2.MAP1/gearbox.shaft.O2.material.enduranceP1)^2+(3/4)*(gearbox.shaft.O2.factors.kfsP1*gearbox.shaft.O2.TMP1/gearbox.shaft.O2.material.UTS)^2))^(1/3);

gearbox.shaft.O2.dP1 = ceil((gearbox.shaft.O2.dP1-floor(gearbox.shaft.O2.dP1))/0.125)*0.125 + floor(gearbox.shaft.O2.dP1); %round up to next 0.125

%% Recalculate safetly factor

gearbox.shaft.O2.material.uncorrected_enduranceP1 = 0.5 * gearbox.shaft.O2.material.UTS;
gearbox.shaft.O2.factors.CloadP1 = 1; %torsion and bendO2g
gearbox.shaft.O2.factors.CsizeP1 = 0.869*gearbox.shaft.O2.dP1^(-0.097);
gearbox.shaft.O2.factors.CsurfP1 = 2.7*(gearbox.shaft.O2.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.O2.factors.CtempP1 = 1;
gearbox.shaft.O2.factors.CreliabP1 = 0.868; %assume 90% reliability

gearbox.shaft.O2.material.enduranceP1 = gearbox.shaft.O2.factors.CloadP1*gearbox.shaft.O2.factors.CsizeP1*gearbox.shaft.O2.factors.CsurfP1*gearbox.shaft.O2.factors.CtempP1*gearbox.shaft.O2.factors.CreliabP1*gearbox.shaft.O2.material.uncorrected_enduranceP1;

gearbox.shaft.O2.factors.qP1 = 0.75; %assumO2g notch radius of 0.05 
gearbox.shaft.O2.factors.ktP1 = 0.9512*(0.05^(-0.23757)); %with r/d = 0.05, D/d = 1.1
gearbox.shaft.O2.factors.ktsP1 = 0.903*(0.05^(-0.126)); %with r/d = 0.05, D/d = 1.1

gearbox.shaft.O2.factors.kfP1 = 1 + gearbox.shaft.O2.factors.qP1*(gearbox.shaft.O2.factors.ktP1 - 1);
gearbox.shaft.O2.factors.kfsP1 = 1 + gearbox.shaft.O2.factors.qP1*(gearbox.shaft.O2.factors.ktsP1 - 1);

gearbox.shaft.O2.sigmaAP1 = gearbox.shaft.O2.factors.kfP1*sqrt((MY*(gearbox.shaft.O2.dP1/2)/((pi*gearbox.shaft.O2.dP1^4)/64))^2+(MZ*(gearbox.shaft.O2.dP1/2)/((pi*gearbox.shaft.O2.dP1^4)/64))^2);
gearbox.shaft.O2.tauMP1 = gearbox.shaft.O2.factors.ktsP1*gearbox.gear1.loads.T*(gearbox.shaft.O2.dP1/2)/((pi*gearbox.shaft.O2.dP1^4)/32);

gearbox.shaft.O2.sigmaAP1_VM = gearbox.shaft.O2.sigmaAP1;
gearbox.shaft.O2.sigmaMP1_VM = sqrt(3*(gearbox.shaft.O2.tauMP1^2));

gearbox.shaft.O2.mod_safetyP1 = (gearbox.shaft.O2.material.enduranceP1*gearbox.shaft.O2.material.UTS)/((gearbox.shaft.O2.sigmaAP1_VM*gearbox.shaft.O2.material.UTS)+(gearbox.shaft.O2.material.enduranceP1*gearbox.shaft.O2.sigmaMP1_VM));

