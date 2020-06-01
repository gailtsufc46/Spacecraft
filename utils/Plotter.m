%% Plotting Script
% Written by Garrett Ailts


%% File Paths and Extensions
ext = '.png';
folder = 'figs/PointMassOrbit/';

%% Spacecraft position
figType = 'sc_position';
figure(1)
subplot(3,1,1)
plot(t,xout(1,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$x_{a}$ (km)','fontsize',14,'interpreter','latex'); 
title('$x_{a}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(t,xout(2,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$y_{a}$ (km)','fontsize',14,'interpreter','latex'); 
title('$y_{a}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(t,xout(3,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$z_{a}$ (km)','fontsize',14,'interpreter','latex'); 
title('$z_{a}$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Spacecraft velocity
figType = 'sc_velocity';
figure(2)
subplot(3,1,1)
plot(t,xout(4,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\dot{x_{a}}$ (km/s)','fontsize',14,'interpreter','latex'); 
title('$\dot{x_{a}}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(t,xout(5,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\dot{y_{a}}$ (km/s)','fontsize',14,'interpreter','latex'); 
title('$\dot{y_{a}}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(t,xout(6,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\dot{z_{a}}$ (km/s)','fontsize',14,'interpreter','latex'); 
title('$\dot{z_{a}}$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Orbit Path Around Earth
figType = 'OrbitPlot';
figure(3)
EarthPlot(xout(1,:),xout(2,:),xout(3,:),R)

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Energy and energy change
figType = 'sc_energy';
figure(4)
subplot(2,1,1)
plot(t,E), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$E_{sw/a}$ (J)','fontsize',14,'interpreter','latex'); 
title('$E_{sw/a}$ vs $t$','fontsize',16,'interpreter','latex');

ep = (E-E(1))/E(1);
subplot(2,1,2)
plot(t,ep), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\frac{E_{sw/a}-E(0)_{sw/a}}{E(0)_{sw/a}}$ (J)','fontsize', ...
                                                14,'interpreter','latex'); 
title('$\frac{E_{sw/a}-E(0)_{sw/a}}{E(0)_{sw/a}}$ vs $t$','fontsize', ...
                                                16,'interpreter','latex');
savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);