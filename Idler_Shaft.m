%% Reaction Force Calculation

gearbox.shaft.ID.RLZ = ((-gearbox.gear2.geometry.position(1)/gearbox.shaft.length)*gearbox.gear2.loads.FW(3))+((-gearbox.pinion3.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion3.loads.FW(3));
gearbox.shaft.ID.RLY = ((-gearbox.gear2.geometry.position(1)/gearbox.shaft.length)*gearbox.gear2.loads.FW(2))+((-gearbox.pinion3.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion3.loads.FW(2));

gearbox.shaft.ID.ROZ = -gearbox.shaft.ID.RLZ-gearbox.gear2.loads.FW(3)-gearbox.pinion3.loads.FW(3);
gearbox.shaft.ID.ROY = -gearbox.shaft.ID.RLY-gearbox.gear2.loads.FW(2)-gearbox.pinion3.loads.FW(2);

gearbox.shaft.ID.torsion = [0,gearbox.pinion3.loads.T,gearbox.gear2.loads.T,0];

gearbox.shaft.ID.RY =[gearbox.shaft.ID.ROY gearbox.shaft.ID.RLY];
gearbox.shaft.ID.RZ =[gearbox.shaft.ID.ROZ gearbox.shaft.ID.RLZ];

%% Diameter 0<x<centerline of P2 + 0.5D

VBG2 = ID_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5+(gearbox.gear2.geometry.facewidth*0.5),gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.FW,gearbox.pinion3.loads.FW,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);

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
gearbox.shaft.ID.factors.ktG2 = 0.95684*(0.1^(-0.23513)); %with r/d = 0.1, D/d = 1.33 using linear interpolation
gearbox.shaft.ID.factors.ktsG2 = 0.84897*(0.1^(-0.23161)); %with r/d = 0.1, D/d = 1.33

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

VBP3 = ID_BM((gearbox.shaft.length+gearbox.shaft.geardist)*0.5-(gearbox.pinion3.geometry.facewidth*0.5),gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.FW,gearbox.pinion3.loads.FW,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);

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
gearbox.shaft.ID.factors.ktP3 = 0.95911*(0.1^(-0.22973)); %with r/d = 0.1, D/d = 1.14 using linear interpolation
gearbox.shaft.ID.factors.ktsP3 = 0.87195*(0.1^(-0.16763)); %with r/d = 0.1, D/d = 1.14 using linear interpolation

gearbox.shaft.ID.factors.kfP3 = 1 + gearbox.shaft.ID.factors.qP3*(gearbox.shaft.ID.factors.ktP3 - 1);
gearbox.shaft.ID.factors.kfsP3 = 1 + gearbox.shaft.ID.factors.qP3*(gearbox.shaft.ID.factors.ktsP3 - 1);

gearbox.shaft.ID.sigmaAP3 = gearbox.shaft.ID.factors.kfP3*sqrt((VBP3(2,1)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/64))^2+(VBP3(2,2)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/64))^2);
gearbox.shaft.ID.sigmaMP3 = gearbox.shaft.ID.sigmaAP3;
gearbox.shaft.ID.tauAP3 = gearbox.shaft.ID.factors.ktsP3*VBP3(3,1)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/32);
gearbox.shaft.ID.tauMP3 = gearbox.shaft.ID.tauAP3;
 
gearbox.shaft.ID.sigmaAP3_VM = sqrt(gearbox.shaft.ID.sigmaAP3^2 + 3*(gearbox.shaft.ID.tauAP3^2));
gearbox.shaft.ID.sigmaMP3_VM = sqrt(gearbox.shaft.ID.sigmaMP3^2 + 3*(gearbox.shaft.ID.tauMP3^2));
 
gearbox.shaft.ID.mod_safetyP3 = (gearbox.shaft.ID.material.enduranceP3*gearbox.shaft.ID.material.UTS)/((gearbox.shaft.ID.sigmaAP3_VM*gearbox.shaft.ID.material.UTS)+(gearbox.shaft.ID.material.enduranceP3*gearbox.shaft.ID.sigmaMP3_VM));

%% Key Safety factor in shaft at G2

gearbox.shaft.ID.keyG2.length = gearbox.gear2.geometry.facewidth + 0.5; %in
gearbox.shaft.ID.keyG2.width = 0.25; %in

VBG2_key = ID_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5-0.25,gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.FW,gearbox.pinion3.loads.FW,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);

gearbox.shaft.ID.keyG2.factors.ktG2 = 2.2; %at standard r/d ratio of 0.021
gearbox.shaft.ID.keyG2.factors.ktsG2 = 3; %at standard r/d ratio of 0.021
gearbox.shaft.ID.keyG2.factors.qG2 = 0.67; %at r = 0.021 and figure 6-36
gearbox.shaft.ID.keyG2.factors.kfG2 = 1 + gearbox.shaft.ID.keyG2.factors.qG2*(gearbox.shaft.ID.keyG2.factors.ktG2-1);
gearbox.shaft.ID.keyG2.factors.kfsG2 = 1 + gearbox.shaft.ID.keyG2.factors.qG2*(gearbox.shaft.ID.keyG2.factors.ktsG2-1);

