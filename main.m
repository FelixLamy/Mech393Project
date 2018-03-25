clear all
clc

Gearbox_Parameters
Forces_Torques
% SurfaceGears
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

fprintf('Face Width\n')
fprintf('Pinion 1: %f\n', gearbox.pinion1.geometry.facewidth)
fprintf('Gear 1: %f\n', gearbox.gear1.geometry.facewidth)
fprintf('Pinion 2: %f\n', gearbox.pinion2.geometry.facewidth)
fprintf('Gear 2: %f\n', gearbox.gear2.geometry.facewidth)
fprintf('Pinion 3: %f\n', gearbox.pinion3.geometry.facewidth)
fprintf('Gear 3: %f\n', gearbox.gear3.geometry.facewidth)
fprintf('--------------------------------- \n')

fprintf('Tooth Bending Safety Factor\n')
fprintf('Pinion 1: %f\n', gearbox.pinion1.tooth_bending.safetyfactor)
fprintf('Gear 1: %f\n', gearbox.gear1.tooth_bending.safetyfactor)
fprintf('Pinion 2: %f\n', gearbox.pinion2.tooth_bending.safetyfactor)
fprintf('Gear 2: %f\n', gearbox.gear2.tooth_bending.safetyfactor)
fprintf('Pinion 3: %f\n', gearbox.pinion3.tooth_bending.safetyfactor)
fprintf('Gear 3: %f\n', gearbox.gear3.tooth_bending.safetyfactor)