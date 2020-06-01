%% Plotter_v3 
% Garrett Ailts

%% Extract Params
Animate_Att = params.Animate_Att;

%% File Paths and Extensions
ext = '.png';
folder = 'figs/SADC_PP6/p2b/';

%% Spacecraft Position
figType = 'sc_position';
figure(1)
subplot(3,1,1)
plot(tout,xout(1,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$x_{a}$ (km)','fontsize',14,'interpreter','latex'); 
title('$x_{a}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(tout,xout(2,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$y_{a}$ (km)','fontsize',14,'interpreter','latex'); 
title('$y_{a}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(tout,xout(3,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$z_{a}$ (km)','fontsize',14,'interpreter','latex'); 
title('$z_{a}$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Spacecraft velocity
figType = 'sc_velocity';
figure(2)
subplot(3,1,1)
plot(tout,xout(4,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\dot{x_{a}}$ (km/s)','fontsize',14,'interpreter','latex'); 
title('$\dot{x_{a}}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(tout,xout(5,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\dot{y_{a}}$ (km/s)','fontsize',14,'interpreter','latex'); 
title('$\dot{y_{a}}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(tout,xout(6,:)/1000), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\dot{z_{a}}$ (km/s)','fontsize',14,'interpreter','latex'); 
title('$\dot{z_{a}}$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Plot of Orbit Around Earth
figure(3)
figType = 'OrbitPlot';
EarthPlot(xout(1,:),xout(2,:),xout(3,:),R)

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Orbit Altitude
if atm_model
    figType = 'sc_altitude';
    figure(4)
    plot(tout,h), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
    ylabel('$Altitude$ (km)','fontsize',14,'interpreter','latex'); 
    title('$Altitude$ vs $t$','fontsize',16,'interpreter','latex');
    savePath = strcat(folder,figType,ext);
    saveas(gcf,savePath);
end


%% Quaternion Attitude 
figType = 'quat_attitude';
figure(5)
subplot(4,1,1)
plot(tout,q(1,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\epsilon_{1}$','fontsize',14,'interpreter','latex'); 
title('$\epsilon_{1}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(4,1,2)
plot(tout,q(2,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\epsilon_{2}$','fontsize',14,'interpreter','latex'); 
title('$\epsilon_{2}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(4,1,3)
plot(tout,q(3,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\epsilon_{3}$','fontsize',14,'interpreter','latex'); 
title('$\epsilon_{3}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(4,1,4)
plot(tout,q(4,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\eta$','fontsize',14,'interpreter','latex'); 
title('$\eta$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Spacecraft Euler Angles (3-2-1 Sequence)
figType = 'euler_angles';
figure(6)
subplot(3,1,1)
plot(tout,eulerAngs(1,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\phi$ (deg)','fontsize',14,'interpreter','latex'); 
title('$\phi$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(tout,eulerAngs(2,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\theta$ (deg)','fontsize',14,'interpreter','latex'); 
title('$\theta$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(tout,eulerAngs(3,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\psi$ (deg)','fontsize',14,'interpreter','latex'); 
title('$\psi$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Normalized Attitude Constraint
figType = 'constraint';
if strcmp(AttType,'quaternion')
    ylab = '$q^{T}q-1$';
    titl = '$q^{T}q-1$ vs $t$';
elseif strcmp(AttType,'DCM')
    ylab = '$det(C_{ba})-1$';
    titl = '$det(C_{ba})-1$ vs $t$';    
end

figure(7)
plot(tout,constraint), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel(ylab,'fontsize',14,'interpreter','latex'); 
title(titl,'fontsize',16,'interpreter','latex');


savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Spacecraft Angular Rates
figType = 'angular_rates';
figure(8)
subplot(3,1,1)
plot(tout,wba(1,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\omega^{ba}_{b1}$ (deg/s)','fontsize',14,'interpreter','latex'); 
title('$\omega^{ba}_{b1}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(tout,wba(2,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\omega^{ba}_{b2}$ (deg/s)','fontsize',14,'interpreter','latex'); 
title('$\omega^{ba}_{b2}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(tout,wba(3,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\omega^{ba}_{b3}$ (deg/s)','fontsize',14,'interpreter','latex'); 
title('$\omega^{ba}_{b3}$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Total Energy
figType = 'tot_energy';
figure(9)
subplot(2,1,1)
plot(tout,E), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$E_{Bp/a}$ (J)','fontsize',14,'interpreter','latex'); 
title('$E_{Bp/a}$ vs $t$','fontsize',16,'interpreter','latex');

ep = (E-E(1))/E(1);
subplot(2,1,2)
plot(tout,ep), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\frac{E_{Bp/a}-E(0)_{Bp/a}}{E(0)_{Bp/a}}$ (J)','fontsize', ...
                                                14,'interpreter','latex'); 
title('$\frac{E_{Bp/a}-E(0)_{Bp/a}}{E(0)_{Bp/a}}$ vs $t$','fontsize', ...
                                                16,'interpreter','latex');
savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);


%% Animtate Attitude
if Animate_Att
    figType = 'AttAnim';
    l = params.sc.height;
    w = params.sc.side; d = w;
    q = q';
    AttitudeAnim(savePath,q,l,w,d,tout,10);
end

