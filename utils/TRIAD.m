function C_ba = TRIAD(s1_a,s2_a,s1_b,s2_b)
% Usage: C_ba = TRIAD(s1_a,s2_a,s1_b,s2_b)
%
% Written by Garrett Ailts
%
% Description: Function takes in two measurements of physical vectors
% resolved in an inertial fram (a) and a vehicle body frame (b) and uses
% the TRIAD algorithm to calculate the DCM C_ba that relates the two frames
%
% Inputs: 
%   s1_a  -  3 x 1 column matrix representing vector s1 resolved in frame a
%   s2_a  -  3 x 1 column matrix representing vector s2 resolved in frame a
%   s1_b  -  3 x 1 column matrix representing vector s1 resolved in frame b
%   s2_b  -  3 x 1 column matrix representing vector s2 resolved in frame b
%
% Outputs:
%   C_ba  -  3 x 3 DCM relating frame a to frame b
%

%% Normalize Vectors
shat1_a = s1_a/norm(s1_a);
shat2_a = s2_a/norm(s2_a);
shat1_b = s1_b/norm(s1_b);
shat2_b = s2_b/norm(s2_b);

%% Create Intermediate Frame w and Express its Basis in Frame a and b
w1_a = shat1_a;
w1_b = shat1_b;

s1aXs2a = crossMatrix(shat1_a)*shat2_a;
s1bXs2b = crossMatrix(shat1_b)*shat2_b;
w2_a = s1aXs2a/norm(s1aXs2a);
w2_b = s1bXs2b/norm(s1bXs2b);

w3_a = crossMatrix(w1_a)*w2_a;
w3_b = crossMatrix(w1_b)*w2_b;

%% Combine DCM's Relating Frames a and b to Intermediate Frame to get C_ba
C_aw = [w1_a w2_a w3_a]; C_bw = [w1_b w2_b w3_b];
C_ba = C_bw*C_aw';

end






