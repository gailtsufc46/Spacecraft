function results = pointMassOrbit(params)
% results = pointMassOrbit(params)
%
% Written by Garrett Ailts
%
% Description: Function simulates a point mass in orbit around planet Earth
% using the J2 pertubation model. Only forces modeled are Earth gravity.
%
% Inputs:
%   params  -  struct containing the necessary simulation input parameters
%
% Outputs: 
%   results -  struct containing all the relevant results from the sim
%

%% Constants
deg2rad = pi/180;


%% Extract Necessary Parameters
% Sim
nOrbits = params.nOrbits;
absTol = params.absTol;
relTol = params.relTol;

% Earth
mu = params.Earth.mu_e;
R = params.Earth.Rmean; %#ok<NASGU>

% Orbit
a = params.sc.sma;
e = params.sc.ecc;
inc = params.sc.inc*deg2rad;

%% Find Initial Conditions for Point Mass in Orbit
OMEGA = 0; % assume perigee at equator with RAAN = 0;
omega = 0;
theta = 0;

[r,v,~] = orbEl2rv(a, e, theta, OMEGA, omega, inc, mu); % transform 
                                                        % orbital elements
                                                        % to pos. and vel.
x0 = [r; v];

%% Simulate 
options = odeset('AbsTol',absTol,'RelTol',relTol);

T = 2*pi*sqrt(a^3/mu);
tspan = [0 nOrbits*T];

[t,xout] = ode45(@(t,x) OrbDyn(t,x,params),tspan,x0,options);

%% Post Process Data
xout = xout';
Post_Process;
results.t = t;
results.xout = xout;
results.E = E;
results.x0 = x0;

%% Creat Plots
Plotter;



