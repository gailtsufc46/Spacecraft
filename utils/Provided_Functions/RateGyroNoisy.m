function [omega_noisy] = RateGyroNoisy(omega,t)
%RATEGYRONOISY  Calculate noisy rate gyro measurement
% [omega_noisy] = RateGyroNoisy(omega,t) determines a noisy measurement of a
% rate gyro
%
% INPUT PARAMETERS:
% omega = 3x1 true angular velocity
% t = time
%
% OUTPUT PARAMETERS:
% omega_noisy = 3x1 noisy angular velocity measurement
%
% Ryan Caverly
% Updated April 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bias = 1e-2; % rad/s, bias
SNR = 10; % signal to noise ratio
SNR_inv = 1/SNR;
noise_freq1 = 200; % rad/s
noise_freq2 = 300; % rad/s

omega_noisy = omega*(1+ SNR_inv*sin(noise_freq1*t) +  SNR_inv*sin(noise_freq2*t)) + bias;