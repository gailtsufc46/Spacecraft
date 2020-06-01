function [vector_noisy] = EarthSensorNoisy(vector,Cba,t)
%EARTHSENSORNOISY   Calculate noisy rate gyro measurement
% [vector_noisy] = EarthSensorNoisy(vector,Cba,t) determines a noisy 
% measurement from an Earth horizon sensor
%
% INPUT PARAMETERS:
% vector = 3x1 vector in a frame
% Cba = 3x3 DCM of frame b relative to frame a
% t = time
%
% OUTPUT PARAMETERS:
% vector_noisy = 3x1 noisy vector measurement in b frame
%
% Ryan Caverly
% Updated April 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% error in each angle
err_angle = 0.1*pi/180; % rad

% noise in pitch, roll, and yaw
noise_pitch = err_angle*sin(100*t);
noise_roll = err_angle*cos(120*t);
noise_yaw = err_angle*sin(95*t);

vector_noisy = Cba*rot(noise_yaw,3)*rot(noise_roll,2)*rot(noise_pitch,1)*vector;