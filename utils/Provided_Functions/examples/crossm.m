function [M] = crossm(v)
%CROSSM  Cross product matrix calculation.
% [M] = CROSSM(v) solves for cross product matrix of v.
%
% INPUT PARAMETERS:
% v = 3x1 column matrix
%
% OUTPUT PARAMETERS:
% M = 3x3 cross product matrix of v
%
% Ryan Caverly
% Updated February 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = [0 -v(3) v(2);v(3) 0 -v(1);-v(2) v(1) 0];