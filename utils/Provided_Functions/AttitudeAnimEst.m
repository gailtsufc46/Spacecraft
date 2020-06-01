function  [] = AttitudeAnimEst(filename,q,q_IN,q_TRIAD,l,w,d,t_span,t_anim);
%ODES  
% [] = AttitudeAnim(q,l,w,d) generates animation of spacecraft attitude
%
% INPUT PARAMETERS:
% filename = name under which the animation will be saved
% q = time history of quaternion (N X 4 matrix)
% q = time history of estimated quaternion using inertial navigation (N X 4 matrix)
% q = time history of estimated quaternion using TRIAD (N X 4 matrix)
% l = length of spacecraft
% w = width of spacecraft
% d = depth of spacecraft
% t_span = total simulation time 
% t_anim = length of animation in seconds


span = [-max([l,w,d]), max([l,w,d])]; % Size of plotting space

fps = 30; % frames per second in animation
n_frames = round(fps*t_anim); % number of frames in animation

t_x = t_span(end)/t_anim; % animation time multiplier

t_frames = linspace(0,t_span(end),n_frames); % simulation time of frames


fig_pos = [0 0 1*1280 1.2*1024]; % Set size of figure
figure_handle = figure('Renderer','opengl','Position',fig_pos); % create figure

hold on 
grid on
axis([span, span, span]); % set axes ranges

pbaspect([1,1,1]); % set equal aspect ratio
         
view(5,25) % set viewing angle 


movieobj = VideoWriter(strcat(filename,'.avi')); % create movie object
movieobj.Quality = 100; % set quality
movieobj.FrameRate = fps; % set framerate
open(movieobj); % open movie object


% INITIALIZE SPACECRAFT OBJECT (true state)
[Xt, Yt, Zt, Pt] = BoxMaker(l,w,d, eye(3), [0;0;0]); % Get corner coords

sc_true.sides = surf(Xt,Yt,Zt,'FaceColor','b','FaceAlpha',0.7); % plot sides 
sc_true.top = patch(Pt(1,1:4),Pt(2,1:4),Pt(3,1:4),'b','FaceAlpha',0.7); % plot top face
sc_true.bottom = patch(Pt(1,5:8),Pt(2,5:8),Pt(3,5:8),'b','FaceAlpha',0.7); % plot bottom face

axis_length = 0.75*max([l;w;d]);

frame_a.x = plot3([0;axis_length],[0;0],[0;0],'k','LineWidth',2);
frame_a.y = plot3([0;0],[0;axis_length],[0;0],'k','LineWidth',2);
frame_a.z = plot3([0;0],[0;0],[0;axis_length],'k','LineWidth',2);

frame_b.x = plot3([0;axis_length],[0;0],[0;0],'r','LineWidth',2);
frame_b.y = plot3([0;0],[0;axis_length],[0;0],'r','LineWidth',2);
frame_b.z = plot3([0;0],[0;0],[0;axis_length],'r','LineWidth',2);

frame_IN.x = plot3([0;axis_length],[0;0],[0;0],'c','LineWidth',2);
frame_IN.y = plot3([0;0],[0;axis_length],[0;0],'c','LineWidth',2);
frame_IN.z = plot3([0;0],[0;0],[0;axis_length],'c','LineWidth',2);

frame_TRIAD.x = plot3([0;axis_length],[0;0],[0;0],'g','LineWidth',2);
frame_TRIAD.y = plot3([0;0],[0;axis_length],[0;0],'g','LineWidth',2);
frame_TRIAD.z = plot3([0;0],[0;0],[0;axis_length],'g','LineWidth',2);

legend([frame_a.x frame_b.x frame_IN.x frame_TRIAD.x],{'Inertial Frame','True Body Frame','Inertial Nav. Result','TRIAD Result'},'FontSize',20)


% Add time multiplier
%text(0, 0, 0.9*span(2),strcat(num2str(round(t_x,2,'significant')),'x Speed'), 'FontSize', 20)
annotation('textbox',...
            [.4 .1 .1 .1],'String',...
            strcat(num2str(round(t_x,2,'significant')),'x Speed'),...
            'FitBoxToText','on','FontSize',20);
animation_waitbar = waitbar(0,'Rendering Animation...'); % create waitbar


