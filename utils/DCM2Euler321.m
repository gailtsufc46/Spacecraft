function [phi, theta, psi] = DCM2Euler321(C)
% Usage: e321_ba = DCM2Euler321(C_ba)
%
% Description: This function takes in a Direction Cosine Matrix (DCM)
% representing a rotation between too frames and returns the same rotation
% represented as a quaternion q.
%
% Inputs:
%   C  -  3 x 3 DCM representing a rotation between two coordinate frames
%   
% Outputs:
%   phi    -  Angle of rotation about the 1 axis (rad)
%   theta  -  Angle of rotation about the 2 axis (rad)
%   psi    -  Angle of rotation about the 3 axis (rad)
%   
%   
%  
% Garrett Ailts
% Updated 1/2020
%

%% Find theta
theta = -asin(C(1,3));

if pi/2-abs(theta)<=eps
    warning('Approaching kinematic singularity!\n'); % comment out to
                                                     % supress warning
end

%% Compute psi and phi
psi = atan(C(1,2)/C(1,1));
phi = atan(C(2,3)/C(3,3));

end




