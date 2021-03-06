%% Shafts 
clc
Gearbox_Parameters;
Forces_Torques;

% %% Input Shaft
% 
% syms Rby Rbz
% gearbox.shaft.IN.bearing2.loads.F = [0; Rby; Rbz];
% gearbox.shaft.IN.bearing2.geometry.position = [gearbox.shaft.length; 0; 0];
% 
% eqn = cross(gearbox.pinion2.geometry.position, gearbox.pinion2.loads.FW) + cross(gearbox.pinion1.geometry.position, gearbox.pinion1.loads.FW) ... 
%             + cross(gearbox.shaft.IN.bearing2.loads.F, gearbox.shaft.IN.bearing2.geometry.position) == 0;
% [solRby,solRbz] = solve(eqn);
% 
% gearbox.shaft.IN.bearing2.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];
% 
% syms Ray Raz
% gearbox.shaft.IN.bearing1.loads.F = [0; Ray; Raz];
% gearbox.shaft.IN.bearing1.geometry.position = [0; 0; 0];
% 
% eqn = gearbox.pinion1.loads.FW + gearbox.pinion2.loads.FW + gearbox.shaft.IN.bearing2.loads.F + gearbox.shaft.IN.bearing1.loads.F == 0;
% [solRay,solRaz] = solve(eqn);
% 
% gearbox.shaft.IN.bearing1.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];

%% Idler Shaft

syms Rby Rbz

gearbox.shaft.ID.bearing2.loads.F = [0; Rby; Rbz];
gearbox.shaft.ID.bearing2.geometry.position = [gearbox.shaft.length; 0; 0];

eqn = cross(gearbox.gear2.geometry.position, gearbox.gear2.loads.FW) + cross(gearbox.pinion3.geometry.position, gearbox.pinion3.loads.FW)+ cross(gearbox.shaft.ID.bearing2.loads.F, gearbox.shaft.ID.bearing2.geometry.position) == 0;
[solRby,solRbz] = solve(eqn);

gearbox.shaft.ID.bearing2.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];

syms Ray Raz
gearbox.shaft.ID.bearing1.loads.F = [0; Ray; Raz];
gearbox.shaft.ID.bearing1.geometry.position = [0; 0; 0];

eqn2 = gearbox.gear2.loads.FW + gearbox.pinion3.loads.FW + gearbox.shaft.ID.bearing2.loads.F + gearbox.shaft.ID.bearing1.loads.F == 0;
[solRay,solRaz] = solve(eqn2);

gearbox.shaft.ID.bearing1.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];

%% Output Shaft 1

syms Rby Rbz

gearbox.shaft.O1.bearing2.loads.F = [0; Rby; Rbz];
gearbox.shaft.O1.bearing2.geometry.position = [gearbox.shaft.O1.geometry.length; 0; 0];

eqn = cross(gearbox.gear1.geometry.position, gearbox.gear1.loads.FW) + cross(gearbox.shaft.O1.bearing2.geometry.position, gearbox.shaft.O1.bearing2.loads.F) == 0;
[solRby,solRbz] = solve(eqn);

gearbox.shaft.O1.bearing2.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];

syms Ray Raz
gearbox.shaft.O1.bearing1.loads.F = [0; Ray; Raz];
gearbox.shaft.O1.bearing1.geometry.position = [0; 0; 0];

eqn = gearbox.gear1.loads.FW + gearbox.shaft.O1.bearing2.loads.F + gearbox.shaft.O1.bearing1.loads.F == 0;
[solRay,solRaz] = solve(eqn);

gearbox.shaft.O1.bearing1.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];

%% Output 2

syms Rby Rbz

gearbox.shaft.O2.bearing2.loads.F = [0; Rby; Rbz];
gearbox.shaft.O2.bearing2.geometry.position = [gearbox.shaft.O2.geometry.length; 0; 0];

eqn = cross(gearbox.gear3.geometry.position, gearbox.gear3.loads.FW) + cross(gearbox.shaft.O2.bearing2.geometry.position, gearbox.shaft.O2.bearing2.loads.F) == 0;
[solRby,solRbz] = solve(eqn);

gearbox.shaft.O2.bearing2.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];

syms Ray Raz
gearbox.shaft.O2.bearing1.loads.F = [0; Ray; Raz];
gearbox.shaft.O2.bearing1.position = [0; 0; 0];

eqn = gearbox.gear3.loads.FW + gearbox.shaft.O2.bearing2.loads.F + gearbox.shaft.O2.bearing1.loads.F == 0;
[solRay,solRaz] = solve(eqn);

gearbox.shaft.O2.bearing1.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];


