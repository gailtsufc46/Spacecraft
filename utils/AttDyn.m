function xdot = AttDyn(t,x,params) %#ok<INUSL>
% Usage: [t,xout] = ode45(@(t,x) AttDyn(t,x,params),tspan,x0,options);
%
% Written by Garrett Ailts
%
% Description: Function takes in the current time, state, and a struct of
% simulation parameters for a continuouse rigid body's (CRB) angular 
% dynamics using the quaternion or DCM representation and returns the 
% derivative of the state vector
%
% Inputs:
%   t       -  time since t0 (s)
%   x       -  7 x 1 (quaternion) or 12 x 1 (DCM) state vector 
%              representing CRB's attitude and angular rates
%   params  -  struct containing CRB and simulation parameters
%
% Outputs:
%   xdot    -  7 x 1 vector containing the rates of change for the state
%              paramters
%
%

%% Extract Parameters
I = params.sc.IB_b;

%% Moments
mom = 0; % This will eventually be a function calculating imparted moments
         % on the CRB at each time step

%% Calculate Rate of Change of State Vector

if length(x)==12
    omegaCross = crossMatrix(x(10:12));
    xdot = [-omegaCross*x(1:3); -omegaCross*x(4:6); -omegaCross*x(7:9); ...
                                           I\(mom-omegaCross*I*x(10:12))];
    % DCM calc
else
    omegaCross = crossMatrix(x(5:7));
    xdot = [GammaQuat(x(1:4))*[x(5:7);0]; I\(mom-omegaCross*I*x(5:7))];
    % quaternion calculation
end

end







