% Created by James Richard Forbes
% Edited by Ryan James Caverly
% February 2019

% This is a piece of sample code written for AEM 4305. 
% The purpose of this code is to show students how to use matlab to 
% numerically integrate DEs, and how to write clean code. This code is not
% ``perfect'' in that I have my own personal style, but it is clean,
% reasonably commented, and overall neat and tidy. 
%
% We will simulate a pendulum whose differential equations of motion
% derived in class. Try simulating with different initial conditions to see
% where the pendulum settles. If the damping is set to zero, then all
% forces acting on the particle are conservative and energy should remain
% constant.

clear all
clc
close all
format long

%profile on; % Try uncommenting this ``profile off;'' code at the bottom.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants 
const_struct % All constants in one file.

m = const.m;
l = const.l;
c = const.c;
g = const.g;

dummy_matrix = const.dummy_matrix;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial conditions.
IC = [50*pi/180; 0*400*pi/180]; % initial conditions in rad and rad/s.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation time.
t0 = 0; % s
t_max = 50; % s
t_div = 10001; % number of steps to divide the time series into.
t_span = linspace(t0,t_max,t_div); % Total simulation time.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation options.
 options = odeset('AbsTol',1e-9,'RelTol',1e-9); % This changes the integration tolerence.
%options = [];

tic
% Use any solver; I use these three the most. 
[t,x_out] = ode45(@ODEs,t_span,IC,options,dummy_matrix,const);
%[t,x_out] = ode15s(@ODEs,t_span,IC,options,output_flag,dummy_matrix,t_span,waitbar_handle,const);
%[t,x_out] = ode113(@ODEs,t_span,IC,options,output_flag,dummy_matrix,t_span,waitbar_handle,const);

time_stamp = toc

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Post Processing
post_processing_v2

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot data
plot_script_v2

%profile off;
%profview;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save all the data. (You never know when you'll need it again.)
save sim_data_v1