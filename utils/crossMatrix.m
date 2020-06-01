function ucross = crossMatrix(u)
% Written by Garrett Ailts
%
% Usage: ucross = crossMatrix(u)
%
% Description: Function takes in a column matrix and outputs the 
%              associated cross product matrix for use in numerical
%              computation of the cross product
% 
% Inputs:
%   u - 3x1 column matrix
%   
% Ouputs:
%   ucross - 3x3 cross product matrix of u
%

%% Assemble Cross Product Matrix
ucross = [0 -u(3) u(2);
          u(3) 0 -u(1);
          -u(2) u(1) 0];
end
