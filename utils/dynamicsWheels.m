function xdot = dynamicsWheels(t,x,params)  
% Usage: [tout,xout] = ode45(@(t,x) Coupledyn(t,x,params),tspan,x0,...
%
% Written by Garrett Ailts
%
% Description: Function takes in the current time, state, and a struct of
% simulation parameters for a continuous rigid body's (CRB) angular 
% dynamics using the quaternion or DCM representation and returns the 
% derivative of the state vector
%
% Inputs:
%   t       -  time since t0 (s)
%   x       -  23 x 1 (quaternion) or 33 x 1 (DCM) state vector 
%              representing CRB's attitude and angular rates
%   params  -  struct containing CRB and simulation parameters
%
% Outputs:
%   xdot    -  23 x 1 or 33 x 1 vector containing the rates of change for the state
%              paramters
%

%% Extract Parameters from Struct
% sim
gg_model = params.gg_model;
mag_model = params.mag_model;
atm_model = params.atm_model;
SRP_model = params.SRP_model;
J2on = params.J2on;

% Earth
mu = params.Earth.mu_e;
R = params.Earth.Rmean;
J2 = params.Earth.J2const;
mag_epoch = params.Earth.mag_epoch;

% spacecraft
AttType = params.sc.Attitude_Type;
I = params.sc.IB_b;
m_sc = params.sc.mWet;
start_epoch = params.sc.start_epoch;
mbr = params.sc.mom_b;

est_method = params.sc.est_method;
ke = params.sc.kerror;
kb = params.sc.kbias;

ctrl_method = params.sc.ctrl_method;
kp = params.sc.kprop;
kd = params.sc.kderiv;
kh = params.sc.khmag;
gammaDot_des = params.sc.gammaDot_wdes;
Is = params.sc.Is;
mtorquer = params.sc.mtorquer;
mcoil = params.sc.mcoil;
mmax_b = [mtorquer; mtorquer; mcoil];

%% Useful Values
day2sec = 86400;
I3 = [0 0 1]';
r = norm(x(1:3));
if strcmp(AttType,'DCM')
    Cba = reshape(x(7:15),[3 3]);
    wba = x(16:18);
    gammaDot = x(19:21);
else
    Cba = Quat2DCM(x(7:10));
    wba = x(11:13);
    gammaDot = x(14:16);
end
wbaX = crossMatrix(wba);

%% Check for Earth Impact and J2 Inclusion
if r<=R
    warning('Earth impact!')
end
% Check For J2 Inclusion
if ~J2on
    J2 = 0;
end

%% Forces and Moments
% gravity gradient torque
if gg_model
    tau_gg = (3*mu/r^5)*crossMatrix(Cba*x(1:3))*I*Cba*x(1:3);
else
    tau_gg = 0;
end

% magnetic moment
if mag_model
    telapsed = t+day2sec*(start_epoch-mag_epoch);
    b_a = EarthMagField(x(1:3),telapsed);
    tau_mag = crossMatrix(mbr)*Cba*b_a;
else
    tau_mag = 0;
end

% atmospheric pressure force and torque
if atm_model
    [f_atm, tau_atm] = atmosphereMdl(t,x,Cba,params);
else
    f_atm = 0;
    tau_atm = 0;
end

% solar radiation pressure force
if SRP_model
    f_srp = 0; % placeholder for solar radiation pressure model 
               % implementation
else
    f_srp = 0;
end

force = f_atm+f_srp; % sum of forces besides gravity of primary body
tau_ext = tau_gg+tau_mag+tau_atm; % sum of moments imparted on spacecraft

%% Sensors
% rate gyroscope
wbahat = RateGyroNoisy(wba,t);

% Earth horizon sensor
rpc_b = EarthSensorNoisy(-x(1:3),Cba,t);

if mag_model
    b_b = MagnetometerNoisy(b_a,Cba,t);
end

%% Navigation
if strcmp(est_method,'CF')
    CbaTRIAD = TRIAD(-x(1:3),b_a,rpc_b,b_b);
    bgyro = x(end-2:end); % estimate of gyro bias
    if strcmp(AttType,'DCM')
        % pull estimate from state vector and ensure its normalized
        Cea = reshape(x(22:30),[3 3]);
        CbeTRIAD = CbaTRIAD*Cea';
        e = uncross(CbeTRIAD-CbeTRIAD');
        CeaDot = -crossMatrix(wbahat-bgyro-ke*e)*Cea;
        bgyroDot = -kb*e;
    else
        qhat = x(17:20);
        qTRIAD = DCM2Quaternion(CbaTRIAD);
        qerr = 2*GammaQuat(qhat)'*qTRIAD;
        qhatDot = GammaQuat(qhat)*[(wbahat-bgyro+ke*qerr(4)*qerr(1:3)); 0];
        bgyroDot = -kb*qerr(4)*qerr(1:3); 
    end
elseif strcmp(est_method,'none')
    if strcmp(AttType,'DCM')
        % pull estimate from state vector and ensure its normalized
        CeaDot = zeros(3);
    else
        qhatDot = zeros(4,1);
    end
end

%% Control
if strcmp(ctrl_method,'PD')
    if strcmp(AttType,'DCM')
        qhat = DCM2Quat(Cea);
    end
    tau_wheel = -kp*qhat(1:3)-kd*wbahat;
    tau_wheel(tau_wheel>1e-3) = 1e-3;
    tau_ctrl = tau_wheel;
elseif strcmp(ctrl_method,'PD w/ Mag')
    if strcmp(AttType,'DCM')
        qhat = DCM2Quat(Cea);
    end
    tau_wheel = -kp*qhat(1:3)-kd*wbahat;
    tau_wheel(tau_wheel>1e-3) = 1e-3;
    m_b = -kh.*Is.*((b_b'*b_b)\crossMatrix(b_b)*(gammaDot-gammaDot_des));
    m_b(m_b>mmax_b) = mmax_b(m_b>mmax_b);
    tau_mag = -crossMatrix(b_b)*m_b;
    tau_ctrl = tau_wheel+tau_mag;
elseif strcmp(ctrl_method,'none')
    tau_ctrl = 0;
else
    error('Not a valid control method for this function!\n');
end

%% Orbital Dynamics
% Calculate xdot1 with gravity and other forces    
xdot1 = [x(4:6); -mu*x(1:3)/r^3 + (3*mu*J2*R^2/2/r^5)*(((5/r^2)* ... 
                 (x(1:3)'*I3)-1)*x(1:3)-2*(x(1:3)'*I3)*I3) + force/m_sc];
                           
%% Attitude Dynamics
if strcmp(AttType,'DCM')
    xdot2 = [-wbaX*x(7:9); -wbaX*x(10:12); -wbaX*x(13:15); ...
             I\(tau_ext+tau_ctrl-wbaX*I*wba-wbaX*gammaDot.*Is); ...
                                       -tau_ctrl./Is; CeaDot(:); bgyroDot];
    % DCM calc
else
    xdot2 = [GammaQuat(x(7:10))*[wba;0]; I\(tau_ext+tau_ctrl-wbaX*I*wba ...
                    -wbaX*gammaDot.*Is); -tau_ctrl./Is; qhatDot; bgyroDot];
    % quaternion calculation
end

%% Package Dynamics Together
xdot = [xdot1; xdot2];


end