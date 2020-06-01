% Post processing script.
% Created by James Richard Forbes
% Edited by Ryan James Caverly

% Here is where you do post processing. 
% For instance, when all forces are conservative, energy should be 
% conserved. So, let's compute the energy, E = T + V.

E = zeros(1,length(t));
fyp_b2 = zeros(1,length(t));


for lv1 = 1:length(x_out)
    % Note, I like to use ``lv1'' for my loop counter, which stands for
    % ``loop-varibale 1'' because the letters i and j are reserved as
    % imaginary numbers.
    
    % Compute total energy at each time step
    E(lv1) = 1/2*m*l^2*x_out(lv1,2)^2 - m*g*(l*cos(x_out(lv1,1)));
    
    % Compute reaction force magnitude at each time step
    fyp_b2(lv1) = -m*(l*x_out(lv1,2)^2 + g*cos(x_out(lv1,1)));

end

