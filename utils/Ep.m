function E = Ep(x,params)
% Usage: function E = Etot(x,params)
%
% Written by Garrett Ailts
%
% Description: Function takes in spacecraft state vector and parameters and
% returns the total energy of the spacecraft in the body centered inertial
% frame of the planetary body
%
% Inputs:
%   x       -  6 x 1 column matrix containing the position and velocity of the
%              spacecraft
%   params  -  struct containing all simulation and simulation object
%              parameters
%
% Outputs:
%   E  -  The total energy of the spacecraft (represented as a particle)
%

%% Extract Parameters
% Earth
mu = params.Earth.mu_e;
R = params.Earth.Rmean;
J2 = params.Earth.J2const;
J2on = params.J2on;

% Spacecraft
ms = params.sc.mWet;

%% Constants
r = norm(x(1:3));
I3 = [0 0 1]';

%% Calculate Total Energy
% Check for J2 inclusion
if ~J2on
    J2 = 0;
end
% Calculate energy
E = 0.5*ms*x(4:6)'*x(4:6)-mu*ms/r+(mu*ms*J2*R^2/r^3)*((3/2/r^2)* ...
                                                      (x(1:3)'*I3)^2-0.5);
                                                  





