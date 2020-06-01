function results = AttitudeSim(params)
% Usage: results = AttitudeSim(params)
%
% Written by Garrett Ailts
%
% Decription: Function that simulates the free rotation of a continous
% rigid body given an initial angular velocity.
%
% Inputs: 
%   params   -  struct of simulation paramters
%
% Outputs:
%   results  -  struct of simulation results
%

%% Constants
rad2deg = 180/pi; %#ok<NASGU>


%% Extract Parameters
% Sim
absTol = params.absTol;
relTol = params.relTol;
AttType = params.sc.Attitude_Type;
omega0 = params.sc.omega0;
tf = params.tsim;

%% Add SC MOI to Params
params.sc.IB_b = scMOI(params.sc);


%% Initial Conditions
if strcmp(AttType,'quaternion')
    x0 = [params.sc.qba0; omega0];
elseif strcmp(AttType,'DCM')
    x0 = [params.sc.Cba0(:); omega0];
else
    error('Incorrect attitude type!\n');
end

%% Simulate
options = odeset('AbsTol',absTol,'RelTol',relTol);
tspan = [0 tf];

[t,xout] = ode45(@(t,x) AttDyn(t,x,params),tspan,x0,options);

%% Post Process Data
xout = xout';
Post_ProcessAt;
results.t = t;
results.xout = xout;
results.T = T;
results.x0 = x0;
results.eulerAngs = eulerAngs;
results.normDet = normDet;

%% Create Plots
q = zeros(4,length(T));
if strcmp(AttType,'DCM')
   for i = 1:length(T)
       q(:,i) = DCM2Quat(reshape(xout(1:9,i),[3 3]));
   end
else
    q = xout(1:4,:);
end
PlotterAt;





end


