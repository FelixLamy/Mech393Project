clear all
clc
Gearbox_Parameters;
Forces_Torques;

syms Rby Rbz
gearbox.bearing2.geometry.loads.F = [0; Rby; Rbz];
gearbox.bearing2.geometry.position = [8; 0; 0];

eqn = cross(gearbox.pinion2.geometry.position, gearbox.pinion2.loads.F) + cross(gearbox.pinion1.geometry.position, gearbox.pinion1.loads.F) + cross(gearbox.bearing2.geometry.loads.F, gearbox.bearing2.geometry.position) == 0;
[solRby,solRbz] = solve(eqn);
disp(vpa(solRbz));
disp(vpa(solRby));

gearbox.bearing2.geometry.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];