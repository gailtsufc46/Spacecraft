function [vector_noisy] = MagnetometerNoisy(vector,Cba,t)
%MAGNETOMETERSORNOISY   Calculate noisy magnetometer measurement
% [vector_noisy] = MagnetometerNoisy(vector,Cba,t) determines a noisy 
% measurement from a magnetometer
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
err_angle = 1*pi/180; % rad

% noise in pitch, roll, and yaw
noise_pitch = err_angle*sin(200*t);
noise_roll = err_angle*cos(250*t);
noise_yaw = err_angle*sin(120*t);

vector_noisy = Cba*rot(noise_yaw,3)*rot(noise_roll,2)*rot(noise_pitch,1)*vector;