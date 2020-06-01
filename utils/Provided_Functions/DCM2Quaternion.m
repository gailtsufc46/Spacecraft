function [q_ba] = DCM2Quaternion(Cba)
%DCM2QUATERNION  DCM to quaternion conversion.
% [q_ba] = DCM2QUATERNION(Cba) solves for the quaternion based on the DCM 
% using procedure on pgs. 25-27 of de Ruiter (2013).
%
% INPUT PARAMETERS:
% Cba = 3x3 DCM
%
% OUTPUT PARAMETERS:
% q_ba = 4x1 quaternion calculated from Cba
%
% Ryan Caverly
% Updated February 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate scalar part of quaternion
eta_ba = 0.5*sqrt(trace(Cba)+1);

% Calculation of column matrix part depends on value of eta_ba
if eta_ba ~= 0
    epsilon_1 = (Cba(2,3)-Cba(3,2))/(4*eta_ba);
    epsilon_2 = (Cba(3,1)-Cba(1,3))/(4*eta_ba);
    epsilon_3 = (Cba(1,2)-Cba(2,1))/(4*eta_ba);
else 
    epsilon_1_abs = sqrt(0.5*(Cba(1,1)+1));
    epsilon_2_abs = sqrt(0.5*(Cba(2,2)+1));
    epsilon_3_abs = sqrt(0.5*(Cba(3,3)+1));
    
    % There are different options for this calcuation
    epsilon_1 = epsilon_1_abs;
    epsilon_2 = sign(Cba(1,2))*epsilon_2_abs;
    epsilon_3 = sign(Cba(1,3))*epsilon_3_abs;
end

% Column matrix part of quaternion
epsilon_ba = [epsilon_1;epsilon_2;epsilon_3];

% Stack quaternion parts together
q_ba = [epsilon_ba;eta_ba];