Gearbox_Parameters;
Forces_Torques;
Shafts;

%% Reaction Force Calculation

gearbox.shaft.ID.RLY = gearbox.shaft.ID.bearing2.loads.F(2);
gearbox.shaft.ID.RLZ = gearbox.shaft.ID.bearing2.loads.F(3);
gearbox.shaft.ID.ROY = gearbox.shaft.ID.bearing1.loads.F(2);
gearbox.shaft.ID.ROZ = gearbox.shaft.ID.bearing1.loads.F(3);
gearbox.shaft.ID.torsion = [gearbox.gear2.loads.T+gearbox.pinion3.loads.T,gearbox.gear2.loads.T,0];

%% Diameter 0<x<centerline of P2 + 0.5D

VBG2 = ID_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5+(gearbox.gear2.geometry.facewidth*0.5),gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.F,gearbox.pinion3.loads.F,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);

gearbox.shaft.ID.material.uncorrected_enduranceG2 = 0.5*gearbox.shaft.ID.material.UTS;
gearbox.shaft.ID.factors.CloadG2 = 1; %torsion and bending
gearbox.shaft.ID.factors.CsizeG2 = 1; %assumed 1
gearbox.shaft.ID.factors.CsurfG2 = 2.7*(gearbox.shaft.ID.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.ID.factors.CtempG2 = 1;
gearbox.shaft.ID.factors.CreliabG2 = 0.868; %assume 90% reliability

gearbox.shaft.ID.material.enduranceG2 = gearbox.shaft.ID.factors.CloadG2*gearbox.shaft.ID.factors.CsizeG2*gearbox.shaft.ID.factors.CsurfG2*gearbox.shaft.ID.factors.CtempG2*gearbox.shaft.ID.factors.CreliabG2*gearbox.shaft.ID.material.uncorrected_enduranceG2;

gearbox.shaft.ID.factors.qG2 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.ID.factors.ktG2 = 3.5; %assuming
gearbox.shaft.ID.factors.ktsG2 = 2; %assuming

gearbox.shaft.ID.factors.kfG2 = 1 + gearbox.shaft.ID.factors.qG2*(gearbox.shaft.ID.factors.ktG2 - 1);
gearbox.shaft.ID.factors.kfsG2 = 1 + gearbox.shaft.ID.factors.qG2*(gearbox.shaft.ID.factors.ktsG2 - 1);
gearbox.shaft.ID.factors.safety = 2;

gearbox.shaft.ID.TMG2 = gearbox.shaft.ID.torsion(1); %fully reversed loading
gearbox.shaft.ID.MAG2 = sqrt(VBG2(2,1)^2 + VBG2(2,2)^2); 

gearbox.shaft.ID.dG2 = ((32*gearbox.shaft.ID.factors.safety/pi)*sqrt((gearbox.shaft.ID.factors.kfG2*gearbox.shaft.ID.MAG2/gearbox.shaft.ID.material.enduranceG2)^2+(3/4)*(gearbox.shaft.ID.factors.kfsG2*gearbox.shaft.ID.TMG2/gearbox.shaft.ID.material.UTS)^2))^(1/3);


gearbox.shaft.ID.dG2 = floor(gearbox.shaft.ID.dG2)+ceil((gearbox.shaft.ID.dG2-floor(gearbox.shaft.ID.dG2))/0.25)*0.25; %round up to next quarter

%% Recalculate safetly factor

gearbox.shaft.ID.material.uncorrected_enduranceG2 = 0.5*gearbox.shaft.ID.material.UTS;
gearbox.shaft.ID.factors.CloadG2 = 1; %torsion and bending
gearbox.shaft.ID.factors.CsizeG2 = 0.869*gearbox.shaft.ID.dG2^(-0.097);
gearbox.shaft.ID.factors.CsurfG2 = 2.7*(gearbox.shaft.ID.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.ID.factors.CtempG2 = 1;
gearbox.shaft.ID.factors.CreliabG2 = 0.868; %assume 90% reliability

gearbox.shaft.ID.material.enduranceG2 = gearbox.shaft.ID.factors.CloadG2*gearbox.shaft.ID.factors.CsizeG2*gearbox.shaft.ID.factors.CsurfG2*gearbox.shaft.ID.factors.CtempG2*gearbox.shaft.ID.factors.CreliabG2*gearbox.shaft.ID.material.uncorrected_enduranceG2;

gearbox.shaft.ID.factors.qG2 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.ID.factors.ktG2 = 0.97098*(0.05^(-0.21796)); %with r/d = 0.05, D/d = 1.2
gearbox.shaft.ID.factors.ktsG2 = 0.83425*(0.05^(-0.21649)); %with r/d = 0.05, D/d = 1.2

gearbox.shaft.ID.factors.kfG2 = 1 + gearbox.shaft.ID.factors.qG2*(gearbox.shaft.ID.factors.ktG2 - 1);
gearbox.shaft.ID.factors.kfsG2 = 1 + gearbox.shaft.ID.factors.qG2*(gearbox.shaft.ID.factors.ktsG2 - 1);

gearbox.shaft.ID.sigmaAG2 = gearbox.shaft.ID.factors.kfG2*sqrt((VBG2(2,1)*(gearbox.shaft.ID.dG2/2)/((pi*gearbox.shaft.ID.dG2^4)/64))^2+(VBG2(2,2)*(gearbox.shaft.ID.dG2/2)/((pi*gearbox.shaft.ID.dG2^4)/64))^2);
gearbox.shaft.ID.sigmaMG2 = gearbox.shaft.ID.sigmaAG2;
gearbox.shaft.ID.tauAG2 = gearbox.shaft.ID.factors.ktsG2*VBG2(3,1)*(gearbox.shaft.ID.dG2/2)/((pi*gearbox.shaft.ID.dG2^4)/32);
gearbox.shaft.ID.tauMG2 = gearbox.shaft.ID.tauAG2;

gearbox.shaft.ID.sigmaAG2_VM = sqrt(gearbox.shaft.ID.sigmaAG2^2 + 3*(gearbox.shaft.ID.tauAG2^2));
gearbox.shaft.ID.sigmaMG2_VM = sqrt(gearbox.shaft.ID.sigmaMG2^2 + 3*(gearbox.shaft.ID.tauMG2^2));

gearbox.shaft.ID.mod_safetyG2 = (gearbox.shaft.ID.material.enduranceG2*gearbox.shaft.ID.material.UTS)/((gearbox.shaft.ID.sigmaAG2_VM*gearbox.shaft.ID.material.UTS)+(gearbox.shaft.ID.material.enduranceG2*gearbox.shaft.ID.sigmaMG2_VM));

%% Diameter centerline P3 - 0.5D <x<length

VBP3 = ID_BM((gearbox.shaft.length+gearbox.shaft.geardist)*0.5-(gearbox.pinion3.geometry.facewidth*0.5),gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.F,gearbox.pinion3.loads.F,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);

gearbox.shaft.ID.material.uncorrected_enduranceP3 = 0.5*gearbox.shaft.ID.material.UTS;
gearbox.shaft.ID.factors.CloadP3 = 1; %torsion and bending
gearbox.shaft.ID.factors.CsizeP3 = 1; %assumed 1
gearbox.shaft.ID.factors.CsurfP3 = 2.7*(gearbox.shaft.ID.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.ID.factors.CtempP3 = 1;
gearbox.shaft.ID.factors.CreliabP3 = 0.868; %assume 90% reliability

gearbox.shaft.ID.material.enduranceP3 = gearbox.shaft.ID.factors.CloadP3*gearbox.shaft.ID.factors.CsizeP3*gearbox.shaft.ID.factors.CsurfP3*gearbox.shaft.ID.factors.CtempP3*gearbox.shaft.ID.factors.CreliabP3*gearbox.shaft.ID.material.uncorrected_enduranceP3;

gearbox.shaft.ID.factors.qP3 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.ID.factors.ktP3 = 3.5; %assuming at r/d = 0.021 at key
gearbox.shaft.ID.factors.ktsP3 = 2; %assuming

gearbox.shaft.ID.factors.kfP3 = 1 + gearbox.shaft.ID.factors.qP3*(gearbox.shaft.ID.factors.ktP3 - 1);
gearbox.shaft.ID.factors.kfsP3 = 1 + gearbox.shaft.ID.factors.qP3*(gearbox.shaft.ID.factors.ktsP3 - 1);
gearbox.shaft.ID.factors.safety = 2;

gearbox.shaft.ID.TMP3 = gearbox.shaft.ID.torsion(1); %fully reversed loading
gearbox.shaft.ID.MAP3 = sqrt(VBP3(2,1)^2 + VBP3(2,2)^2); 

gearbox.shaft.ID.dP3 = ((32*gearbox.shaft.ID.factors.safety/pi)*sqrt((gearbox.shaft.ID.factors.kfP3*gearbox.shaft.ID.MAP3/gearbox.shaft.ID.material.enduranceP3)^2+(3/4)*(gearbox.shaft.ID.factors.kfsP3*gearbox.shaft.ID.TMP3/gearbox.shaft.ID.material.UTS)^2))^(1/3);

gearbox.shaft.ID.dP3 = floor(gearbox.shaft.ID.dP3)+ceil((gearbox.shaft.ID.dP3-floor(gearbox.shaft.ID.dP3))/0.25)*0.25; %round up to next quarter

%% Recalculate safetly factor

gearbox.shaft.ID.material.uncorrected_enduranceP3 = 0.5*gearbox.shaft.ID.material.UTS;
gearbox.shaft.ID.factors.CloadP3 = 1; %torsion and bending
gearbox.shaft.ID.factors.CsizeP3 = 0.869*gearbox.shaft.ID.dP3^(-0.097);
gearbox.shaft.ID.factors.CsurfP3 = 2.7*(gearbox.shaft.ID.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.ID.factors.CtempP3 = 1;
gearbox.shaft.ID.factors.CreliabP1 = 0.868; %assume 90% reliability

gearbox.shaft.ID.material.enduranceP3 = gearbox.shaft.ID.factors.CloadP3*gearbox.shaft.ID.factors.CsizeP3*gearbox.shaft.ID.factors.CsurfP3*gearbox.shaft.ID.factors.CtempP3*gearbox.shaft.ID.factors.CreliabP3*gearbox.shaft.ID.material.uncorrected_enduranceP3;

gearbox.shaft.ID.factors.qP3 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.ID.factors.ktP3 = 0.97098*(0.05^(-0.21796)); %with r/d = 0.05, D/d = 1.2
gearbox.shaft.ID.factors.ktsP3 = 0.83425*(0.05^(-0.21649)); %with r/d = 0.05, D/d = 1.2

gearbox.shaft.ID.factors.kfP3 = 1 + gearbox.shaft.ID.factors.qP3*(gearbox.shaft.ID.factors.ktP3 - 1);
gearbox.shaft.ID.factors.kfsP3 = 1 + gearbox.shaft.ID.factors.qP3*(gearbox.shaft.ID.factors.ktsP3 - 1);

gearbox.shaft.ID.sigmaAP3 = gearbox.shaft.ID.factors.kfP3*sqrt((VBP3(2,1)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/64))^2+(VBP3(2,2)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/64))^2);
gearbox.shaft.ID.sigmaMP3 = gearbox.shaft.ID.sigmaAP3;
gearbox.shaft.ID.tauAP3 = gearbox.shaft.ID.factors.ktsP3*VBP3(3,1)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/32);
gearbox.shaft.ID.tauMP3 = gearbox.shaft.ID.tauAP3;
 
gearbox.shaft.ID.sigmaAP3_VM = sqrt(gearbox.shaft.ID.sigmaAP3^2 + 3*(gearbox.shaft.ID.tauAP3^2));
gearbox.shaft.ID.sigmaMP3_VM = sqrt(gearbox.shaft.ID.sigmaMP3^2 + 3*(gearbox.shaft.ID.tauMP3^2));
 
gearbox.shaft.ID.mod_safetyP3 = (gearbox.shaft.ID.material.enduranceP3*gearbox.shaft.ID.material.UTS)/((gearbox.shaft.ID.sigmaAP3_VM*gearbox.shaft.ID.material.UTS)+(gearbox.shaft.ID.material.enduranceP3*gearbox.shaft.ID.sigmaMP3_VM));

% %% Key Safety factor in shaft at G2
% 
% %Parallel key
% gearbox.shaft.ID.keyG2.length = 2.5; %in
% gearbox.shaft.ID.keyG2.width = 0.25; %in
% gearbox.shaft.ID.keyG2.height = 0.25; %in
% 
% 
% VBG2_left = ID_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5+1,gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.F,gearbox.pinion3.loads.F,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);
% 
% gearbox.shaft.ID.keyG2.factors.ktG2 = 2.2; %at standard r/d ratio of 0.021
% gearbox.shaft.ID.keyG2.factors.kts2 = 3; %at standard r/d ratio of 0.021
% gearbox.shaft.ID.keyG2.factors.qG2 = 0.67; %at r = 0.021 and figure 6-36
% 
% %Stress in Shear
% 
% gearbox.shaft.ID.keyG2.loads.FA = VBG2_left(3,1)/(gearbox.shaft.ID.dG2/2);
% gearbox.shaft.ID.keyG2.loads.FM = gearbox.shaft.ID.keyG2.loads.FA; %repeated loading
% gearbox.shaft.ID.keyG2.loads.TA = gearbox.shaft.ID.keyG2.loads.FA/(gearbox.shaft.ID.keyG2.width*gearbox.shaft.ID.keyG2.length);
% gearbox.shaft.ID.keyG2.loads.TM = gearbox.shaft.ID.keyG2.loads.TA; %repeated loading
% 
% gearbox.shaft.ID.keyG2.sigmaA = sqrt(3*(gearbox.shaft.ID.keyG2.loads.TA^2));
% gearbox.shaft.ID.keyG2.sigmaM = gearbox.shaft.ID.keyG2.sigmaA;
% 
% gearbox.shaft.ID.keyG2.shearsafety = 1/((gearbox.shaft.ID.keyG2.sigmaA/gearbox.shaft.ID.material.enduranceG2)+(gearbox.shaft.ID.keyG2.sigmaM/gearbox.shaft.ID.material.UTS));
% 
% %Stress in Bearing
% gearbox.shaft.ID.keyG2.sigmaMax = (gearbox.shaft.ID.keyG2.loads.FA + gearbox.shaft.ID.keyG2.loads.FM)/((gearbox.shaft.ID.keyG2.height/2)*gearbox.shaft.ID.keyG2.length);
% 
% gearbox.shaft.ID.keyG2.bearingsafety = gearbox.shaft.ID.material.yield/gearbox.shaft.ID.keyG2.sigmaMax;
% 
% %% Key Safety Factor in shaft at P3
% 
% %Parallel key
% gearbox.shaft.ID.keyP3.length = 2.5; %in
% gearbox.shaft.ID.keyP3.width = 0.25; %in
% gearbox.shaft.ID.keyP3.height = 0.25; %in
% 
% 
% VBP3_right = ID_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5+1,gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.F,gearbox.pinion3.loads.F,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);
% 
% gearbox.shaft.ID.keyG2.factors.ktG2 = 2.2; %at standard r/d ratio of 0.021
% gearbox.shaft.ID.keyG2.factors.kts2 = 3; %at standard r/d ratio of 0.021
% gearbox.shaft.ID.keyG2.factors.qG2 = 0.67; %at r = 0.021 and figure 6-36
% 
% %Stress in Shear
% 
% gearbox.shaft.ID.keyG2.loads.FA = gearbox.gear2.loads.T/(gearbox.shaft.ID.dG2/2);
% gearbox.shaft.ID.keyG2.loads.FM = gearbox.shaft.ID.keyG2.loads.FA; %repeated loading
% gearbox.shaft.ID.keyG2.loads.TA = gearbox.shaft.ID.keyG2.loads.FA/(gearbox.shaft.ID.keyG2.width*gearbox.shaft.ID.keyG2.length);
% gearbox.shaft.ID.keyG2.loads.TM = gearbox.shaft.ID.keyG2.loads.TA; %repeated loading
% 
% gearbox.shaft.ID.keyG2.sigmaA = sqrt(3*(gearbox.shaft.ID.keyG2.loads.TA^2));
% gearbox.shaft.ID.keyG2.sigmaM = gearbox.shaft.ID.keyG2.sigmaA;
% 
% gearbox.shaft.ID.keyG2.shearsafety = 1/((gearbox.shaft.ID.keyG2.sigmaA/gearbox.shaft.ID.material.enduranceG2)+(gearbox.shaft.ID.keyG2.sigmaM/gearbox.shaft.ID.material.UTS));
% 
% %Stress in Bearing
% gearbox.shaft.ID.keyG2.sigmaMax = (gearbox.shaft.ID.keyG2.loads.FA + gearbox.shaft.ID.keyG2.loads.FM)/((gearbox.shaft.ID.keyG2.height/2)*gearbox.shaft.ID.keyG2.length);
% 
% gearbox.shaft.ID.keyG2.bearingsafety = gearbox.shaft.ID.material.yield/gearbox.shaft.ID.keyG2.sigmaMax;

