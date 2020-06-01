%% Course Project Part 1: Intro, Attitude Parameterization and Kinematics
% AEM 4305: Spacecraft Dynamics
% Garrett Ailts

%% Test DCM2Quat
C_ba = [0.8995 0.3870 -0.2026;
        -0.3201 0.8995 0.2974;
        0.2974 -0.2026 0.9330];
qtest = [0.1294 0.1294 0.1830 0.9659]';
fprintf('DCM2Quat should return:\n');
disp(qtest);
q = DCM2Quat(C_ba);
fprintf('DCM2Quat returns:\n');
disp(q);
if ismembertol(qtest,q,1e-4)
    fprintf('Success!\n');
else
    fprintf('Failure!\n');
end

%% Test DCM2Euler321
phit = 0.3086; thetat = 0.2040; psit = 0.4063;
fprintf('DCM2Euler321 should return:\n');
fprintf('phi = %.4f, theta = %.4f, psi = %.4f\n',phit,thetat,psit);
[psi, theta, phi] = DCM2Euler321(C_ba);
fprintf('DCM2Euler321 returns:\n');
fprintf('phi = %.4f, theta = %.4f, psi = %.4f\n',phi,theta,psi);
etest = [phit thetat psit]'; eactual = [phi theta psi]';
if ismembertol(etest,eactual,1e-4)
    fprintf('Success!\n');
else
    fprintf('Failure!\n');
end

