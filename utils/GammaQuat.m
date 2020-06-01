function Gamma = GammaQuat(q)
% Usage: Gammaba_b = GammaQuat(q)
%
% Written by Garrett Ailts
%
% Description: This function takes in a Direction Cosine Matrix (DCM)
% representing a rotation between too frames and returns the same rotation
% represented as a quaternion q.
%
% Inputs:
%   q  -  4 x 1 quaternion vector consisting of [epsilon(3 x 1) eta]'
%         representing a rotation between two coordinate frames
%   
% Outputs:
%   Gamma  -  4 x 4 matrix that maps the angular velocity between two 
%             frames to the quaternion rate of change 
%  
% Garrett Ailts
% Updated 1/2020
%

%% Compute Gamma
Gamma = 0.5*[q(4)*eye(3)+crossMatrix(q(1:3)) q(1:3);
             -q(1:3)' q(4)];

end