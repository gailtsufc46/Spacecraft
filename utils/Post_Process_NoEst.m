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
constraint = zeros(1,length(tout));
I3 = [0 0 1]';
for lv1 = 1:length(tout)
    r = norm(xout(1:3,lv1));
    telasped = tout(lv1)+day2sec*(start_epoch-mag_epoch);
    ba = EarthMagField(xout(1:3,lv1),telasped);
    if length(xout(:,1))==27
        Cba = reshape(xout(7:15,lv1),[3 3]);
        constraint(lv1) = det(Cba)-1; 
    else
        Cba = Quat2DCM(xout(7:10,lv1));
        constraint(lv1) = xout(7:9,lv1)'*xout(7:9,lv1)+xout(10,lv1)^2-1;
    end
    E(lv1) = Etot(xout(:,lv1),r,Cba,ba,params);
    [phi, theta, psi] = DCM2Euler321(Cba);
    eulerAngs(:,lv1) = [phi; theta; psi];
    
end






