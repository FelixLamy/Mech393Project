%%Surface Stress and Surface Strength for Mesh 1 and 2 in Gearbox Configuration

%Inputs required to calculate surface stress and strength
Gearbox_Parameters;
Forces_Torques;
Tooth_Bending;

cycles = 1E9; %life of gears

Ca = 1.25; %application factor - uniform electric motor with moderate shock gears
Cm1 = gearbox.pinion1.tooth_bending.Km; %load distribution factor according to a facewidth in mesh 1
Cm2 = gearbox.pinion2.tooth_bending.Km; %load distribution factor according to a facewidth in mesh 2
Cm3 = gearbox.pinion3.tooth_bending.Km; %load distribution factor according to a facewidth in mesh 3
Cf = 1; %surface factor - well finished, conventional methods
Cs = 1.25; %size factor - conservative
Cl = 1.4488*(cycles)^-0.023; %life factor
Cr = 1; %reliability factor, assumed to be 99%
Ct = 1; %temperature factor, assumed to be operating under 250 fahrenheit

%Face width - common to all gears in set
F1 = gearbox.pinion1.geometry.facewidth;
F2 = gearbox.pinion2.geometry.facewidth;
F3 = gearbox.pinion3.geometry.facewidth;

%Elastic Coefficient - all pinions have same material properties as both
%gears in meshes
Cp = sqrt(1/(2*pi*(1-(gearbox.pinion1.material.poissonratio)^2)/gearbox.pinion1.material.youngsmodulus));

%Dynamic Factor - common to all gears in set
Vt = gearbox.pinion1.geometry.pitchdiameter*gearbox.pinion1.geometry.omega*2.5;
B = (12-gearbox.pinion1.material.quality)^(2/3)/4;
A = 50 + 56*(1-B);
Cv = (A/(A+sqrt(Vt)))^B;

%% Mesh 1

%Hardness Ratio Factor
if gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness < 1.2
    A1 = 0;
    
else if gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness >= 1.2 && gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness <= 1.7
    A1 = 0.00898*(gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness)-0.00829;
    
    else gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness > 1.7;
    A1 = 0.00698;
    
    end
end 

Ch1 = 1 + A1*(gearbox.gear1.geometry.pitchdiameter/gearbox.pinion1.geometry.pitchdiameter - 1);

%Radius of Curvature 
mesh1.rho1 = sqrt((gearbox.pinion1.geometry.pitchdiameter/2+1/gearbox.pinion1.geometry.diametral_pitch)^2-(gearbox.pinion1.geometry.pitchdiameter/2*cos(gearbox.pinion1.geometry.pressure_angle))^2)-pi*cos(gearbox.pinion1.geometry.pressure_angle)/gearbox.pinion1.geometry.diametral_pitch;
mesh1.rho2 = (gearbox.pinion1.geometry.pitchdiameter/2 + gearbox.gear1.geometry.pitchdiameter/2)*sin(gearbox.pinion1.geometry.pressure_angle)-mesh1.rho1;

%Pitting Geometry Factor 
I1 = cos(gearbox.pinion1.geometry.pressure_angle)/((1/mesh1.rho1 + 1/mesh1.rho2)*gearbox.pinion1.geometry.pitchdiameter);

%Surface Stress on Pinion-Gear 
p1.surfstress = Cp*sqrt(gearbox.pinion1.loads.tang_F*Ca*Cm1*Cs*Cf/(F1*I1*gearbox.pinion1.geometry.pitchdiameter*Cv));

%Surface Strength on Pinion1 and Gear 1 
p1.uncorrectSfc = 327*(gearbox.pinion1.material.hardness)+26000;
p1.correctSfc = Cl*Ch1*p1.uncorrectSfc/(Ct*Cr);

%Surface Safety Factor Pinion 
N.surface.pinion1.mesh1 = (p1.correctSfc/p1.surfstress)^2;

%% Mesh 2

%Hardness Ratio Factor (Mesh 2)
if gearbox.pinion2.material.hardness/gearbox.gear2.material.hardness < 1.2
    A2 = 0;
    
else if gearbox.pinion2.material.hardness/gearbox.gear2.material.hardness >= 1.2 && gearbox.pinion2.material.hardness/gearbox.gear2.material.hardness <= 1.7
    A2 = 0.00898*(gearbox.pinion2.material.hardness/gearbox.gear2.material.hardness)-0.00829;
    
    else gearbox.pinion2.material.hardness/gearbox.gear2.material.hardness > 1.7;
    A2 = 0.00698;
    
    end
