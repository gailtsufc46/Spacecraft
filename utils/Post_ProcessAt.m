%% Post_ProcessAt
% Script that post processes attitude sim data
% Written by Garrett Ailts

%% Calculate Rotational Energy
T = Eang(xout,params);

%% Extract Euler Angles
eulerAngs = zeros(3,length(T));
if strcmp(AttType,'quaternion')
    for i = 1:length(T)
        Cba = Quat2DCM(xout(1:4,i));
        [phi, theta, psi] = DCM2Euler321(Cba);
        eulerAngs(:,i) = [phi; theta; psi];
    end
elseif strcmp(AttType,'DCM')
    for i = 1:length(T)
        [phi, theta, psi] = DCM2Euler321(reshape(xout(1:9,i),[3 3]));
        eulerAngs(:,i) = [phi; theta; psi];
    end
else
    error('Invalide attitude type!\n');
end

%% Quaternion Normality or DCM Determinate
normDet = zeros(1,length(T));
if strcmp(AttType,'quaternion')
    for i = 1:length(T)
        normDet(i) = xout(1:3,i)'*xout(1:3,i)+xout(4,i)^2-1;
    end
elseif strcmp(AttType,'DCM')
    for i = 1:length(T)
        normDet(i) = det(reshape(xout(1:9,i),[3 3]))-1;
    end
else
    error('Invalide attitude type!\n');
end
    
    
    
    
    
    
    