%% Post_Process_v4
% Written by Garrett Ailts
%% Constants
day2sec = 86400;

%% Extract Necessary Parameters
mag_epoch = params.Earth.mag_epoch;
start_epoch = params.sc.start_epoch;
R = params.Earth.Rmean;

%% Calculate Total Energy, Euler Angles, and Attitude Constraint
xout = xout';
E = zeros(1,length(tout));
eulerAngs = zeros(3,length(tout));
constraint = zeros(1,length(tout));
q = zeros(4,length(tout));
h = zeros(1,length(tout)); 

I3 = [0 0 1]';
for lv1 = 1:length(tout)
    r = norm(xout(1:3,lv1));
    telasped = tout(lv1)+day2sec*(start_epoch-mag_epoch);
    h(lv1) = norm(r)-R; 
    ba = EarthMagField(xout(1:3,lv1),telasped);
    if strcmp(AttType,'DCM')
        Cba = reshape(xout(7:15,lv1),[3 3]);
        q(:,lv1) = DCM2Quat(Cba);
        constraint(lv1) = det(Cba)-1;
    else
        Cba = Quat2DCM(xout(7:10,lv1));
        constraint(lv1) = xout(7:9,lv1)'*xout(7:9,lv1)+xout(10,lv1)^2-1;
        
    end

    E(lv1) = Etot(xout(:,lv1),r,Cba,ba,params);
    [phi, theta, psi] = DCM2Euler321(Cba);
    eulerAngs(:,lv1) = [phi; theta; psi];
end
if strcmp(AttType,'DCM')
    wba = xout(16:18,:);
else
    q = xout(7:10,:);      
    wba = xout(11:13,:);   
end





