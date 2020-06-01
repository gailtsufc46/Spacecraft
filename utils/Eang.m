function T = Eang(xout,params)
% Usage: E = Eang(xout,params)
%
% Description: Function takes in the output of the sim and outputs the
% rotational energy of the system as a time series
% 
% Inputs: 
%   xout    -  7 x n or 12 x n time series of the spacecraft state vector 
%              where n is the number of time steps
%   params  -  struct of simulation parameters
%
% Outputs:
%   E  -  Rotational energy time series



%% Extract Parameters
I = params.sc.IB_b;

%% Calculate Rotational Energy
T = zeros(1,length(xout(1,:)));
for i = 1:length(T)
    T(i) = 0.5*xout(end-2:end,i)'*I*xout(end-2:end,i);
end
