function  [r_a,v_a] = findRandV(mu,e,inc,a,omega,Omega,t0,t)
%FINDRANDV Finds position and velocity in the inertial frame (ECI)
% [r_a,v_a] =FINDRANDV(mu,e,inc,a,omega,Omega,t0,t) finds the position and 
% velocity in the inertial frame (ECI) at time t
%
% INPUT PARAMETERS:
% mu = G*mp gravitional constant of body p (m^3/s^2).
% e = eccentricity of orbit.
% inc = inclination of orbit (rad).
% a = semimajor axis of orbit (m).
% omega = argument of perigeee (rad).
% Omega = right ascension of the ascending node (rad).
% t0 = time of perigee passage (s).
% t = time to evaluate position and velocity (s).
%
% OUTPUT PARAMETERS:
% r_a = position of spacecraft in ECI frame at time t (m).
% v_a = velocity of spacecraft in ECI frame at time t (m/s).
% 
% Ryan Caverly
% Updated February 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Make sure eccentricity is manitude
e_norm = norm(e);

% Rotation matrix
C_pa = rot(omega,3)*rot(inc,1)*rot(Omega,3);
C_ap = C_pa.';

% Angular momentum
h = sqrt(mu*a*(1-e_norm^2));

% Mean motion
n_mm = sqrt(mu/a^3);

% Mean anomoly
M = n_mm * (t - t0);

% Kepler's equation using contraction M = E - e*sin(E)
E = M;
while abs(E-e_norm*sin(E)-M) > 1e-6
    E = M + e_norm*sin(E);
end

% Get magitude of r and theta resolved in Perifocal coordinates
theta = 2*atan(sqrt((1+e_norm)/(1-e_norm))*tan(E/2));

r_norm = h^2/mu/(1+e_norm*cos(theta));

% Get the magnitude of the velocity
v_norm = sqrt(2*(-mu/(2*a)+mu/r_norm));
v_calc = sqrt(mu/(a*(1-e_norm^2)));

% r in Perifocal
r_p = [r_norm*cos(theta) ; r_norm*sin(theta) ; 0];
% v in Perifocal
v_p = [-v_calc*sin(theta) ; v_calc*(e_norm+cos(theta)) ; 0];

% r in ECI
r_a = C_ap*r_p;
% v in ECI
v_a = C_ap*v_p;