end 

Ch2 = 1 + A2*(gearbox.gear2.geometry.pitchdiameter/gearbox.pinion2.geometry.pitchdiameter - 1);

%Radius of Curvature 
mesh2.rho1 = sqrt((gearbox.pinion2.geometry.pitchdiameter/2+1/gearbox.pinion2.geometry.diametral_pitch)^2-(gearbox.pinion2.geometry.pitchdiameter/2*cos(gearbox.pinion2.geometry.pressure_angle))^2)-pi*cos(gearbox.pinion2.geometry.pressure_angle)/gearbox.pinion2.geometry.diametral_pitch;
mesh2.rho2 = (gearbox.pinion2.geometry.pitchdiameter/2 + gearbox.gear2.geometry.pitchdiameter/2)*sin(gearbox.pinion2.geometry.pressure_angle)-mesh2.rho1;

%Pitting Geometry Factor 
I2 = cos(gearbox.pinion2.geometry.pressure_angle)/((1/mesh2.rho1 + 1/mesh2.rho2)*gearbox.pinion2.geometry.pitchdiameter);

%Surface Stress on Pinion-Gear 
p2.surfstress = Cp*sqrt(gearbox.pinion2.loads.tang_F*Ca*Cm2*Cs*Cf/(F2*I2*gearbox.pinion2.geometry.pitchdiameter*Cv));

%Surface Strength on Pinion1
p2.uncorrectSfc = 327*(gearbox.pinion2.material.hardness)+26000;
p2.correctSfc = Cl*Ch2*p2.uncorrectSfc/(Ct*Cr);

%Surface Safety Factor Pinion-Gear 
N.surface.pinion2.mesh2 = (p2.correctSfc/p2.surfstress)^2;

%% Mesh 3

%Hardness Ratio Factor (Mesh 3)
if gearbox.pinion3.material.hardness/gearbox.gear3.material.hardness < 1.2
    A3 = 0;
    
else if gearbox.pinion3.material.hardness/gearbox.gear3.material.hardness >= 1.2 && gearbox.pinion3.material.hardness/gearbox.gear3.material.hardness <= 1.7
    A3 = 0.00898*(gearbox.pinion3.material.hardness/gearbox.gear3.material.hardness)-0.00829;
    
    else gearbox.pinion3.material.hardness/gearbox.gear3.material.hardness > 1.7;
    A3 = 0.00698;
    
    end
end 

Ch3 = 1 + A3*(gearbox.gear3.geometry.pitchdiameter/gearbox.pinion3.geometry.pitchdiameter - 1);

%Radius of Curvature
mesh3.rho1 = sqrt((gearbox.pinion3.geometry.pitchdiameter/2+1/gearbox.pinion3.geometry.diametral_pitch)^2-(gearbox.pinion3.geometry.pitchdiameter/2*cos(gearbox.pinion3.geometry.pressure_angle))^2)-pi*cos(gearbox.pinion3.geometry.pressure_angle)/gearbox.pinion3.geometry.diametral_pitch;
mesh3.rho2 = (gearbox.pinion3.geometry.pitchdiameter/2 + gearbox.gear3.geometry.pitchdiameter/2)*sin(gearbox.pinion3.geometry.pressure_angle)-mesh3.rho1;

%Pitting Geometry Factor
I3 = cos(gearbox.pinion3.geometry.pressure_angle)/((1/mesh3.rho1 + 1/mesh3.rho2)*gearbox.pinion3.geometry.pitchdiameter);

%Surface Stress on Pinion-Gear 
p3.surfstress = Cp*sqrt(gearbox.pinion3.loads.tang_F*Ca*Cm3*Cs*Cf/(F3*I3*gearbox.pinion3.geometry.pitchdiameter*Cv));

%Surface Strength on Pinion1 
p3.uncorrectSfc = 327*(gearbox.pinion3.material.hardness)+26000;
p3.correctSfc = Cl*Ch3*p3.uncorrectSfc/(Ct*Cr);

%Surface Safety Factor Pinion-Gear 
N.surface.pinion3.mesh3 = (p3.correctSfc/p3.surfstress)^2;