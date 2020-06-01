function sc = loadFaces(sc)
% Usage: sc = loadFaces(sc)
% 
% Written by Garrett Ailts
%
% Description: Function takes in struct for a cubesat type spacecraft and
% returns the same struct with objects for each of the faces added to the
% struct. Each face object contains the face unit normal vector resolved in
% the body frame along with the face area.
%
% Inputs: sc  -  struct with parameters describing a spacecraft with a
%                cubesat form factor
%
% Outputs: sc  -  same input struct but with additional sub objects
%                 defining the faces of the spacecraft
%

%% Extract Spacecraft Dimensions
h = sc.height;
s = sc.side;
Asmall = s^2;
Alarge = h*s;
rcz = sc.rcz;

%% Get Face Normal Vectors In Body Frame
faces(1).n = [-1; 0; 0]; % face with tuna can volumes (we ignore them as surfaces here)
faces(2).n = [1; 0; 0];
faces(3).n = [0; 0; 1];
faces(4).n = [0; -1; 0];
faces(5).n = [0; 0; -1];
faces(6).n = [0; 1; 0];

%% Calculate Distance of Faces to Spacecraft Center of Mass (rho)
% rho vecs relative to point z
rho = zeros(3,6);
rho(:,1) = [0; s/2; s/2];
rho(:,2) = [h; s/2; s/2];
rho(:,3) = [h/2; s/2; s];
rho(:,4) = [h/2; 0; s/2];
rho(:,5) = [h/2; s/2; 0];
rho(:,6) = [h/2; s; s/2];

% rho vecs relative to center of mass
rho = rho-rcz;

%% Add Areas to face objects
for lv1 = 1:6
    if lv1<3
        faces(lv1).A = Asmall;
    elseif lv1>2
        faces(lv1).A = Alarge;
    end
    faces(lv1).rho = rho(:,lv1);
end

sc.faces = faces;
end