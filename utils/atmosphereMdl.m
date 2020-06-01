function [fa_a, taua_b] = atmosphereMdl(t,x,Cba,params)
% Usage: [fa_a, taua_a] = atmosphereMdl(t,x,Cba,params)
% 
% Written by Garrett Ailts
%
% Description: Function takes in the time, state, and parameters for a
% spacecraft in orbit around earth and returns the aerodynamics force and
% torque on the spacecraft
%
% Inputs: 
%   t       -  current time in seconds
%   x       -  17 x 1 or 27 x 1 column matrix of the spacecraft state
%   Cba     -  3 x 3 DCM representing the attitude of the spacecraft
%              relative to the ECI frame
%
% Outputs:
%   fa_a    - 3 x 1 column matrix representing the aerodynamic force on the
%             spacecraft resolved in the ECI frame
%   taua_b  -  3 x 1 column matrix representing the aerodynamic torque on
%              the spacecraft resolved in the body frame
%

%% Constants
deg2rad = pi/180;
m2km = 1/1000;

%% Extract Necessary Parameters
t0 = params.sc.start_epoch;
faces = params.sc.faces;
drag_mdl = params.sc.drag_mdl;
Cd = params.sc.Cdrag;
Asph = params.sc.Asph;
JDoffset = params.JDoffset;
atmDen_mdl = params.Earth.atmDen_mdl;

%% Get Geodetic Coord., Year, and Day of Year For Jacchia Bowman Model
calDate = datevec(t0+t-JDoffset); % get current calendar date
% year = calDate(1);
% calDate(1) = 0;
% doy = round(datenum(calDate));

lla = eci2lla(x(1:3)',calDate, 'IAU-2000/2006'); % [y-x-z] geodetic
persistent first
if isempty(first)
    first = true;
end
if strcmp(atmDen_mdl,'Jacchia 70')
    jacchiaIn = params.Earth.jacchiaInput;
    if first
        j70iniz; % initialize Jacchia 70 model
        first = false;
    end
        
    % Citation for model used below:
    % David Eagle (2020). A MATLAB Implementation of the Jacchia 
    % Atmosphere Model (https://www.mathworks.com/matlabcentral/
    % fileexchange/41752-a-matlab-implementation-of-the-jacchia-atmosphere
    % -model), MATLAB Central File Exchange. Retrieved April 26, 2020.
    jacchiaIn(1) = lla(3)*m2km;
    jacchiaIn(2) = lla(1)*deg2rad;
    jacchiaIn(3) = lla(2)*deg2rad;
    jacchiaIn(4) = calDate(1);
    jacchiaIn(5) = calDate(2);
    jacchiaIn(6) = calDate(3);
    jacchiaIn(7) = calDate(4);
    jacchiaIn(8) = calDate(5);
    outdata = jatmos70(jacchiaIn);
    rhoa_a = outdata(10);
elseif strcmp(atmDen_mdl,'US Standard Atmosphere')
    rhoa_a = usDensity(x,params.Earth);
elseif strcmp(atmDen_mdl,'JacchiaBowman') 
    [~, rhoa_a] = densityJB2006(lla(2),lla(1),lla(3),year,doy); 
    % This model needs to be converted to a mex file to run properly.
    % Current version is too computationally expensive
else
    error('Invalid atmosphere model. Please specify one of the available models in the earthParams.txt file\n');
end

%% Calculate Effective Drag Area and Center of Pressure
Aeff = 0;
cnum = 0;
cden = 0;
vmag = norm(x(4:6));
vhat_a = x(4:6)/norm(x(4:6));
vhat_b = Cba*vhat_a;
for lv1 = 1:6
    % extract constituent vectors
    n_b = faces(lv1).n;
    rho_b = faces(lv1).rho;
    n_a = Cba'*n_b;
    A = faces(lv1).A;
    flowDot_a = (n_a'*vhat_a);
    flowDot_b = (n_b'*vhat_b);
    
    % Sum effective area and cpa num and den
    if flowDot_a>0
        Aeff = Aeff+flowDot_a*A;
    end
    if flowDot_b>0
        cnum = cnum + rho_b*flowDot_b*A;
        cden = cden + flowDot_b*A;
    end
end

cpa = cnum/cden;

%% Perform Drag Force and Torque Calculation
if strcmp(drag_mdl,'FMF')
    fa_a = -rhoa_a*vmag^2*vhat_a*Aeff;
elseif strcmp(drag_mdl,'Spherical')
    fa_a = -0.5*rhoa_a*vmag^2*Cd*Asph*vhat_a;
end
taua_b = crossMatrix(cpa)*Cba*fa_a;