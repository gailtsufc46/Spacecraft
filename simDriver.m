%% Simulation Driver
% AEM 4305: Spacecraft Attiude Dynamics and Control
% Written by Garrett Ailts

clear all, close all %#ok<CLALL>

%% Add Directories to Path
addpath(genpath('utils/'));
addpath(genpath('utils/Provided_Functions/'));
addpath(genpath('utils/Jacchia_Bowman_Model'));
addpath(genpath('utils/Jacchia_70'));
addpath(genpath('sims/'));
addpath(genpath('params/'));
addpath(genpath('figs/'));
addpath(genpath('docs/'));
addpath(genpath('data/'));
addpath(genpath('models/'));

%% Choose Simulation
simType = input('Which simulation would you like to run?\n','s');
tstart = now;
params = struct();
sc = struct();
Earth = struct();

% Choose parameter files
simPfile = 'simParams.txt';
scPfile = 'scParams.txt';
earthPfile = 'earthParams.txt';

% Load params to objects
params = loadParams(simPfile,params);
sc = loadParams(scPfile,sc);
Earth = loadParams(earthPfile,Earth);
params.Earth = Earth; 


params.sc = sc;
%% Run Simulation
if strcmp(simType, 'Get Params')
    params = getParams(params);
    results = 'Params Test';
end
if strcmp(simType,'Point Mass Orbit')
    results = pointMassOrbit(params);
end
if strcmp(simType,'Attitude Sim')
    results = AttitudeSim(params);
end
if strcmp(simType,'Coupled Dynamics Sim')
    params.atm_model = 0;
    results = SpacecraftSim(params);
end
if strcmp(simType,'Main Sim')
    results = MainSim(params);
end
if strcmp(simType,'CF Sim')
    results = CFSim(params);
end
if strcmp(simType,'Detumble Sim')
    results = detumbleSim(params);
end
if strcmp(simType,'Orbit Fab Sim')
    results = OrbitFabSim(params);
end
if strcmp(simType,'Orbit Fab Sim v2')
    results = OrbitFabSimv2(params);
end


%% Save Results
for lv1 = 1:100
    sname = sprintf('sim%d',lv1);
    if ~exist(sname,'file')
        fname = sprintf('data/output/sim%d.mat',lv1);
        save(fname,'results');
        break;
    end
end
tend = now;
telapsed = (tend-tstart)*86400;
fprintf("Elapsed time for the simulation is %.1f\n",telapsed);


