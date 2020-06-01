% Constants file.
% All constants should go in one m file. 

const.m = 1; % kg, mass.
const.l = 1; % m, length of pendulum
const.c = 0.3; % Ns/m, damping coefficient
const.g = 9.81; % m/s^2, gravitational constant

const.dummy_matrix = blkdiag([1 2; 3 4], 1); % example of a matrix that we can pass to the ODEs function