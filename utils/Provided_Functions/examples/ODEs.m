function  [dot_x] = ODEs(t,x,dummy_matrix,const);
%ODES  
% [dot_x] =ODES(t,x,dummy_matrix,const) returns x_dot = f(x,t) by
% specifying the differential equations of the system in first-order form.
%
% INPUT PARAMETERS:
% t = time
% x = system states
% dummy_matrix = matrix that is passed to function (not used in this
% example)
% const = a structure that contains all relevant physical parameters
%
% OUTPUT PARAMETERS:
% dot_x = the first-order differential equation evaluated at x and t
%
% Ryan Caverly
% Updated February 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call constants
% Extract constants from const

m = const.m;
l = const.l;
c = const.c;
g = const.g;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamics

% First, extract states in a convenient form. 
theta = x(1);
theta_dot = x(2);

% Form dot_x = f(x,u) system.
dot_x1 = theta_dot;
dot_x2 = 1/(m*l)*(- c*theta_dot - m*g*sin(theta));

dot_x = [dot_x1; dot_x2];



