function [x,n,success] = NewtRaph(f,df,x,tolerance,M)
% Written by Garrett Ailts
% Usage: [x,n] = NewtRaph(f,df,x,tolerance,M)
% Takes in a function f and its derivative df and computes a solutions to f
% (i.e. when f(x)=0) using the Newton-Rhapson method. Function tolerance 
% and the max number of iterations M can also be specified. If they aren't,
% the default values will take effect

success = 0;
if nargin < 5
    M = 100;
end
if nargin < 4
    tolerance = 1*10^-6;
end
%% Solve
for i=1:M
    n=i;
    if abs(f(x))<tolerance
        success = 1;
        break;    
    end
    x=x-(f(x)/df(x));
end
end