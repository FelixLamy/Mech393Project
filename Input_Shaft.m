Gearbox_Parameters;
Forces_Torques;

%% Reaction Force Calculation

gearbox.shaft.IN.RLZ = ((-gearbox.pinion2.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion2.loads.F(3))+((-gearbox.pinion1.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion1.loads.F(3));
gearbox.shaft.IN.RLY = ((-gearbox.pinion2.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion2.loads.F(2))+((-gearbox.pinion1.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion1.loads.F(2));

gearbox.shaft.IN.ROZ = -gearbox.shaft.IN.RLZ-gearbox.pinion2.loads.F(3)-gearbox.pinion1.loads.F(3);
gearbox.shaft.IN.ROY = -gearbox.shaft.IN.RLY-gearbox.pinion2.loads.F(2)-gearbox.pinion1.loads.F(2);
gearbox.shaft.IN.torsion = [gearbox.pinion1.loads.T+gearbox.pinion2.loads.T,gearbox.pinion1.loads.T,0];

%% Diameter 0<x<(gearbox.shaft.length-gearbox.shaft.geardist)*0.5

VB1 = IN_BM((gearbox.shaft.length-gearbox.shaft.geardist)*0.5,gearbox.pinion2.geometry.position(1),gearbox.pinion1.geometry.position(1),gearbox.shaft.length,gearbox.pinion2.loads.F,gearbox.pinion1.loads.F,gearbox.shaft.IN.ROY,gearbox.shaft.IN.ROZ,gearbox.shaft.IN.RLY,gearbox.shaft.IN.RLZ,gearbox.shaft.IN.torsion)

gearbox.shaft.IN.material.uncorrected_endurance = 0.5*gearbox.shaft.IN.material.UTS;
gearbox.shaft.IN.factors.Cload1 = 1; %torsion and bending
gearbox.shaft.IN.factors.Csize1 = 1; %assumed 1
gearbox.shaft.IN.factors.Csurf1 = 2.7*(gearbox.shaft.IN.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.IN.factors.Ctemp1 = 1;
gearbox.shaft.IN.factors.Creliab1 = 0.868; %assume 90% reliability

gearbox.shaft.IN.material.endurance1 = gearbox.shaft.IN.factors.Cload1*gearbox.shaft.IN.factors.Csize1*gearbox.shaft.IN.factors.Csurf1*gearbox.shaft.IN.factors.Ctemp1*gearbox.shaft.IN.factors.Creliab1*gearbox.shaft.IN.material.uncorrected_endurance;

gearbox.shaft.IN.factors.q1 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.IN.factors.kt1 = 2; %assuming
gearbox.shaft.IN.factors.kts1 = 1.5; %assuming

gearbox.shaft.IN.factors.kf1 = 1 + gearbox.shaft.IN.factors.q*(gearbox.shaft.IN.factors.kt - 1);
gearbox.shaft.IN.factors.kfs1 = 1 + gearbox.shaft.IN.factors.q*(gearbox.shaft.IN.factors.kts - 1);
gearbox.shaft.IN.factors.safety = 2;

gearbox.shaft.IN.TM1 = gearbox.shaft.IN.torsion(1);
gearbox.shaft.IN.MA1 = sqrt(VB1(2,1)^2 + VB1(2,2)^2);

gearbox.shaft.IN.d1 = ((32*gearbox.shaft.IN.factors.safety/pi)*((gearbox.shaft.IN.factors.kf1*gearbox.shaft.IN.MA1/gearbox.shaft.IN.material.endurance1)^2+(3/4)*( gearbox.shaft.IN.factors.kfs1*gearbox.shaft.IN.TM1/gearbox.shaft.IN.material.yield)^2)^(1/2))^(1/3);

gearbox.shaft.IN.d1 = floor(gearbox.shaft.IN.d1)+ceil((gearbox.shaft.IN.d1-floor(gearbox.shaft.IN.d1))/0.25)*0.25;

%% Recalculate safetly factor

gearbox.shaft.IN.material.uncorrected_endurance = 0.5*gearbox.shaft.IN.material.UTS;
gearbox.shaft.IN.factors.Cload1 = 1; %torsion and bending
gearbox.shaft.IN.factors.Csize1 = 0.869*gearbox.shaft.IN.d1^(-0.097); %assumed 1
gearbox.shaft.IN.factors.Csurf1 = 2.7*(gearbox.shaft.IN.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.IN.factors.Ctemp1 = 1;
gearbox.shaft.IN.factors.Creliab1 = 0.868; %assume 90% reliability

gearbox.shaft.IN.material.endurance1 = gearbox.shaft.IN.factors.Cload1*gearbox.shaft.IN.factors.Csize1*gearbox.shaft.IN.factors.Csurf1*gearbox.shaft.IN.factors.Ctemp1*gearbox.shaft.IN.factors.Creliab1*gearbox.shaft.IN.material.uncorrected_endurance;

gearbox.shaft.IN.factors.q1 = 0.75; %assuming notch radius of 0.05 in
gearbox.shaft.IN.factors.kt1 = 0.97098*(0.05^(-0.21796)); %with r/d = 0.05, D/d = 1.2
gearbox.shaft.IN.factors.kts1 = 0.83425*(0.05^(-0.21649)); %with r/d = 0.05, D/d = 1.2

gearbox.shaft.IN.factors.kf1 = 1 + gearbox.shaft.IN.factors.q*(gearbox.shaft.IN.factors.kt - 1);
gearbox.shaft.IN.factors.kfs1 = 1 + gearbox.shaft.IN.factors.q*(gearbox.shaft.IN.factors.kts - 1);

gearbox.shaft.IN.sigmaA = gearbox.shaft.IN.factors.kf1*sqrt((VB1(2,1)*(gearbox.shaft.IN.d1/2)/((pi*gearbox.shaft.IN.d1^4)/64))^2+(VB1(2,2)*(gearbox.shaft.IN.d1/2)/((pi*gearbox.shaft.IN.d1^4)/64))^2);
gearbox.shaft.IN.tauM = gearbox.shaft.IN.factors.kts1*VB1(3,1)*(gearbox.shaft.IN.d1/2)/((pi*gearbox.shaft.IN.d1^4)/32);

gearbox.shaft.IN.mod_safety = ((gearbox.shaft.IN.tauM/gearbox.shaft.IN.material.UTS)+(gearbox.shaft.IN.sigmaA/gearbox.shaft.IN.material.endurance1))^(-1);

%% Diameter (gearbox.shaft.length-gearbox.shaft.geardist)*0.5<x<length

VB2 = IN_BM((gearbox.shaft.length+gearbox.shaft.geardist)*0.5,gearbox.pinion2.geometry.position(1),gearbox.pinion1.geometry.position(1),gearbox.shaft.length,gearbox.pinion2.loads.F,gearbox.pinion1.loads.F,gearbox.shaft.IN.ROY,gearbox.shaft.IN.ROZ,gearbox.shaft.IN.RLY,gearbox.shaft.IN.RLZ,gearbox.shaft.IN.torsion)

gearbox.shaft.IN.material.uncorrected_endurance = 0.5*gearbox.shaft.IN.material.UTS;
gearbox.shaft.IN.factors.Cload = 1; %torsion and bending
gearbox.shaft.IN.factors.Csize = 1; %assumed 1
gearbox.shaft.IN.factors.Csurf = 2.7*(gearbox.shaft.IN.material.UTS/(1e3))^(-.265); %cold rolled
gearbox.shaft.IN.factors.Ctemp = 1;
gearbox.shaft.IN.factors.Creliab = 0.868; %assume 90% reliability

gearbox.shaft.IN.material.endurance = gearbox.shaft.IN.factors.Cload*gearbox.shaft.IN.factors.Csize*gearbox.shaft.IN.factors.Csurf*gearbox.shaft.IN.factors.Ctemp*gearbox.shaft.IN.factors.Creliab*gearbox.shaft.IN.material.uncorrected_endurance;

gearbox.shaft.IN.factors.qb = 0.6; %assuming notch radius of 0.01 in
gearbox.shaft.IN.factors.qt = 0.57; %assuming notch radius of 0.01 in
gearbox.shaft.IN.factors.kt = 2.2; %assuming at r/d = 0.021 at key
gearbox.shaft.IN.factors.kts = 3; %assuming

gearbox.shaft.IN.factors.kf = 1 + gearbox.shaft.IN.factors.qb*(gearbox.shaft.IN.factors.kt - 1);
gearbox.shaft.IN.factors.kfs = 1 + gearbox.shaft.IN.factors.qt*(gearbox.shaft.IN.factors.kts - 1);
gearbox.shaft.IN.factors.safety = 2;

gearbox.shaft.IN.TM = gearbox.shaft.IN.torsion(3);
gearbox.shaft.IN.MA = sqrt(VB2(2,1)^2 + VB2(2,2)^2);

gearbox.shaft.IN.d3 = ((32*gearbox.shaft.IN.factors.safety/pi)*((gearbox.shaft.IN.factors.kf*gearbox.shaft.IN.MA/gearbox.shaft.IN.material.endurance)^2+(3/4)*( gearbox.shaft.IN.factors.kfs*gearbox.shaft.IN.TM/gearbox.shaft.IN.material.yield)^2)^(1/2))^(1/3);

gearbox.shaft.IN.d3 = floor(gearbox.shaft.IN.d1)+ceil((gearbox.shaft.IN.d1-floor(gearbox.shaft.IN.d1))/0.25)*0.25;