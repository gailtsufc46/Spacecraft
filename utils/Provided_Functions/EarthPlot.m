function [] = EarthPlot(x_a,y_a,z_a,Re)
%EARTHPLOT Generates a plot of a spacecraft orbiting the Earth
% [] =EARTHPLOT(x_a,y_a,z_a,Re) generates a plot of a spacecraft orbiting the 
% Earth given time histories of the coordinates of the spacecraft in the
% ECI frame.
%
% INPUT PARAMETERS:
% x_a = time series of the "x" or "1" coordinate of the spacecraft position
% resolved in the ECI frame.
% y_a = time series of the "y" or "2" coordinate of the spacecraft position
% resolved in the ECI frame.
% z_a = time series of the "z" or "3" coordinate of the spacecraft position
% resolved in the ECI frame.
% Re = radius of the Earth
%
% OUTPUT PARAMETERS:
%
% Ryan Caverly
% Updated February 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constants
font_size = 15;
line_size = 15;
line_width = 2;


plot3(x_a,y_a,z_a,'r','Linewidth',line_width); % Plot the SC position data. 
hold on
grid on
% Create map of the Earth.
[F_i1, F_i2, F_i3] = sphere(36);
colormap(white)
surf(F_i1*Re, F_i2*Re, F_i3*Re)
load coast.mat %#ok<LOAD>
[x_coast, y_coast, z_coast] = sph2cart(long*(pi/180), lat*(pi/180), Re);
plot3(x_coast, y_coast, z_coast, 'k')
axis('equal')
title('Spacecraft Orbit','fontsize',font_size);
xlabel('x_a (m)','fontsize',font_size);
ylabel('y_a (m)','fontsize',font_size);
zlabel('z_a (m)','fontsize',font_size);
view([1 1 1])
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
