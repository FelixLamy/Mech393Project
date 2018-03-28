clear all
clc
%% Shafts 
Gearbox_Parameters;
Forces_Torques;

%% Input Shaft

syms Rby Rbz
gearbox.bearing2.input.loads.F = [0; Rby; Rbz];
gearbox.bearing2.input.position = [8; 0; 0];

eqn = cross(gearbox.pinion2.geometry.position, gearbox.pinion2.loads.F) + cross(gearbox.pinion1.geometry.position, gearbox.pinion1.loads.F) + cross(gearbox.bearing2.input.loads.F, gearbox.bearing2.input.position) == 0;
[solRby,solRbz] = solve(eqn);

gearbox.bearing2.input.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];

syms Ray Raz
gearbox.bearing1.input.loads.F = [0; Ray; Raz];
gearbox.bearing1.input.position = [0; 0; 0];

eqn = gearbox.pinion1.loads.F + gearbox.pinion2.loads.F + gearbox.bearing2.input.loads.F + gearbox.bearing1.input.loads.F == 0;
[solRay,solRaz] = solve(eqn);

gearbox.bearing1.input.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];

%% Intermediate Shaft

syms Rby Rbz
gearbox.bearing2.intermediate.loads.F = [0; Rby; Rbz];
gearbox.bearing2.intermediate.position = [8; 0; 0];

eqn = cross(gearbox.gear2.geometry.position, gearbox.gear2.loads.F) + cross(gearbox.pinion3.geometry.position, gearbox.pinion3.loads.F) + cross(gearbox.bearing2.intermediate.loads.F, gearbox.bearing2.intermediate.position) == 0;
[solRby,solRbz] = solve(eqn);

gearbox.bearing2.intermediate.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];

syms Ray Raz
gearbox.bearing1.intermediate.loads.F = [0; Ray; Raz];
gearbox.bearing1.intermediate.position = [0; 0; 0];

eqn = gearbox.gear2.loads.F + gearbox.pinion3.loads.F + gearbox.bearing2.intermediate.loads.F + gearbox.bearing1.intermediate.loads.F == 0;
[solRay,solRaz] = solve(eqn);

gearbox.bearing1.intermediate.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];

%% Output Shaft 1

syms Rby Rbz
gearbox.bearing2.output1.loads.F = [0; Rby; Rbz];
gearbox.bearing2.output1.position = [8; 0; 0];

eqn = cross(gearbox.gear1.geometry.position, gearbox.gear1.loads.F) + cross(gearbox.bearing2.output1.position, gearbox.bearing2.output1.loads.F) == 0;
[solRby,solRbz] = solve(eqn);

gearbox.bearing2.output1.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];

syms Ray Raz
gearbox.bearing1.output1.loads.F = [0; Ray; Raz];
gearbox.bearing1.output1.position = [0; 0; 0];

eqn = gearbox.gear1.loads.F + gearbox.bearing2.output1.loads.F + gearbox.bearing1.output1.loads.F == 0;
[solRay,solRaz] = solve(eqn);

gearbox.bearing1.output1.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];

%% Output 2

syms Rby Rbz
gearbox.bearing2.output2.loads.F = [0; Rby; Rbz];
gearbox.bearing2.output2.position = [8; 0; 0];

eqn = cross(gearbox.gear3.geometry.position, gearbox.gear3.loads.F) + cross(gearbox.bearing2.output2.position, gearbox.bearing2.output2.loads.F) == 0;
[solRby,solRbz] = solve(eqn);

gearbox.bearing2.output2.loads.F = [0; double((vpa(solRby))); double((vpa(solRbz)))];

syms Ray Raz
gearbox.bearing1.output2.loads.F = [0; Ray; Raz];
gearbox.bearing1.output2.position = [0; 0; 0];

eqn = gearbox.gear3.loads.F + gearbox.bearing2.output2.loads.F + gearbox.bearing1.output2.loads.F == 0;
[solRay,solRaz] = solve(eqn);

gearbox.bearing1.output2.loads.F = [0; double((vpa(solRay))); double((vpa(solRaz)))];

% disp(gearbox.bearing1.input.loads.F)
% disp(gearbox.bearing2.input.loads.F)
% disp(gearbox.bearing1.intermediate.loads.F)
% disp(gearbox.bearing2.intermediate.loads.F)
% disp(gearbox.bearing1.output1.loads.F)
% disp(gearbox.bearing2.output1.loads.F)
% disp(gearbox.bearing1.output2.loads.F)
% disp(gearbox.bearing2.output2.loads.F)