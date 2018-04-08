%% Output Shaft 1
% clc
% 
% x = 0:0.001:gearbox.shaft.O1.geometry.length;
% 
% %Generate Shear and BendO1g Moment Diagrams
% [VY, VZ, MY, MZ] = O1_VBD(gearbox, x);
% 
% % Plot BendO1g Moment Diagram
% plot(x,VY,x,MY, x, VZ, x, MZ);
% title('Shear and BendO1g Moment Diagram');
% xlabel('Position along shaft [O1]');
% ylabel('Shear - lb, Moment - lbO1');
% legend('Shear XY Plane', 'Moment XY Plane', 'Shear XZ Plane', 'Moment XZ Plane');
% grid on;

%% Calculate diameter of shaft at point 1

%calculate shear and bending at point 1

P1_x = 3;

[VY, VZ, MY, MZ] = O1_VBD(gearbox, P1_x);


%Uncorrected Endurance Limit
gearbox.shaft.O1.material.uncorrected_enduranceP1 = 0.5*gearbox.shaft.O1.material.UTS;
gearbox.shaft.O1.factors.CloadP1 = 1; %torsion and bendO1g
gearbox.shaft.O1.factors.CsizeP1 = 1; %assumed 1
gearbox.shaft.O1.factors.CsurfP1 = 2.7*(gearbox.shaft.O1.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.O1.factors.CtempP1 = 1;
gearbox.shaft.O1.factors.CreliabP1 = 0.868; %assume 90% reliability

gearbox.shaft.O1.material.enduranceP1 = gearbox.shaft.O1.factors.CloadP1 * gearbox.shaft.O1.factors.CsizeP1*...
                                        gearbox.shaft.O1.factors.CsurfP1 * gearbox.shaft.O1.factors.CtempP1*...
                                        gearbox.shaft.O1.factors.CreliabP1 * gearbox.shaft.O1.material.uncorrected_enduranceP1;
%Notch Sensitivity factors
gearbox.shaft.O1.factors.qP1 = 0.85; %assuming notch radius of 0.05 
gearbox.shaft.O1.factors.ktP1 = 4; %assumed at 4 since we have a keyway
gearbox.shaft.O1.factors.ktsP1 = 2; %assumO1g

gearbox.shaft.O1.factors.kfP1 = 1 + gearbox.shaft.O1.factors.qP1*(gearbox.shaft.O1.factors.ktP1 - 1);
gearbox.shaft.O1.factors.kfsP1 = 1 + gearbox.shaft.O1.factors.qP1*(gearbox.shaft.O1.factors.ktsP1 - 1);
gearbox.shaft.O1.factors.safety = 2;

gearbox.shaft.O1.TMP1 = gearbox.gear1.loads.T;
gearbox.shaft.O1.MAP1 = sqrt(MY^2 + MZ^2); 

gearbox.shaft.O1.dP1 = ((32*gearbox.shaft.O1.factors.safety/pi)*sqrt((gearbox.shaft.O1.factors.kfP1*gearbox.shaft.O1.MAP1/gearbox.shaft.O1.material.enduranceP1)^2+(3/4)*(gearbox.shaft.O1.factors.kfsP1*gearbox.shaft.O1.TMP1/gearbox.shaft.O1.material.UTS)^2))^(1/3);

gearbox.shaft.O1.dP1 = ceil((gearbox.shaft.O1.dP1-floor(gearbox.shaft.O1.dP1))/0.125)*0.125 + floor(gearbox.shaft.O1.dP1); %round up to next 0.125

%% Recalculate safetly factor

gearbox.shaft.O1.material.uncorrected_enduranceP1 = 0.5 * gearbox.shaft.O1.material.UTS;
gearbox.shaft.O1.factors.CloadP1 = 1; %torsion and bendO1g
gearbox.shaft.O1.factors.CsizeP1 = 0.869*gearbox.shaft.O1.dP1^(-0.097);
gearbox.shaft.O1.factors.CsurfP1 = 2.7*(gearbox.shaft.O1.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.O1.factors.CtempP1 = 1;
gearbox.shaft.O1.factors.CreliabP1 = 0.868; %assume 90% reliability

gearbox.shaft.O1.material.enduranceP1 = gearbox.shaft.O1.factors.CloadP1*gearbox.shaft.O1.factors.CsizeP1*gearbox.shaft.O1.factors.CsurfP1*gearbox.shaft.O1.factors.CtempP1*gearbox.shaft.O1.factors.CreliabP1*gearbox.shaft.O1.material.uncorrected_enduranceP1;

gearbox.shaft.O1.factors.qP1 = 0.75; %assumO1g notch radius of 0.05 
gearbox.shaft.O1.factors.ktP1 = 0.9512*(0.05^(-0.23757)); %with r/d = 0.05, D/d = 1.1
gearbox.shaft.O1.factors.ktsP1 = 0.903*(0.05^(-0.126)); %with r/d = 0.05, D/d = 1.1

gearbox.shaft.O1.factors.kfP1 = 1 + gearbox.shaft.O1.factors.qP1*(gearbox.shaft.O1.factors.ktP1 - 1);
gearbox.shaft.O1.factors.kfsP1 = 1 + gearbox.shaft.O1.factors.qP1*(gearbox.shaft.O1.factors.ktsP1 - 1);

gearbox.shaft.O1.sigmaAP1 = gearbox.shaft.O1.factors.kfP1*sqrt((MY*(gearbox.shaft.O1.dP1/2)/((pi*gearbox.shaft.O1.dP1^4)/64))^2+(MZ*(gearbox.shaft.O1.dP1/2)/((pi*gearbox.shaft.O1.dP1^4)/64))^2);
gearbox.shaft.O1.tauMP1 = gearbox.shaft.O1.factors.ktsP1*gearbox.gear1.loads.T*(gearbox.shaft.O1.dP1/2)/((pi*gearbox.shaft.O1.dP1^4)/32);

gearbox.shaft.O1.sigmaAP1_VM = gearbox.shaft.O1.sigmaAP1;
gearbox.shaft.O1.sigmaMP1_VM = sqrt(3*(gearbox.shaft.O1.tauMP1^2));

gearbox.shaft.O1.mod_safetyP1 = (gearbox.shaft.O1.material.enduranceP1*gearbox.shaft.O1.material.UTS)/((gearbox.shaft.O1.sigmaAP1_VM*gearbox.shaft.O1.material.UTS)+(gearbox.shaft.O1.material.enduranceP1*gearbox.shaft.O1.sigmaMP1_VM));



