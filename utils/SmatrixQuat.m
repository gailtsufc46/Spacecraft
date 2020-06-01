function S = SmatrixQuat(q)
% Usage: Sba_b = SmatrixQuat(q)
%
% Description: This function take in a rotation represented as a quaternion
% and returns the mapping matrix from the quaternion to angular velocity
%
% Inputs:
%   q  -  4 x 1 quaternion vector consisting of [epsilon(3 x 1) eta]'
%         representing a rotation between two coordinate frames
%   
% Outputs:
%   S  -  4 x 4 matrix that maps the quaternion rate of change to the
%         angular velocity between two frames 
%  
% Garrett Ailts
% Updated 1/2020
%

%% Compute S
S = 2*[(q(4)*eye(3)-crossMatrix(q(1:3))) -q(1:3);
       q(1:3)' q(4)];

end