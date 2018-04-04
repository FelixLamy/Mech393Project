Gearbox_Parameters;
Forces_Torques;

%% Reaction Force Calculation

gearbox.shaft.IN.RLZ = ((-gearbox.pinion2.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion2.loads.F(3))+((-gearbox.pinion1.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion1.loads.F(3));
gearbox.shaft.IN.RLY = ((-gearbox.pinion2.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion2.loads.F(2))+((-gearbox.pinion1.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion1.loads.F(2));

gearbox.shaft.IN.ROZ = -gearbox.shaft.IN.RLZ-gearbox.pinion2.loads.F(3)-gearbox.pinion1.loads.F(3);
gearbox.shaft.IN.ROY = -gearbox.shaft.IN.RLY-gearbox.pinion2.loads.F(2)-gearbox.pinion1.loads.F(2);
gearbox.shaft.IN.torsion = [gearbox.pinion1.loads.T+gearbox.pinion2.loads.T,gearbox.pinion1.loads.T,0];

%% Diameter 0<x<centerline of P2 + 0.5D

VBP2 = IN_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5+(gearbox.pinion1.geometry.facewidth*0.5),gearbox.pinion2.geometry.position(1),gearbox.pinion1.geometry.position(1),gearbox.shaft.length,gearbox.pinion2.loads.F,gearbox.pinion1.loads.F,gearbox.shaft.IN.ROY,gearbox.shaft.IN.ROZ,gearbox.shaft.IN.RLY,gearbox.shaft.IN.RLZ,gearbox.shaft.IN.torsion);

gearbox.shaft.IN.material.uncorrected_enduranceP2 = 0.5*gearbox.shaft.IN.material.UTS;
gearbox.shaft.IN.factors.CloadP2 = 1; %torsion and bending
gearbox.shaft.IN.factors.CsizeP2 = 1; %assumed 1
gearbox.shaft.IN.factors.CsurfP2 = 2.7*(gearbox.shaft.IN.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.IN.factors.CtempP2 = 1;
gearbox.shaft.IN.factors.CreliabP2 = 0.868; %assume 90% reliability

gearbox.shaft.IN.material.enduranceP2 = gearbox.shaft.IN.factors.CloadP2*gearbox.shaft.IN.factors.CsizeP2*gearbox.shaft.IN.factors.CsurfP2*gearbox.shaft.IN.factors.CtempP2*gearbox.shaft.IN.factors.CreliabP2*gearbox.shaft.IN.material.uncorrected_enduranceP2;

gearbox.shaft.IN.factors.qP2 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.IN.factors.ktP2 = 3.5; %assuming
gearbox.shaft.IN.factors.ktsP2 = 2; %assuming

gearbox.shaft.IN.factors.kfP2 = 1 + gearbox.shaft.IN.factors.qP2*(gearbox.shaft.IN.factors.ktP2 - 1);
gearbox.shaft.IN.factors.kfsP2 = 1 + gearbox.shaft.IN.factors.qP2*(gearbox.shaft.IN.factors.ktsP2 - 1);
gearbox.shaft.IN.factors.safety = 2;

gearbox.shaft.IN.TMP2 = gearbox.shaft.IN.torsion(1)/2;
gearbox.shaft.IN.TAP2 = gearbox.shaft.IN.TMP2; %repeated loading
gearbox.shaft.IN.MMP2 = sqrt(VBP2(2,1)^2 + VBP2(2,2)^2)/2;
gearbox.shaft.IN.MAP2 = gearbox.shaft.IN.MMP2; %repeated loading

gearbox.shaft.IN.dP2 = ((32*gearbox.shaft.IN.factors.safety/pi)*((sqrt(((gearbox.shaft.IN.factors.kfP2*gearbox.shaft.IN.MAP2)^2)+((3/4)*(gearbox.shaft.IN.factors.kfsP2* gearbox.shaft.IN.TAP2)^2))/gearbox.shaft.IN.material.enduranceP2) + (sqrt(((gearbox.shaft.IN.factors.kfP2*gearbox.shaft.IN.MMP2)^2)+((3/4)*(gearbox.shaft.IN.factors.kfsP2* gearbox.shaft.IN.TMP2)^2))/gearbox.shaft.IN.material.UTS)))^(1/3);

gearbox.shaft.IN.dP2 = floor(gearbox.shaft.IN.dP2)+ceil((gearbox.shaft.IN.dP2-floor(gearbox.shaft.IN.dP2))/0.25)*0.25; %round up to next quarter

%% Recalculate safetly factor

gearbox.shaft.IN.material.uncorrected_enduranceP2 = 0.5*gearbox.shaft.IN.material.UTS;
gearbox.shaft.IN.factors.CloadP2 = 1; %torsion and bending
gearbox.shaft.IN.factors.CsizeP2 = 0.869*gearbox.shaft.IN.dP2^(-0.097);
gearbox.shaft.IN.factors.CsurfP2 = 2.7*(gearbox.shaft.IN.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.IN.factors.CtempP2 = 1;
gearbox.shaft.IN.factors.CreliabP2 = 0.868; %assume 90% reliability

gearbox.shaft.IN.material.enduranceP2 = gearbox.shaft.IN.factors.CloadP2*gearbox.shaft.IN.factors.CsizeP2*gearbox.shaft.IN.factors.CsurfP2*gearbox.shaft.IN.factors.CtempP2*gearbox.shaft.IN.factors.CreliabP2*gearbox.shaft.IN.material.uncorrected_enduranceP2;

gearbox.shaft.IN.factors.qP2 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.IN.factors.ktP2 = 0.97098*(0.05^(-0.21796)); %with r/d = 0.05, D/d = 1.2
gearbox.shaft.IN.factors.ktsP2 = 0.83425*(0.05^(-0.21649)); %with r/d = 0.05, D/d = 1.2

gearbox.shaft.IN.factors.kfP2 = 1 + gearbox.shaft.IN.factors.qP2*(gearbox.shaft.IN.factors.ktP2 - 1);
gearbox.shaft.IN.factors.kfsP2 = 1 + gearbox.shaft.IN.factors.qP2*(gearbox.shaft.IN.factors.ktsP2 - 1);

gearbox.shaft.IN.sigmaAP2 = gearbox.shaft.IN.factors.kfP2*sqrt((VBP2(2,1)*(gearbox.shaft.IN.dP2/2)/((pi*gearbox.shaft.IN.dP2^4)/64))^2+(VBP2(2,2)*(gearbox.shaft.IN.dP2/2)/((pi*gearbox.shaft.IN.dP2^4)/64))^2);
gearbox.shaft.IN.sigmaMP2 = gearbox.shaft.IN.sigmaAP2;
gearbox.shaft.IN.tauAP2 = gearbox.shaft.IN.factors.ktsP2*VBP2(3,1)*(gearbox.shaft.IN.dP2/2)/((pi*gearbox.shaft.IN.dP2^4)/32);
gearbox.shaft.IN.tauMP2 = gearbox.shaft.IN.tauAP2;

gearbox.shaft.IN.sigmaAP2_VM = sqrt(gearbox.shaft.IN.sigmaAP2^2 + 3*(gearbox.shaft.IN.tauAP2^2));
gearbox.shaft.IN.sigmaMP2_VM = sqrt(gearbox.shaft.IN.sigmaMP2^2 + 3*(gearbox.shaft.IN.tauMP2^2));

gearbox.shaft.IN.mod_safetyP2 = (gearbox.shaft.IN.material.enduranceP2*gearbox.shaft.IN.material.UTS)/((gearbox.shaft.IN.sigmaAP2_VM*gearbox.shaft.IN.material.UTS)+(gearbox.shaft.IN.material.enduranceP2*gearbox.shaft.IN.sigmaMP2_VM));

%% Diameter centerline P1 - 0.5D <x<length

VBP1 = IN_BM((gearbox.shaft.length+gearbox.shaft.geardist)*0.5-(gearbox.pinion1.geometry.facewidth*0.5),gearbox.pinion2.geometry.position(1),gearbox.pinion1.geometry.position(1),gearbox.shaft.length,gearbox.pinion2.loads.F,gearbox.pinion1.loads.F,gearbox.shaft.IN.ROY,gearbox.shaft.IN.ROZ,gearbox.shaft.IN.RLY,gearbox.shaft.IN.RLZ,gearbox.shaft.IN.torsion);

gearbox.shaft.IN.material.uncorrected_enduranceP1 = 0.5*gearbox.shaft.IN.material.UTS;
gearbox.shaft.IN.factors.CloadP1 = 1; %torsion and bending
gearbox.shaft.IN.factors.CsizeP1 = 1; %assumed 1
gearbox.shaft.IN.factors.CsurfP1 = 2.7*(gearbox.shaft.IN.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.IN.factors.CtempP1 = 1;
gearbox.shaft.IN.factors.CreliabP1 = 0.868; %assume 90% reliability

gearbox.shaft.IN.material.enduranceP1 = gearbox.shaft.IN.factors.CloadP1*gearbox.shaft.IN.factors.CsizeP1*gearbox.shaft.IN.factors.CsurfP1*gearbox.shaft.IN.factors.CtempP1*gearbox.shaft.IN.factors.CreliabP1*gearbox.shaft.IN.material.uncorrected_enduranceP1;

gearbox.shaft.IN.factors.qP1 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.IN.factors.ktP1 = 3.5; %assuming at r/d = 0.021 at key
gearbox.shaft.IN.factors.ktsP1 = 2; %assuming

gearbox.shaft.IN.factors.kfP1 = 1 + gearbox.shaft.IN.factors.qP1*(gearbox.shaft.IN.factors.ktP1 - 1);
gearbox.shaft.IN.factors.kfsP1 = 1 + gearbox.shaft.IN.factors.qP1*(gearbox.shaft.IN.factors.ktsP1 - 1);
gearbox.shaft.IN.factors.safety = 2;

gearbox.shaft.IN.TMP1 = gearbox.shaft.IN.torsion(1)/2;
gearbox.shaft.IN.TAP1 = gearbox.shaft.IN.TMP1; %repeated loading
gearbox.shaft.IN.MMP1 = sqrt(VBP1(2,1)^2 + VBP1(2,2)^2)/2;
gearbox.shaft.IN.MAP1 = gearbox.shaft.IN.MMP1; %repeated loading
 
gearbox.shaft.IN.dP1 = ((32*gearbox.shaft.IN.factors.safety/pi)*((sqrt(((gearbox.shaft.IN.factors.kfP1*gearbox.shaft.IN.MAP1)^2)+((3/4)*(gearbox.shaft.IN.factors.kfsP1* gearbox.shaft.IN.TAP1)^2))/gearbox.shaft.IN.material.enduranceP1) + (sqrt(((gearbox.shaft.IN.factors.kfP1*gearbox.shaft.IN.MMP1)^2)+((3/4)*(gearbox.shaft.IN.factors.kfsP1* gearbox.shaft.IN.TMP1)^2))/gearbox.shaft.IN.material.UTS)))^(1/3);

gearbox.shaft.IN.dP1 = floor(gearbox.shaft.IN.dP1)+ceil((gearbox.shaft.IN.dP1-floor(gearbox.shaft.IN.dP1))/0.25)*0.25;

%% Recalculate safetly factor

gearbox.shaft.IN.material.uncorrected_enduranceP1 = 0.5*gearbox.shaft.IN.material.UTS;
gearbox.shaft.IN.factors.CloadP1 = 1; %torsion and bending
gearbox.shaft.IN.factors.CsizeP1 = 0.869*gearbox.shaft.IN.dP1^(-0.097);
gearbox.shaft.IN.factors.CsurfP1 = 2.7*(gearbox.shaft.IN.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.IN.factors.CtempP1 = 1;
gearbox.shaft.IN.factors.CreliabP1 = 0.868; %assume 90% reliability

gearbox.shaft.IN.material.enduranceP1 = gearbox.shaft.IN.factors.CloadP1*gearbox.shaft.IN.factors.CsizeP1*gearbox.shaft.IN.factors.CsurfP1*gearbox.shaft.IN.factors.CtempP1*gearbox.shaft.IN.factors.CreliabP1*gearbox.shaft.IN.material.uncorrected_enduranceP1;

gearbox.shaft.IN.factors.qP1 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.IN.factors.ktP1 = 0.97098*(0.05^(-0.21796)); %with r/d = 0.05, D/d = 1.2
gearbox.shaft.IN.factors.ktsP1 = 0.83425*(0.05^(-0.21649)); %with r/d = 0.05, D/d = 1.2

gearbox.shaft.IN.factors.kfP1 = 1 + gearbox.shaft.IN.factors.qP1*(gearbox.shaft.IN.factors.ktP1 - 1);
gearbox.shaft.IN.factors.kfsP1 = 1 + gearbox.shaft.IN.factors.qP1*(gearbox.shaft.IN.factors.ktsP1 - 1);

gearbox.shaft.IN.sigmaAP1 = gearbox.shaft.IN.factors.kfP1*sqrt((VBP1(2,1)*(gearbox.shaft.IN.dP1/2)/((pi*gearbox.shaft.IN.dP1^4)/64))^2+(VBP1(2,2)*(gearbox.shaft.IN.dP1/2)/((pi*gearbox.shaft.IN.dP1^4)/64))^2);
gearbox.shaft.IN.sigmaMP1 = gearbox.shaft.IN.sigmaAP1;
gearbox.shaft.IN.tauAP1 = gearbox.shaft.IN.factors.ktsP1*VBP1(3,1)*(gearbox.shaft.IN.dP1/2)/((pi*gearbox.shaft.IN.dP1^4)/32);
gearbox.shaft.IN.tauMP1 = gearbox.shaft.IN.tauAP1;
 
gearbox.shaft.IN.sigmaAP1_VM = sqrt(gearbox.shaft.IN.sigmaAP1^2 + 3*(gearbox.shaft.IN.tauAP1^2));
gearbox.shaft.IN.sigmaMP1_VM = sqrt(gearbox.shaft.IN.sigmaMP1^2 + 3*(gearbox.shaft.IN.tauMP1^2));
 
gearbox.shaft.IN.mod_safetyP1 = (gearbox.shaft.IN.material.enduranceP1*gearbox.shaft.IN.material.UTS)/((gearbox.shaft.IN.sigmaAP1_VM*gearbox.shaft.IN.material.UTS)+(gearbox.shaft.IN.material.enduranceP1*gearbox.shaft.IN.sigmaMP1_VM));

%% Key Safety factor in shaft at P2

gearbox.shaft.IN.keyP2.length = 2.5; %in
gearbox.shaft.IN.keyP2.width = 0.25; %in

VBP2_left = IN_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5+1,gearbox.pinion2.geometry.position(1),gearbox.pinion1.geometry.position(1),gearbox.shaft.length,gearbox.pinion2.loads.F,gearbox.pinion1.loads.F,gearbox.shaft.IN.ROY,gearbox.shaft.IN.ROZ,gearbox.shaft.IN.RLY,gearbox.shaft.IN.RLZ,gearbox.shaft.IN.torsion);

gearbox.shaft.IN.keyP2.factors.ktP2 = 2.2; %at standard r/d ratio of 0.021
gearbox.shaft.IN.keyP2.factors.ktsP2 = 3; %at standard r/d ratio of 0.021
gearbox.shaft.IN.keyP2.factors.qP2 = 0.67; %at r = 0.021 and figure 6-36

gearbox.shaft.IN.sigmaAP1 = gearbox.shaft.IN.factors.kfP1*sqrt((VBP1(2,1)*(gearbox.shaft.IN.dP1/2)/((pi*gearbox.shaft.IN.dP1^4)/64))^2+(VBP1(2,2)*(gearbox.shaft.IN.dP1/2)/((pi*gearbox.shaft.IN.dP1^4)/64))^2);
