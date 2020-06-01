function [Xb, Yb, Zb, P] =  BoxMaker(L,W,H,Cbn,Offset)

% Cbn - orientation of body frame relative to inertial
% Offset - position of the geometric center of the box

%surf(Xb,Yb,Zb,'FaceColor','b') %to plot box
%patch(P(1,1:4),P(2,1:4),P(3,1:4),'FaceColor','b') %and
%patch(P(1,5:8),P(2,5:8),P(3,5:8),'FaceColor','b') %to plot end caps.



CornPos = 0.5*[ L  L -L -L L  L -L -L;
                W -W -W  W W -W -W  W;
               -H -H -H -H H  H  H  H];

           
           
CornPosRot = transpose(Cbn)*CornPos;

CornPosRot = CornPosRot + Offset;

Xb(1,:) = [CornPosRot(1,1:4), CornPosRot(1,1)];
Xb(2,:) = [CornPosRot(1,5:8), CornPosRot(1,5)];

Yb(1,:) = [CornPosRot(2,1:4),CornPosRot(2,1)]; 
Yb(2,:) = [CornPosRot(2,5:8),CornPosRot(2,5)];

Zb(1,:) = [CornPosRot(3,1:4), CornPosRot(3,1)];
Zb(2,:) = [CornPosRot(3,5:8), CornPosRot(3,5)];

P = CornPosRot;









end

