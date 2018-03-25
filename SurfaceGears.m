%%Surface Stress and Surface Strength for Mesh 1 and 2 in Gearbox Configuration
cycles = 1E9; %life of gears

Ca = 1.25; %application factor - uniform electric motor with moderate shock gears
Cm1 = 1.7; %load distribution factor according to a facewidth of 2.4 in. in mesh 1
Cm2 = 1.7; %load distribution factor according to a facewidth of 2.4 in. in mesh 2clk
Cf = 1; %surface factor - well finished, conventional methods
Cs = 1.25; %size factor - conservative
Cl = 1.4488*(cycles)^-0.023; %life factor
Cr = 1; %reliability factor, assumed to be 99%
Ct = 1; %temperature factor, assumed to be operating under 250 fahrenheit

%%Factors above are common to all gears in set

%Face width - common to all gears in set
F1 = gearbox.pinion1.geometry.facewidth;
F2 = gearbox.pinion2.geometry.facewidth;

%Transmitted Load - common to all gears in set
Wt = gearbox.pinion1.loads.T/(gearbox.pinion1.geometry.pitchdiameter/2);

%Elastic Coefficient - both pinions have same material properties as both
%gears in meshes
Cp = sqrt(1/(2*pi*(1-(gearbox.pinion1.material.poissonratio)^2)/gearbox.pinion1.material.youngsmodulus));

%Dynamic Factor - common to all gears in set
Vt = gearbox.pinion1.geometry.pitchdiameter*gearbox.pinion1.geometry.omega*(30/12);
B = (12-gearbox.pinion1.material.quality)^(2/3)/4;
A = 50 + 56*(1-B);
Cv = (A/(A+sqrt(Vt)))^B;

%Hardness Ratio Factor (Mesh 1)
if gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness < 1.2
    A1 = 0;
    
else if gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness >= 1.2 && gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness <= 1.7
    A1 = 0.00898*(gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness)-0.00829;
    
    else gearbox.pinion1.material.hardness/gearbox.gear1.material.hardness > 1.7;
    A1 = 0.00698;
    
    end
end 

Ch1 = 1 + A1*(gearbox.gear1.geometry.pitchdiameter/gearbox.pinion1.geometry.pitchdiameter - 1);

%Radius of Curvature (Mesh 1)
mesh2.rho1 = sqrt((gearbox.pinion1.geometry.pitchdiameter/2+1/gearbox.pinion1.geometry.diametral_pitch)^2-(gearbox.pinion1.geometry.pitchdiameter/2*cos(gearbox.pinion1.geometry.pressure_angle))^2)-pi*cos(gearbox.pinion1.geometry.pressure_angle)/gearbox.pinion1.geometry.diametral_pitch;
mesh2.rho2 = (gearbox.pinion1.geometry.pitchdiameter/2 + gearbox.gear1.geometry.pitchdiameter/2)*sin(gearbox.pinion1.geometry.pressure_angle)-mesh2.rho1;

%Pitting Geometry Factor (Mesh 1)
I1 = cos(gearbox.pinion1.geometry.pressure_angle)/((1/mesh2.rho1 + 1/mesh2.rho2)*gearbox.pinion1.geometry.pitchdiameter);

%Surface Stress on Pinion-Gear (Mesh 1)
p1.surfstress = Cp*sqrt(Wt*Ca*Cm1*Cs*Cf/(F1*I1*gearbox.pinion1.geometry.pitchdiameter*Cv));

%Surface Strength on Pinion1 and Gear 1 (Mesh 1)
p1.uncorrectSfc = 327*(gearbox.pinion1.material.hardness)+26000;
p1.correctSfc = Cl*Ch1*p2.uncorrectSfc/(Ct*Cr);
g1.uncorrectSfc = 327*(gearbox.gear1.material.hardness)+26000;
g1.correctSfc = Cl*Ch1*p2.uncorrectSfc/(Ct*Cr);

%Surface Safety Factor Pinion (Mesh 1)
N.surface.pinion1.mesh1 = p1.correctSfc/p1.surfstress;
N.surface.gear1.mesh1 = g1.correctSfc/p1.surfstress;

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

%Radius of Curvature (Mesh 2)
mesh2.rho1 = sqrt((gearbox.pinion2.geometry.pitchdiameter/2+1/gearbox.pinion2.geometry.diametral_pitch)^2-(gearbox.pinion2.geometry.pitchdiameter/2*cos(gearbox.pinion2.geometry.pressure_angle))^2)-pi*cos(gearbox.pinion2.geometry.pressure_angle)/gearbox.pinion2.geometry.diametral_pitch;
mesh2.rho2 = (gearbox.pinion2.geometry.pitchdiameter/2 + gearbox.gear2.geometry.pitchdiameter/2)*sin(gearbox.pinion2.geometry.pressure_angle)-mesh2.rho1;

%Pitting Geometry Factor (Mesh 2)
I2 = cos(gearbox.pinion2.geometry.pressure_angle)/((1/mesh2.rho1 + 1/mesh2.rho2)*gearbox.pinion2.geometry.pitchdiameter);

%Surface Stress on Pinion-Gear (Mesh 2)
p2.surfstress = Cp*sqrt(Wt*Ca*Cm2*Cs*Cf/(F2*I2*gearbox.pinion2.geometry.pitchdiameter*Cv));

%Surface Strength on Pinion1 (Mesh 2)
p2.uncorrectSfc = 327*(gearbox.pinion2.material.hardness)+26000;
p2.correctSfc = Cl*Ch2*p2.uncorrectSfc/(Ct*Cr);
g2.uncorrectSfc = 327*(gearbox.gear2.material.hardness)+26000;
g2.correctSfc = Cl*Ch2*g2.uncorrectSfc/(Ct*Cr);

%Surface Safety Factor Pinion-Gear (Mesh 2)
N.surface.pinion2.mesh2 = p2.correctSfc/p2.surfstress;
N.surface.gear2.mesh2 = g2.correctSfc/p2.surfstress;

disp('Surface Factor of Safety for Pinion 1 Mesh 1:')
disp(N.surface.pinion1.mesh1)
disp('Surface Factor of Safety for Gear 1 Mesh 1:')
disp(N.surface.gear1.mesh1)
disp('Surface Factor of Safety for Pinion 2 Mesh 2:')
disp(N.surface.pinion2.mesh2)
disp('Surface Factor of Safety for Gear 2 Mesh 2:')
disp(N.surface.gear2.mesh2)





