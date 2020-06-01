function R = rot(theta,primary)
% R = rot(theta,primary)
% This function is more of an orientation rotation than a true rotation.
% This descrbies the relation between two frames of reference, with 
% the angle theta about a specified axis 1, 2 or 3.

switch primary
    case 1
        R = [ 1 0 0 ; 0 cos(theta) sin(theta); 0 -sin(theta) cos(theta)];
    case 2 
        R = [ cos(theta) 0 -sin(theta) ; 0 1 0; sin(theta) 0 cos(theta)];
    case 3
        R = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0 ; 0 0 1];
end