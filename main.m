clear all
clc

Gearbox_Parameters
Forces_Torques
Tooth_Bending
Surface_Gears
Shafts
Input_Shaft
Idler_Shaft
Output_Shaft_1;
Output_Shaft_2;

fprintf('--------------------------------- \n')
fprintf('Pitch Diameters\n')
fprintf('Pinion 1: %f\n', gearbox.pinion1.geometry.pitchdiameter)
fprintf('Gear 1: %f\n', gearbox.gear1.geometry.pitchdiameter)
fprintf('Pinion 2: %f\n', gearbox.pinion2.geometry.pitchdiameter)
fprintf('Gear 2: %f\n', gearbox.gear2.geometry.pitchdiameter)
fprintf('Pinion 3: %f\n', gearbox.pinion3.geometry.pitchdiameter)
fprintf('Gear 3: %f\n', gearbox.gear3.geometry.pitchdiameter)

fprintf('--------------------------------- \n')
fprintf('Face Width\n')
fprintf('Pinion 1: %f\n', gearbox.pinion1.geometry.facewidth)
fprintf('Gear 1: %f\n', gearbox.gear1.geometry.facewidth)
fprintf('Pinion 2: %f\n', gearbox.pinion2.geometry.facewidth)
fprintf('Gear 2: %f\n', gearbox.gear2.geometry.facewidth)
fprintf('Pinion 3: %f\n', gearbox.pinion3.geometry.facewidth)
fprintf('Gear 3: %f\n', gearbox.gear3.geometry.facewidth)

fprintf('--------------------------------- \n')
fprintf('--------------------------------- \n')
fprintf('Tooth Bending Safety Factor\n')
fprintf('Pinion 1: %f\n', gearbox.pinion1.tooth_bending.safetyfactor)
fprintf('Gear 1: %f\n', gearbox.gear1.tooth_bending.safetyfactor)
fprintf('Pinion 2: %f\n', gearbox.pinion2.tooth_bending.safetyfactor)
fprintf('Gear 2: %f\n', gearbox.gear2.tooth_bending.safetyfactor)
fprintf('Pinion 3: %f\n', gearbox.pinion3.tooth_bending.safetyfactor)
fprintf('Gear 3: %f\n', gearbox.gear3.tooth_bending.safetyfactor)

fprintf('--------------------------------- \n')
fprintf('Surface Safety Factor\n')
fprintf('Mesh 1: %f\n', N.surface.pinion1.mesh1)
fprintf('Mesh 2: %f\n', N.surface.pinion2.mesh2)
fprintf('Mesh 3: %f\n', N.surface.pinion3.mesh3)

fprintf('--------------------------------- \n')
fprintf('--------------------------------- \n')
fprintf('Input Shaft Diameter\n')
fprintf('Pinion 2: %f\n', gearbox.shaft.IN.dP2)
fprintf('Pinion 1: %f\n', gearbox.shaft.IN.dP1)

fprintf('--------------------------------- \n')
fprintf('Input Shaft Safety Factor\n')
fprintf('Pinion 2: %f\n', gearbox.shaft.IN.mod_safetyP2)
fprintf('Pinion 1: %f\n', gearbox.shaft.IN.mod_safetyP1)

fprintf('--------------------------------- \n')
fprintf('Key Safety Factors in Input Shaft\n')
fprintf('Pinion 2 Bearing: %f\n', gearbox.shaft.IN.keyP2.safety_bearing)
fprintf('Pinion 1 Bearing: %f\n', gearbox.shaft.IN.keyP1.safety_bearing)
fprintf('Pinion 2 Shear: %f\n', gearbox.shaft.IN.keyP2.safety_shear)
fprintf('Pinion 1 Shear: %f\n', gearbox.shaft.IN.keyP1.safety_shear)

fprintf('--------------------------------- \n')
fprintf('Keyseat Safety Factors in Idler Shaft\n')
fprintf('Pinion 2: %f\n', gearbox.shaft.IN.keyP2.mod_safetyP2)
fprintf('Pinion 1 : %f\n', gearbox.shaft.IN.keyP1.mod_safetyP1)

fprintf('--------------------------------- \n')
fprintf('--------------------------------- \n')
fprintf('Idler Shaft Diameter\n')
fprintf('Gear 2: %f\n', gearbox.shaft.ID.dG2)
fprintf('Pinion 3: %f\n', gearbox.shaft.ID.dP3)

fprintf('--------------------------------- \n')
fprintf('Idler Shaft Safety Factor\n')
fprintf('Gear 2: %f\n', gearbox.shaft.ID.mod_safetyG2)
fprintf('Pinion 3: %f\n', gearbox.shaft.ID.mod_safetyP3)

fprintf('--------------------------------- \n')
fprintf('Key Safety Factors in Idler Shaft\n')
fprintf('Gear 2 Bearing: %f\n', gearbox.shaft.ID.keyG2.safety_bearing)
fprintf('Pinion 3 Bearing: %f\n', gearbox.shaft.ID.keyP3.safety_bearing)
fprintf('Gear 2 Shear: %f\n', gearbox.shaft.ID.keyG2.safety_shear)
fprintf('Pinion 3 Shear: %f\n', gearbox.shaft.ID.keyP3.safety_shear)

fprintf('--------------------------------- \n')
fprintf('Keyseat Safety Factors in Idler Shaft\n')
fprintf('Gear 2: %f\n', gearbox.shaft.ID.keyG2.mod_safetyG2)
fprintf('Pinion 3 : %f\n', gearbox.shaft.ID.keyP3.mod_safetyP3)

fprintf('--------------------------------- \n')
fprintf('--------------------------------- \n')
fprintf('Output Shaft 1 Diameter\n')
fprintf('Gear 1: %f\n', gearbox.shaft.O1.dP1)
fprintf('Safety Factor: %f\n', gearbox.shaft.O1.mod_safetyP1)

fprintf('--------------------------------- \n')
fprintf('--------------------------------- \n')
fprintf('Output Shaft 2 Diameter\n')
fprintf('Gear 3: %f\n', gearbox.shaft.O2.dP1)
fprintf('Safety Factor: %f\n', gearbox.shaft.O2.mod_safetyP1)





