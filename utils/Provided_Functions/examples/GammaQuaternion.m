function [Gamma_b] = GammaQuaternion(q_ba)
%GAMMAQUATERNION  Gamma matrix for quaternion calculation
% [Gamma_b] = GAMMAQUATERNION(q_ba) solves for the Gamma matrix based on the 
% quaternion using expression on p. 41 of de Ruiter (2013).
%
% INPUT PARAMETERS:
% q_ba = 4x1 column matrix containing quaternion parameters
%
% OUTPUT PARAMETERS:
% Gamma_b = 4x3 Gamma matrix calculated from q_ba
%
% Ryan Caverly
% Updated February 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract column matrix and scalar part of quaternion
epsilon_ba = [q_ba(1);q_ba(2);q_ba(3)];
eta_ba = q_ba(4);

Gamma_b = 0.5*[eta_ba*eye(3)+crossm(epsilon_ba);-epsilon_ba'];