gearbox.shaft.ID.keyG2.sigmaAG2 = gearbox.shaft.ID.keyG2.factors.kfG2*sqrt((VBG2_key(2,1)*(gearbox.shaft.ID.dG2/2)/((pi*gearbox.shaft.ID.dG2^4)/64))^2+(VBG2_key(2,2)*(gearbox.shaft.ID.dG2/2)/((pi*gearbox.shaft.ID.dG2^4)/64))^2);
gearbox.shaft.ID.keyG2.tauMG2 = gearbox.shaft.ID.keyG2.factors.ktsG2*VBG2_key(3,1)*(gearbox.shaft.ID.dG2/2)/((pi*gearbox.shaft.ID.dG2^4)/32);
 
gearbox.shaft.ID.keyG2.sigmaAG2_VM = gearbox.shaft.ID.sigmaAG2;
gearbox.shaft.ID.keyG2.sigmaMG2_VM = sqrt(3*(gearbox.shaft.ID.tauMG2^2));
 
gearbox.shaft.ID.keyG2.mod_safetyG2 = (gearbox.shaft.ID.material.enduranceG2*gearbox.shaft.ID.material.UTS)/((gearbox.shaft.ID.keyG2.sigmaAG2_VM*gearbox.shaft.ID.material.UTS)+(gearbox.shaft.ID.material.enduranceG2*gearbox.shaft.ID.keyG2.sigmaMG2_VM));

%% %% Key Safety factor in shaft at P3
 
gearbox.shaft.ID.keyP3.length = gearbox.pinion3.geometry.facewidth + 0.5; %in
gearbox.shaft.ID.keyP3.width = 0.25; %in
 
VBP3_key = ID_BM((gearbox.shaft.length+gearbox.shaft.geardist)*0.5+0.25,gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.FW,gearbox.pinion3.loads.FW,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);
 
gearbox.shaft.ID.keyP3.factors.ktP3 = 2.2; %at standard r/d ratio of 0.021
gearbox.shaft.ID.keyP3.factors.ktsP3 = 3; %at standard r/d ratio of 0.021
gearbox.shaft.ID.keyP3.factors.qP3 = 0.67; %at r = 0.021 and figure 6-36
gearbox.shaft.ID.keyP3.factors.kfP3 = 1 + gearbox.shaft.ID.keyP3.factors.qP3*(gearbox.shaft.ID.keyP3.factors.ktP3-1);
gearbox.shaft.ID.keyP3.factors.kfsP3 = 1 + gearbox.shaft.ID.keyP3.factors.qP3*(gearbox.shaft.ID.keyP3.factors.ktsP3-1);
 
gearbox.shaft.ID.keyP3.sigmaAP1 = gearbox.shaft.ID.keyP3.factors.kfP3*sqrt((VBP3_key(2,1)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/64))^2+(VBP3_key(2,2)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/64))^2);
gearbox.shaft.ID.keyP3.tauMP1 = gearbox.shaft.ID.keyP3.factors.ktsP3*VBP3_key(3,1)*(gearbox.shaft.ID.dP3/2)/((pi*gearbox.shaft.ID.dP3^4)/32);
 
gearbox.shaft.ID.keyP3.sigmaAP3_VM = gearbox.shaft.ID.sigmaAP3;
gearbox.shaft.ID.keyP3.sigmaMP3_VM = sqrt(3*(gearbox.shaft.ID.tauMP3^2));
 
gearbox.shaft.ID.keyP3.mod_safetyP3 = (gearbox.shaft.ID.material.enduranceP3*gearbox.shaft.ID.material.UTS)/((gearbox.shaft.ID.keyP3.sigmaAP3_VM*gearbox.shaft.ID.material.UTS)+(gearbox.shaft.ID.material.enduranceP3*gearbox.shaft.ID.keyP3.sigmaMP3_VM));

%% Keys In Idler Shaft

gearbox.shaft.ID.keyG2.shear = abs(gearbox.gear2.loads.T/(0.5*gearbox.shaft.ID.dG2))/(gearbox.shaft.ID.keyG2.length*gearbox.shaft.ID.keyG2.width);
gearbox.shaft.ID.keyP3.shear = abs(gearbox.pinion3.loads.T/(0.5*gearbox.shaft.ID.dP3))/(gearbox.shaft.ID.keyP3.length*gearbox.shaft.ID.keyP3.width);

%assume keys are square
gearbox.shaft.ID.keyG2.bearing = abs(gearbox.gear2.loads.T/(0.5*gearbox.shaft.ID.dG2))/(gearbox.shaft.ID.keyG2.length*gearbox.shaft.ID.keyG2.width*0.5);
gearbox.shaft.ID.keyP3.bearing = abs(gearbox.pinion3.loads.T/(0.5*gearbox.shaft.ID.dP3))/(gearbox.shaft.ID.keyP3.length*gearbox.shaft.ID.keyP3.width*0.5);

%Shear safety factor
gearbox.shaft.ID.keyG2.safety_shear = gearbox.shaft.ID.keyG2.material.UTS/sqrt(3*gearbox.shaft.ID.keyG2.shear^2); % since the shear is the mean, we use UTS
gearbox.shaft.ID.keyP3.safety_shear = gearbox.shaft.ID.keyP3.material.UTS/sqrt(3*gearbox.shaft.ID.keyP3.shear^2);

%Bearing Safety Factor
gearbox.shaft.ID.keyG2.safety_bearing = gearbox.shaft.ID.keyG2.material.yield/gearbox.shaft.ID.keyG2.bearing;
gearbox.shaft.ID.keyP3.safety_bearing = gearbox.shaft.ID.keyP3.material.yield/gearbox.shaft.ID.keyP3.bearing;
