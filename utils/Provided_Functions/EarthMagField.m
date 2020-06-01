function bi = EarthMagField(r,t)
% James Richard Forbes

% March 29, 2014

% This function computes the Earth's magnetic field physical vector 
% resolved in the ECI frame. This field model can be found in Appendix H of 

% Wertz (1978), Spacecraft Attitude Determination and Control, Kluwer 
% Academic Publishers, Dordrecht, The Netherlands.

% Inputs: the position in the ECI frame and time. 
% Outputs: the components of the Earth's magnetic field physical vector resolved in the ECI frame.


Re = 6371.2*1000; % m, Radius of the earth

% Magnetic field constants
g10 = -29682e-9; % T 
g11 = -1789e-9; % T
h11 = 5310e-9; % T

% Position in ECI frame. 
r1 = r(1); % m
r2 = r(2); % m
r3 = r(3); % m
r_mag = sqrt(r.'*r); % m

alphag0 = 0;
alphag = alphag0 + 360.9856469*pi/180/86164*t + 0; % 23.9344696*3600 = 86164.0, use sidereal day
alphag = mod(alphag,2*pi);

alpha = atan2(r2,r1);
delta = atan2(r3,sqrt(r1^2 + r2^2)); 

phi = alpha - alphag;
theta = pi/2 - delta;

br = 2*(Re/r_mag)^3*( g10*cos(theta) + sin(theta)*( g11*cos(phi) + h11*sin(phi) ) );
btheta = (Re/r_mag)^3*( g10*sin(theta) - cos(theta)*( g11*cos(phi) + h11*sin(phi) ) );
bphi = (Re/r_mag)^3*( g11*sin(phi) - h11*cos(phi) );

bi1 = (br*cos(delta) + btheta*sin(delta))*cos(alpha) - bphi*sin(alpha);
bi2 = (br*cos(delta) + btheta*sin(delta))*sin(alpha) + bphi*cos(alpha);
bi3 = br*sin(delta) - btheta*cos(delta);

bi = [bi1 bi2 bi3]'; % Note, this is in the ECI frame!



