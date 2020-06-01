function j70iniz

% Jacchia 1970 atmosphere initialization

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global bdata alpha ei altmin ng cz iday cgauss xgauss

bdata(1) = 28.15204;
bdata(2) = -0.085586;
bdata(3) = 0.0001284;
bdata(4) = -0.000010056;
bdata(5) = -0.00001021;
bdata(6) = 0.0000015044;
bdata(7) = 0.000000099826;

alpha(1) = 0;
alpha(2) = 0;
alpha(3) = 0;
alpha(4) = 0;
alpha(5) = -0.38;
alpha(6) = 0;

ei(1) = 28.0134;
ei(2) = 31.9988;
ei(3) = 15.9994;
ei(4) = 39.948;
ei(5) = 4.0026;
ei(6) = 1.00797;

% minimum altitude array

altmin(1) = 90;
altmin(2) = 105;
altmin(3) = 125;
altmin(4) = 160;
altmin(5) = 200;
altmin(6) = 300;
altmin(7) = 500;
altmin(8) = 1500;
altmin(9) = 2500;
 
ng(1) = 4;
ng(2) = 5;
ng(3) = 6;
ng(4) = 6;
ng(5) = 6;
ng(6) = 6;
ng(7) = 6;
ng(8) = 6;

% fairing coefficients

cz(1) = 1;
cz(2) = 0.9045085;
cz(3) = 0.6545085;
cz(4) = 0.3454915;
cz(5) = 9.54915e-02;
cz(6) = 0;

% month data

iday = [31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31];

% coefficients for gaussian quadrature

dtmp = [0.5555556;  0.8888889;  0.5555556;  0.0000000;
        0.0000000;  0.0000000;  0.0000000;  0.0000000;
        0.3478548;  0.6521452;  0.6521452;  0.3478548;
        0.0000000;  0.0000000;  0.0000000;  0.0000000;
        0.2369269;  0.4786287;  0.5688889;  0.4786287;
        0.2369269;  0.0000000;  0.0000000;  0.0000000;
        0.1713245;  0.3607616;  0.4679139;  0.4679139;
        0.3607616;  0.1713245;  0.0000000;  0.0000000;
        0.1294850;  0.2797054;  0.3818301;  0.4179592;
        0.3818301;  0.2797054;  0.1294850;  0.0000000;
        0.1012285;  0.2223810;  0.3137067;  0.3626838;
        0.3626838;  0.3137067;  0.2223810;  0.1012285];
     
k = 0;
     
for i = 1:1:6
    for j = 1:1:8
        cgauss(j, i) = dtmp(j + k);
    end   
    k = k + 8; 
end

% abscissas for gaussian quadrature

dtmp = [-0.7745967;  0.0000000;  0.7745967;  0.0000000;
         0.0000000;  0.0000000;  0.0000000;  0.0000000;
        -0.8611363; -0.3399810;  0.3399810;  0.8611363;
         0.0000000;  0.0000000;  0.0000000;  0.0000000;
        -0.9061798; -0.5384693;  0.0000000;  0.5384693;
         0.9061798;  0.0000000;  0.0000000;  0.0000000;
        -0.9324695; -0.6612094; -0.2386192;  0.2386192;
         0.6612094;  0.9324695;  0.0000000;  0.0000000;
        -0.9491079; -0.7415312; -0.4058452;  0.0000000;
         0.4058452;  0.7415312;  0.9491079;  0.0000000;
        -0.9602899; -0.7966665; -0.5255324; -0.1834346;
         0.1834346;  0.5255324;  0.7966665;  0.9602899];
      
k = 0;
     
for i = 1:1:6
    for j = 1:1:8
        xgauss(j, i) = dtmp(j + k);
    end   
    k = k + 8; 
end
      