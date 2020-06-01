%% Attitude Sim Plotting Script
% Written by Garrett Ailts


%% File Paths and Extensions
ext = '.png';
folder = 'figs/AttitudeSim/';

%% Plot State Vector
% Spacecraft Attitude Quaternion
figType = 'quat_attitude';
figure(1)
subplot(4,1,1)
plot(t,q(1,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\epsilon_{1}$','fontsize',14,'interpreter','latex'); 
title('$\epsilon_{1}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(4,1,2)
plot(t,q(2,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\epsilon_{2}$','fontsize',14,'interpreter','latex'); 
title('$\epsilon_{2}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(4,1,3)
plot(t,q(3,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\epsilon_{3}$','fontsize',14,'interpreter','latex'); 
title('$\epsilon_{3}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(4,1,4)
plot(t,q(4,:)), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\eta$','fontsize',14,'interpreter','latex'); 
title('$\eta$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

% Spacecraft Euler Angles (3-2-1 Sequence)
figType = 'euler_angles';
figure(2)
subplot(3,1,1)
plot(t,eulerAngs(1,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\phi$ (deg)','fontsize',14,'interpreter','latex'); 
title('$\phi$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(t,eulerAngs(2,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\theta$ (deg)','fontsize',14,'interpreter','latex'); 
title('$\theta$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(t,eulerAngs(3,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\psi$ (deg)','fontsize',14,'interpreter','latex'); 
title('$\psi$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

% Normalized Constraint
figType = 'constraint';
if strcmp(AttType,'quaternion')
    ylab = '$\epsilon^{T}\epsilon+\eta^{2}-1$';
    titl = '$\epsilon^{T}\epsilon+\eta^{2}-1$ vs $t$';
elseif strcmp(AttType,'DCM')
    ylab = '$det(C_{ba})-1$';
    titl = '$det(C_{ba})-1$ vs $t$';    
end

figure(3)
plot(t,normDet), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel(ylab,'fontsize',14,'interpreter','latex'); 
title(titl,'fontsize',16,'interpreter','latex');


savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

% Angular Rates
figType = 'angular_rates';
figure(4)
subplot(3,1,1)
plot(t,xout(end-2,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\omega^{ba}_{b1}$ (deg/s)','fontsize',14,'interpreter','latex'); 
title('$\omega^{ba}_{b1}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,2)
plot(t,xout(end-1,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\omega^{ba}_{b2} (deg/s)$','fontsize',14,'interpreter','latex'); 
title('$\omega^{ba}_{b2}$ vs $t$','fontsize',16,'interpreter','latex');

subplot(3,1,3)
plot(t,xout(end,:)*rad2deg), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\omega^{ba}_{b3}$ (deg/s)','fontsize',14,'interpreter','latex'); 
title('$\omega^{ba}_{b3}$ vs $t$','fontsize',16,'interpreter','latex');

savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

% Rotational Energy
figType = 'sc_rot_energy';
figure(5)
subplot(2,1,1)
plot(t,T), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$T_{Bw/a}$ (J)','fontsize',14,'interpreter','latex'); 
title('$T_{Bw/a}$ vs $t$','fontsize',16,'interpreter','latex');

ep = (T-T(1))/T(1);
subplot(2,1,2)
plot(t,ep), xlabel('$t$ (s)','fontsize',14,'interpreter','latex');
ylabel('$\frac{T_{Bw/a}-T(0)_{Bw/a}}{T(0)_{Bw/a}}$ (J)','fontsize', ...
                                                14,'interpreter','latex'); 
title('$\frac{T_{Bw/a}-T(0)_{Bw/a}}{T(0)_{Bw/a}}$ vs $t$','fontsize', ...
                                                16,'interpreter','latex');
savePath = strcat(folder,figType,ext);
saveas(gcf,savePath);

%% Animtate Attitude
figType = 'AttAnim';
l = params.sc.height;
w = params.sc.side; d = w;
q = q';

savePath = strcat(folder,figType);
AttitudeAnim(savePath,q,l,w,d,t,10);
