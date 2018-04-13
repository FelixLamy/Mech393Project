%% Output Shaft 1
% clc
% 
% x = 0:0.001:gearbox.shaft.O1.geometry.length;
% 
% % Generate Shear and BendO1g Moment Diagrams
% [VY, VZ, MY, MZ] = O1_VBM(gearbox, x);
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

gearbox.shaft.O1.RLZ = (gearbox.gear1.geometry.position(1)/gearbox.shaft.O1.geometry.length)*gearbox.gear1.loads.FW(3);
gearbox.shaft.O1.RLY = (gearbox.gear1.geometry.position(1)/gearbox.shaft.O1.geometry.length)*gearbox.gear1.loads.FW(2);
 
gearbox.shaft.O1.ROZ = -gearbox.shaft.O1.RLZ + gearbox.gear1.loads.FW(3);
gearbox.shaft.O1.ROY = -gearbox.shaft.O1.RLY + gearbox.gear1.loads.FW(2);
 
gearbox.shaft.O1.RY =[gearbox.shaft.O1.ROY gearbox.shaft.O1.RLY]; %(-,-)
gearbox.shaft.O1.RZ =[gearbox.shaft.O1.ROZ gearbox.shaft.O1.RLZ]; %(-,-)
 

VBG1 = O1_BM(1.061,gearbox.gear1.geometry.position(1),gearbox.shaft.O1.geometry.length, gearbox.gear1.loads.FW, gearbox.shaft.O1.ROY, gearbox.shaft.O1.ROZ, gearbox.shaft.O1.RLY, gearbox.shaft.O1.RLZ);

