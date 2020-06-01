function [r, v, h] = orbEl2rv(a, e, theta, OMEGA, omega, inc, mu)
% Written by Garrett Ailts
%
% Usage: [r, v, h] = orbEl2rv(a, e, theta, OMEGA, omega, inc, mu)
%
% Description: Function takes a set of six keplerian orbital elements
% and computes the position and velocity vectors in the ECI frame. The
% specific angular momentum is also returned as an output.
%
% Inputs: a - semi major axis (km)
%         e - eccentricity (norm of evec)
%     theta - true anomaly (rad)
%     OMEGA - right ascension of ascending node (rad)
%     omega - arguement of perigee (rad)
%       inc - inclination (rad)
%
% Outputs: r - position vector ECI frame (km)
%          v - velocity vector ECI frame (km/s)
%          h - specific angualr momentum (km^2/s)

%% Constants and Coordinates
pr = [cos(theta); sin(theta); 0];
pv = [-sin(theta); e+cos(theta); 0];
h = sqrt(mu*abs(a*(1-e^2)));

%% Compute r and v In the Perifocal Frame
rp = h^2/mu/(1+e*cos(theta))*pr;
vp = (mu/h)*pv;

%% Rotate r and v Into the ECI Frame
C_pa = rot(omega,3)*rot(inc,1)*rot(OMEGA,3);
r = C_pa'*rp;
v = C_pa'*vp;

end
