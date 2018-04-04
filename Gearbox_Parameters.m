%% Input Parameters for configuration
gearbox.cycles = 1E9;
gearbox.shaft.length = 12; %in
gearbox.shaft.geardist = 6; %distance between centerline of gear (in)
gearbox.shaft.O1.geometry.length = 6;
gearbox.shaft.O2.geometry.length = 6;

%% Initial Angular Speed Rad/s
gearbox.pinion1.geometry.omega = 1455*(pi/30);
gearbox.gear1.geometry.omega = 365*(pi/30);
gearbox.pinion2.geometry.omega = 1455*(pi/30);
gearbox.gear2.geometry.omega = 400*(pi/30);
gearbox.pinion3.geometry.omega = 400*(pi/30);
gearbox.gear3.geometry.omega = 110*(pi/30);

%% Teeth Numbers
gearbox.pinion1.geometry.N = 18;
gearbox.gear1.geometry.N = round(gearbox.pinion1.geometry.N*(gearbox.pinion1.geometry.omega/gearbox.gear1.geometry.omega));
gearbox.pinion2.geometry.N = 18;
gearbox.gear2.geometry.N = round(gearbox.pinion2.geometry.N*(gearbox.pinion2.geometry.omega/gearbox.gear2.geometry.omega));
gearbox.pinion3.geometry.N = 18;
gearbox.gear3.geometry.N = round(gearbox.pinion3.geometry.N*(gearbox.pinion3.geometry.omega/gearbox.gear3.geometry.omega));

%% Updated Angular Speed 
gearbox.gear1.geometry.omega = (gearbox.pinion1.geometry.N/gearbox.gear1.geometry.N)*gearbox.pinion1.geometry.omega;
gearbox.gear2.geometry.omega = (gearbox.pinion2.geometry.N/gearbox.gear2.geometry.N)*gearbox.pinion2.geometry.omega;
gearbox.pinion3.geometry.omega = gearbox.gear2.geometry.omega;
gearbox.gear3.geometry.omega = (gearbox.pinion3.geometry.N/gearbox.gear3.geometry.N)*gearbox.pinion3.geometry.omega;

%% Pinion 1 Parameters
gearbox.pinion1.geometry.diametral_pitch = 4;
gearbox.pinion1.geometry.facewidth = 12/gearbox.pinion1.geometry.diametral_pitch;
gearbox.pinion1.geometry.pitchdiameter = gearbox.pinion1.geometry.N/gearbox.pinion1.geometry.diametral_pitch;
gearbox.pinion1.geometry.pressure_angle = 20;
gearbox.pinion1.geometry.position = [(gearbox.shaft.length+gearbox.shaft.geardist)*0.5;0;0];

%JIS S45C Steel
gearbox.pinion1.material.hardness = 197;
gearbox.pinion1.material.poissonratio = 0.29;
%gearbox.pinion1.material.elongation = 25;       %Elongation over 2 in
gearbox.pinion1.material.yieldstrenght = 66.7e3;
gearbox.pinion1.material.youngsmodulus = 29.7E6;
gearbox.pinion1.material.quality = 6;
gearbox.pinion1.material.density = 0.284;

%% Gear 1 Parameters
gearbox.gear1.geometry.diametral_pitch = 4;
gearbox.gear1.geometry.facewidth = 12/gearbox.gear1.geometry.diametral_pitch;
gearbox.gear1.geometry.pitchdiameter = gearbox.gear1.geometry.N/gearbox.gear1.geometry.diametral_pitch;
gearbox.gear1.geometry.pressure_angle = 20;
gearbox.gear1.geometry.position = [(gearbox.shaft.length+gearbox.shaft.geardist)*0.5;0;0];

gearbox.gear1.material.hardness = 197;
gearbox.gear1.material.poissonratio = 0.29;
%gearbox.gear1.material.elongation = 25;       %Elongation over 2 in
gearbox.gear1.material.yieldstrenght = 66.7e3;
gearbox.gear1.material.youngsmodulus = 29.7E6;
gearbox.gear1.material.quality = 6;
gearbox.gear1.material.density = 0.284;

