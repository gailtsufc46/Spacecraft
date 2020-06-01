function rho = usDensity(x,Earth)
% Usage: rhoa_a = usDensity(x,params)
%
% Written by Garrett Ailts
%
% Description: Function takes in a column matrix of the spacecraft state at
% a certain moment in time along with a struct of parameters and returns
% the total density at the location of the spacecraft
%
%

%% Extract Parameters
Cs = Earth.Coeffs;
hceiling = Earth.hceiling;
R = Earth.Rmean;

%% Find Altitude Range
z = (norm(x(1:3))-R)/1000; % geometric altitude in km
if z>hceiling(6) && z<120e3
    error('Altitude out of range for this model!\n');
else
    row = find(hceiling>z,1,'first');
end

%% Compute Density
zs = [z^4; z^3; z^2; z; 1];
rho = exp(Cs(row,:)*zs);

end