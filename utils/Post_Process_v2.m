%% Post_Process_v2
% Written by Garrett Ailts
%% Constants
day2sec = 86400;

%% Extract Necessary Parameters
mag_epoch = params.Earth.mag_epoch;
start_epoch = params.sc.start_epoch;


%% Calculate Total Energy, Euler Angles, and Attitude Constraint
E = zeros(1,length(tout));
eulerAngs = zeros(3,length(tout));
eulerEstErr_IN = zeros(3,length(tout));
eulerEstErr_TRIAD = zeros(3,length(tout));
constraint = zeros(1,length(tout));
constrainthat = zeros(1,length(tout));
q_TRIAD = zeros(4,length(tout));
I3 = [0 0 1]';
for lv1 = 1:length(tout)
    r = norm(xout(1:3,lv1));
    telasped = tout(lv1)+day2sec*(start_epoch-mag_epoch);
    ba = EarthMagField(xout(1:3,lv1),telasped);
    if length(xout(:,1))==27
        Cba = reshape(xout(7:15,lv1),[3 3]);
        Cea_IN = reshape(xout(19:27,lv1),[3 3]);
        constraint(lv1) = det(Cba)-1;
        constrainthat(lv1) = det(Cea_IN)-1;   
    else
        Cba = Quat2DCM(xout(7:10,lv1));
        Cea_IN = Quat2DCM(xout(14:17,lv1));
        constraint(lv1) = xout(7:9,lv1)'*xout(7:9,lv1)+xout(10,lv1)^2-1;
        constrainthat(lv1) = xout(14:16,lv1)'*xout(14:16,lv1)+ ...
                                                        xout(17,lv1)^2-1;
    end
    
    % TRIAD algorithm
    s1_a = -xout(1:3,lv1);
    s2_a = ba;
    s1_b = EarthSensorNoisy(s1_a,Cba,tout(lv1));
    s2_b = MagnetometerNoisy(s2_a,Cba,tout(lv1)); 
    
    Cea_TRIAD = TRIAD(s1_a,s2_a,s1_b,s2_b);
    q_TRIAD(:,lv1) = DCM2Quat(Cea_TRIAD);
    
    E(lv1) = Etot(xout(:,lv1),r,Cba,ba,params);
    [phi, theta, psi] = DCM2Euler321(Cba);
    Ceb_IN = Cea_IN*Cba'; % error DCM between estimated frame and body frame
    Ceb_TRIAD = Cea_TRIAD*Cba';
    [phierr_IN, thetaerr_IN, psierr_IN] = DCM2Euler321(Ceb_IN);
    [phierr_TRIAD, thetaerr_TRIAD, psierr_TRIAD] = DCM2Euler321(Ceb_TRIAD);
    eulerAngs(:,lv1) = [phi; theta; psi];
    eulerEstErr_IN(:,lv1) = [phierr_IN; thetaerr_IN; psierr_IN];
    eulerEstErr_TRIAD(:,lv1) = [phierr_TRIAD; thetaerr_TRIAD; psierr_TRIAD];
end






