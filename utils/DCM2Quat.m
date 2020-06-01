function q = DCM2Quat(C)
% Usage: q_ba = DCM2Quat(C_ba)
%
% Description: This function takes in a Direction Cosine Matrix (DCM)
% representing a rotation between too frames and returns the same rotation
% represented as a quaternion q.
%
% Inputs:
%   C  -  3 x 3 DCM representing a rotation between two coordinate frames
%   
% Outputs:
%   q  -  4 x 1 quaternion representing the same rotation
%  
% Garrett Ailts
% Updated 1/2020


%% Find eta
eta = sqrt(trace(C)+1)/2;

%% Calculate Epsilon, Choose Sign if eta = 0
if eta ~= 0
 epsilon = [(C(2,3)-C(3,2))/4/eta;
           (C(3,1)-C(1,3))/4/eta;
           (C(1,2)-C(2,1))/4/eta];
    
else 
    absEp = [((C(1,1)+1)/2)^0.5;
             ((C(2,2)+1)/2)^0.5;
             ((C(3,3)+1)/2)^0.5];
    epsilon = [absEp(1);
               sign(C(1,2))*absEp(2);
               sign(C(1,3))*absEp(3)];
end

%% Assemble Quaternion
q = [epsilon;
     eta];
 
end