%% Pinion 2 Parameters
gearbox.pinion2.geometry.diametral_pitch =4;
gearbox.pinion2.geometry.facewidth = 12/gearbox.pinion2.geometry.diametral_pitch;
gearbox.pinion2.geometry.pitchdiameter = gearbox.pinion2.geometry.N/gearbox.pinion2.geometry.diametral_pitch;
gearbox.pinion2.geometry.pressure_angle = 20;
gearbox.pinion2.geometry.position = [(gearbox.shaft.length-gearbox.shaft.geardist)*0.5;0;0];

gearbox.pinion2.material.hardness = 197;
gearbox.pinion2.material.poissonratio = 0.29;
%gearbox.pinion2.material.elongation = 25;       %Elongation over 2 in
gearbox.pinion2.material.yieldstrenght = 66.7e3;
gearbox.pinion2.material.youngsmodulus = 29.7E6;
gearbox.pinion2.material.quality = 6;
gearbox.pinion2.material.density = 0.284;

%% Gear 2 Parameters
gearbox.gear2.geometry.diametral_pitch = 4;
gearbox.gear2.geometry.facewidth = 12/gearbox.gear2.geometry.diametral_pitch;
gearbox.gear2.geometry.pitchdiameter = gearbox.gear2.geometry.N/gearbox.gear2.geometry.diametral_pitch;
gearbox.gear2.geometry.pressure_angle = 20;
gearbox.gear2.geometry.position = [(gearbox.shaft.length-gearbox.shaft.geardist)*0.5;0;0];

gearbox.gear2.material.hardness = 197;
gearbox.gear2.material.poissonratio = 0.29;
%gearbox.gear2.material.elongation = 25;       %Elongation over 2 in
gearbox.gear2.material.yieldstrenght = 66.7e3;
gearbox.gear2.material.youngsmodulus = 29.7E6;
gearbox.gear2.material.quality = 6;
gearbox.gear2.material.density = 0.284;

%% Pinion 3 Parameters
gearbox.pinion3.geometry.diametral_pitch = 3.25;
gearbox.pinion3.geometry.facewidth = 16/gearbox.pinion3.geometry.diametral_pitch;
gearbox.pinion3.geometry.pitchdiameter = gearbox.pinion3.geometry.N/gearbox.pinion3.geometry.diametral_pitch;
gearbox.pinion3.geometry.pressure_angle = 20;
gearbox.pinion3.geometry.position = [(gearbox.shaft.length+gearbox.shaft.geardist)*0.5;0;0];

gearbox.pinion3.material.hardness = 197;
gearbox.pinion3.material.poissonratio = 0.29;
%gearbox.pinion3.material.elongation = 25;       %Elongation over 2 in
gearbox.pinion3.material.yieldstrenght = 66.7e3;
gearbox.pinion3.material.youngsmodulus = 29.7E6;
gearbox.pinion3.material.quality = 6;
gearbox.pinion3.material.density = 0.284;

%% Gear 3 Parameters
gearbox.gear3.geometry.diametral_pitch = 3.25;
gearbox.gear3.geometry.facewidth = 16/gearbox.gear3.geometry.diametral_pitch;
gearbox.gear3.geometry.pitchdiameter = gearbox.gear3.geometry.N/gearbox.gear3.geometry.diametral_pitch;
gearbox.gear3.geometry.pressure_angle = 20;
gearbox.gear3.geometry.position = [(gearbox.shaft.length+gearbox.shaft.geardist)*0.5;0;0];

gearbox.gear3.material.hardness = 197;
gearbox.gear3.material.poissonratio = 0.29;
%gearbox.gear3.material.elongation = 25;       %Elongation over 2 in
gearbox.gear3.material.yieldstrenght = 66.7e3;
gearbox.gear3.material.youngsmodulus = 29.7E6; %psi
gearbox.gear3.material.quality = 6;
gearbox.gear3.material.density = 0.284;

%% Input Shaft

%for carbon steel 1045 cold rolled
gearbox.shaft.IN.material.yield = 77e3; %psi
gearbox.shaft.IN.material.UTS = 91e3; %psi

%% Key material for Input shaft

%AISI 1010 steel
gearbox.shaft.IN.keyP2.material.UTS = 47e3;
gearbox.shaft.IN.keyP2.material.yield = 26e3;
gearbox.shaft.IN.keyP1.material.UTS = 47e3;
gearbox.shaft.IN.keyP1.material.yield = 26e3;

