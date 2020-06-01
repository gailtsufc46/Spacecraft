% Plotting script.
% Created by James Richard Forbes
% Edited by Ryan James Caverly

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Font size, line size, and line width. 
font_size = 15;
line_size = 15;
line_width = 2;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plots.
% Notice how the axes for each plot are labeled with the appropriate units

% System response
figure
subplot(2,1,1) % Plot of theta vs time
plot(t,x_out(:,1)*180/pi,'Linewidth',line_width); %180/pi conversion to deg from rad
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$\theta$ (deg)','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
subplot(2,1,2) % plot of theta_dot vs time
plot(t,x_out(:,2)*180/pi,'Linewidth',line_width); %180/pi conversion to deg from rad
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$\dot{\theta}$ (deg/s)','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on


% Energy, which should be constant when damping is zero.
figure
subplot(2,1,1) % Plot of total energy vs time (should be constant)
plot(t,E,'Linewidth',line_width);
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$E$ (J)','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
subplot(2,1,2) % Plot of normalized change in energy vs time (should be zero)
plot(t,(E-E(1))./E(1),'Linewidth',line_width);
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$(E - E(0))/E(0)$ (J)','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on


% Reaction force fyp_b2
figure
plot(t,fyp_b2,'Linewidth',line_width);
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$f^{yp}_{b2}$ (N)','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