%Uncorrected Endurance Limit
gearbox.shaft.O1.material.uncorrected_enduranceG1 = 0.5*gearbox.shaft.O1.material.UTS;
gearbox.shaft.O1.factors.CloadG1 = 1; %torsion and bending
gearbox.shaft.O1.factors.CsizeG1 = 1; %assumed 1
gearbox.shaft.O1.factors.CsurfG1 = 2.7*(gearbox.shaft.O1.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.O1.factors.CtempG1 = 1;
gearbox.shaft.O1.factors.CreliabG1 = 0.868; %assume 90% reliability

gearbox.shaft.O1.material.enduranceG1 = gearbox.shaft.O1.factors.CloadG1 * gearbox.shaft.O1.factors.CsizeG1*...
                                        gearbox.shaft.O1.factors.CsurfG1 * gearbox.shaft.O1.factors.CtempG1*...
                                        gearbox.shaft.O1.factors.CreliabG1 * gearbox.shaft.O1.material.uncorrected_enduranceG1;
                                    
%Notch Sensitivity factors
gearbox.shaft.O1.factors.qG1 = 0.85; %assuming notch radius of 0.05 
gearbox.shaft.O1.factors.ktG1 = 4; %assumed at 4 since we have a keyway
gearbox.shaft.O1.factors.ktsG1 = 2; %assumption

gearbox.shaft.O1.factors.kfG1 = 1 + gearbox.shaft.O1.factors.qG1*(gearbox.shaft.O1.factors.ktG1 - 1);
gearbox.shaft.O1.factors.kfsG1 = 1 + gearbox.shaft.O1.factors.qG1*(gearbox.shaft.O1.factors.ktsG1 - 1);
gearbox.shaft.O1.factors.safety = 2;

gearbox.shaft.O1.TMG1 = gearbox.gear1.loads.T;
gearbox.shaft.O1.MAG1 = sqrt(VBG1(2,1)^2 + VBG1(2,2)^2); 

gearbox.shaft.O1.dG1 = ((32*gearbox.shaft.O1.factors.safety/pi)*sqrt((gearbox.shaft.O1.factors.kfG1*gearbox.shaft.O1.MAG1/gearbox.shaft.O1.material.enduranceG1)^2+(3/4)*(gearbox.shaft.O1.factors.kfsG1*gearbox.shaft.O1.TMG1/gearbox.shaft.O1.material.UTS)^2))^(1/3);

% gearbox.shaft.O1.dG1 = ceil((gearbox.shaft.O1.dG1-floor(gearbox.shaft.O1.dG1))/0.125)*0.125 + floor(gearbox.shaft.O1.dG1); %round up to next 0.125

%% Recalculate safetly factor

gearbox.shaft.O1.material.uncorrected_enduranceG1 = 0.5 * gearbox.shaft.O1.material.UTS;
gearbox.shaft.O1.factors.CloadG1 = 1; %torsion and bendO1g
gearbox.shaft.O1.factors.CsizeG1 = 0.869*gearbox.shaft.O1.dG1^(-0.097);
gearbox.shaft.O1.factors.CsurfG1 = 2.7*(gearbox.shaft.O1.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.O1.factors.CtempG1 = 1;
gearbox.shaft.O1.factors.CreliabG1 = 0.868; %assume 90% reliability

gearbox.shaft.O1.material.enduranceG1 = gearbox.shaft.O1.factors.CloadG1*gearbox.shaft.O1.factors.CsizeG1*...
                                        gearbox.shaft.O1.factors.CsurfG1*gearbox.shaft.O1.factors.CtempG1*...
                                        gearbox.shaft.O1.factors.CreliabG1*gearbox.shaft.O1.material.uncorrected_enduranceG1;

gearbox.shaft.O1.factors.qG1 = 0.84; %assuming notch radius of 0.05 
gearbox.shaft.O1.factors.ktG1 = 0.9512*(0.05^(-0.23757)); %with r/d = 0.05, D/d = 1.1
gearbox.shaft.O1.factors.ktsG1 = 0.903*(0.05^(-0.126)); %with r/d = 0.05, D/d = 1.1

gearbox.shaft.O1.factors.kfG1 = 1 + gearbox.shaft.O1.factors.qG1*(gearbox.shaft.O1.factors.ktG1 - 1);
gearbox.shaft.O1.factors.kfsG1 = 1 + gearbox.shaft.O1.factors.qG1*(gearbox.shaft.O1.factors.ktsG1 - 1);

gearbox.shaft.O1.sigmaAG1 = gearbox.shaft.O1.factors.kfG1*sqrt((VBG1(2,1)*(gearbox.shaft.O1.dG1/2)/((pi*gearbox.shaft.O1.dG1^4)/64))^2+(VBG1(2,2)*(gearbox.shaft.O1.dG1/2)/((pi*gearbox.shaft.O1.dG1^4)/64))^2);
gearbox.shaft.O1.tauMG1 = gearbox.shaft.O1.factors.kfsG1*gearbox.gear1.loads.T*(gearbox.shaft.O1.dG1/2)/((pi*gearbox.shaft.O1.dG1^4)/32);

gearbox.shaft.O1.sigmaAG1_VM = gearbox.shaft.O1.sigmaAG1;
gearbox.shaft.O1.sigmaMG1_VM = sqrt(3*(gearbox.shaft.O1.tauMG1^2));

gearbox.shaft.O1.mod_safetyG1 = (gearbox.shaft.O1.material.enduranceG1*gearbox.shaft.O1.material.UTS)/((gearbox.shaft.O1.sigmaAG1_VM*gearbox.shaft.O1.material.UTS)+(gearbox.shaft.O1.material.enduranceG1*gearbox.shaft.O1.sigmaMG1_VM));

%% Keyseat Safety factor in shaft at 
 
VBG1_key = O1_BM(gearbox.gear1.geometry.position(1),gearbox.gear1.geometry.position(1),gearbox.shaft.O1.geometry.length, gearbox.gear1.loads.FW, gearbox.shaft.O1.ROY, gearbox.shaft.O1.ROZ, gearbox.shaft.O1.RLY, gearbox.shaft.O1.RLZ);

gearbox.shaft.O1.keyG1.factors.ktG1 = 2.2; %at standard r/d ratio of 0.021
gearbox.shaft.O1.keyG1.factors.ktsG1 = 3; %at standard r/d ratio of 0.021
gearbox.shaft.O1.keyG1.factors.qG1 = 0.71; %at r = 0.021 and figure 6-36
gearbox.shaft.O1.keyG1.factors.kfG1 = 1 + gearbox.shaft.O1.keyG1.factors.qG1*(gearbox.shaft.O1.keyG1.factors.ktG1-1);
gearbox.shaft.O1.keyG1.factors.kfsG1 = 1 + gearbox.shaft.O1.keyG1.factors.qG1*(gearbox.shaft.O1.keyG1.factors.ktsG1-1);
 
gearbox.shaft.O1.keyG1.sigmaAG1 = gearbox.shaft.O1.keyG1.factors.kfG1*sqrt((VBG1_key(2,1)*(gearbox.shaft.O1.dG1/2)/((pi*gearbox.shaft.O1.dG1^4)/64))^2+(VBG1_key(2,2)*(gearbox.shaft.O1.dG1/2)/((pi*gearbox.shaft.O1.dG1^4)/64))^2);
gearbox.shaft.O1.keyG1.tauMG1 = gearbox.shaft.O1.keyG1.factors.kfsG1*gearbox.gear1.loads.T*(gearbox.shaft.O1.dG1/2)/((pi*gearbox.shaft.O1.dG1^4)/32);
 
gearbox.shaft.O1.keyG1.sigmaAG1_VM = gearbox.shaft.O1.keyG1.sigmaAG1;
gearbox.shaft.O1.keyG1.sigmaMG1_VM = sqrt(3*(gearbox.shaft.O1.keyG1.tauMG1^2));
 
gearbox.shaft.O1.keyG1.mod_safetyG1 = (gearbox.shaft.O1.material.enduranceG1*gearbox.shaft.O1.material.UTS)/((gearbox.shaft.O1.keyG1.sigmaAG1_VM*gearbox.shaft.O1.material.UTS)+(gearbox.shaft.O1.material.enduranceG1*gearbox.shaft.O1.keyG1.sigmaMG1_VM));

%% Keys In Output Shaft 1

gearbox.shaft.O1.keyG1.length = 2.5; %in
gearbox.shaft.O1.keyG1.width = 0.187; %in

gearbox.shaft.O1.keyG1.shear = abs(gearbox.gear1.loads.T/(0.5*gearbox.shaft.O1.dG1))/(gearbox.shaft.O1.keyG1.length*gearbox.shaft.O1.keyG1.width);

%assume keys are square
gearbox.shaft.O1.keyG1.bearing = abs(gearbox.gear1.loads.T/(0.5*gearbox.shaft.O1.dG1))/(gearbox.shaft.O1.keyG1.length*gearbox.shaft.O1.keyG1.width*0.5);

%Shear safety factor
gearbox.shaft.O1.keyG1.safety_shear = gearbox.shaft.O1.keyG1.material.UTS/sqrt(3*gearbox.shaft.O1.keyG1.shear^2);

%Bearing Safety Factor
gearbox.shaft.O1.keyG1.safety_bearing = gearbox.shaft.O1.keyG1.material.yield/gearbox.shaft.O1.keyG1.bearing;
