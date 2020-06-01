function params = getParams(params)
% Usage: params = getParams(params)
%
% Written by Garrett Ailts
% 
% Description: Loads input parameters, adds additional parameters by
% performing the same calculation performed before running any other sim.
% Main use is for testing and debugging with the parameters in the
% workspace
% 
% Input:
%   params  -  struct with simulation input parameters
%
% Output:
%   params  -  updated input params struct
% 

%% Calculate Spacecraft 
params.sc.IB_b = scMOI(params.sc);

end