%set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[],...
%    'XTick',[],'YTick',[],'ZTick',[]); % turn off axes markers
grid on
Frame = struct('cdata', cell(1,n_frames), 'colormap', cell(1,n_frames));


for lv1 = 1:n_frames % loop through frames 
    
    waitbar(lv1/n_frames,animation_waitbar) % update waitbar
   [~, ind_curr] = min(abs(t_frames(lv1)-t_span)); % find closest data point to desired frame
    
    q_ba_curr = transpose(q(ind_curr,:)); % quaternion for current frame
    C_ba_curr = Quaternion2DCM(q_ba_curr); % DCM for current frame
    
    q_ba_IN_curr = transpose(q_IN(ind_curr,:)); % quaternion for current frame
    C_ba_IN_curr = Quaternion2DCM(q_ba_IN_curr); % DCM for current frame
    
    q_ba_TRIAD_curr = transpose(q_TRIAD(ind_curr,:)); % quaternion for current frame
    C_ba_TRIAD_curr = Quaternion2DCM(q_ba_TRIAD_curr); % DCM for current frame
    
    % Update spacecraft attitude (true state) 
    
    [Xt,Yt,Zt,Pt] = BoxMaker(l,w,d, C_ba_curr, [0;0;0]); % update corner locations
    
    % update surface plots
    set(sc_true.sides,'XData',Xt,'Ydata',Yt,'ZData',Zt) 
    set(sc_true.top,'XData',Pt(1,1:4),'Ydata',Pt(2,1:4),'ZData',Pt(3,1:4))
    set(sc_true.bottom,'XData',Pt(1,5:8),'Ydata',Pt(2,5:8),'ZData',Pt(3,5:8))
    
    set(frame_b.x,'XData',[0;C_ba_curr(1,1)]*axis_length,'Ydata',[0;C_ba_curr(1,2)]*axis_length,'ZData',[0;C_ba_curr(1,3)]*axis_length) 
    set(frame_b.y,'XData',[0;C_ba_curr(2,1)]*axis_length,'Ydata',[0;C_ba_curr(2,2)]*axis_length,'ZData',[0;C_ba_curr(2,3)]*axis_length) 
    set(frame_b.z,'XData',[0;C_ba_curr(3,1)]*axis_length,'Ydata',[0;C_ba_curr(3,2)]*axis_length,'ZData',[0;C_ba_curr(3,3)]*axis_length) 
    
    set(frame_IN.x,'XData',[0;C_ba_IN_curr(1,1)]*axis_length,'Ydata',[0;C_ba_IN_curr(1,2)]*axis_length,'ZData',[0;C_ba_IN_curr(1,3)]*axis_length) 
    set(frame_IN.y,'XData',[0;C_ba_IN_curr(2,1)]*axis_length,'Ydata',[0;C_ba_IN_curr(2,2)]*axis_length,'ZData',[0;C_ba_IN_curr(2,3)]*axis_length) 
    set(frame_IN.z,'XData',[0;C_ba_IN_curr(3,1)]*axis_length,'Ydata',[0;C_ba_IN_curr(3,2)]*axis_length,'ZData',[0;C_ba_IN_curr(3,3)]*axis_length) 
    
    set(frame_TRIAD.x,'XData',[0;C_ba_TRIAD_curr(1,1)]*axis_length,'Ydata',[0;C_ba_TRIAD_curr(1,2)]*axis_length,'ZData',[0;C_ba_TRIAD_curr(1,3)]*axis_length) 
    set(frame_TRIAD.y,'XData',[0;C_ba_TRIAD_curr(2,1)]*axis_length,'Ydata',[0;C_ba_TRIAD_curr(2,2)]*axis_length,'ZData',[0;C_ba_TRIAD_curr(2,3)]*axis_length) 
    set(frame_TRIAD.z,'XData',[0;C_ba_TRIAD_curr(3,1)]*axis_length,'Ydata',[0;C_ba_TRIAD_curr(3,2)]*axis_length,'ZData',[0;C_ba_TRIAD_curr(3,3)]*axis_length) 
    
    
    Frame(lv1) = getframe(figure_handle); % capture frame
    writeVideo(movieobj,Frame(lv1)); % write frame 
   
end

%close windows
close(figure_handle)
close(animation_waitbar)

end



% Ryan Caverly
% Alex Hayes
% Updated March 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






