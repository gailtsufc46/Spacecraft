function xdot = OrbDyn(t,x,params) %#ok<INUSL>
% Usage: [t,xout] = ode45(@(t,x) OrbDyn(t,x,params),tspan,x0,options);
%
% Written by Garrett Ailts
%
% Descritpion: Orbital Equations of motion assuming point mass under
% gravity force from a point mass where mp>>ms
%
% Inputs:
%   x       -  6 x 1 column matrix of position and velocity values
%   params  -  struct of values and constants needed for computation of
%              rates of change
% 
% Outputs:
%   xdot  -  6 x 1 vector of the instantaneous rates of change of the input
%            state vector (velocity and acceleration)
%
%

%% Extract Parameters from Struct
mu = params.Earth.mu_e;
R = params.Earth.Rmean;
J2 = params.Earth.J2const;
J2on = params.J2on;

%% Define Useful Constants
I3 = [0 0 1]';


%% Check for Earth Impact
r = norm(x(1:3));
if r<=R
    warning('Earth impact!')
end

%% Assemble Rate of Change Matrix
% Check For J2 Inclusion
if ~J2on
    J2 = 0;
end
% Calculate xdot    
xdot = [x(4:6); -mu*x(1:3)/r^3 + (3*mu*J2*R^2/2/r^5)*(((5/r^2)* ... 
                               (x(1:3)'*I3)-1)*x(1:3)-2*(x(1:3)'*I3)*I3)];





