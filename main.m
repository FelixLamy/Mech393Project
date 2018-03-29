clear all
clc

Gearbox_Parameters
Forces_Torques
Surface_Gears
Tooth_Bending


fprintf('--------------------------------- \n')
fprintf('Pitch Diameters\n')
fprintf('Pinion 1: %f\n', gearbox.pinion1.geometry.pitchdiameter)
fprintf('Gear 1: %f\n', gearbox.gear1.geometry.pitchdiameter)
fprintf('Pinion 2: %f\n', gearbox.pinion2.geometry.pitchdiameter)
fprintf('Gear 2: %f\n', gearbox.gear2.geometry.pitchdiameter)
fprintf('Pinion 3: %f\n', gearbox.pinion3.geometry.pitchdiameter)
fprintf('Gear 3: %f\n', gearbox.gear3.geometry.pitchdiameter)
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
