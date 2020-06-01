function v = uncross(vX)
% Usage: v = uncross(vX), where vX = crossMatrix(v)
%
% Written by Garrett Ailts
%
% Description: Function performs the uncross operation on the skew 
% symmetric cross matrix (3 x 3) of a column matrix (3 x 1). Returns the 
% 3 x 1 column matrix
%
% Inputs:
%   vX  -  3 x 3 skew symmetric cross matrix of a 3 x 1 column matrix
%          representing the first vector and cross operator of a cross 
%          product expression (v x a == vX*a)
% 
% Outputs:
%   v  -  3 x 1 column matrix that composed the vX cross matrix
%

v = [vX(3,2); vX(1,3); vX(2,1)];

end
    