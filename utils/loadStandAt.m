function Earth = loadStandAt(Earth)
% Usage: params = loadStandAt(t,x,params) 
%
% Written by Garrett Ailts
%
% Description: Loads coefficients from the US Standard Atmosphere model for
%              alitudes between 120 km and 1000 km and adds the matrix of
%              coefficients to an input struct of Earth parameters
%
%

%% US Standard Atmosphere Coefficents (120 to 1000 km)
% See table 8 on this page for refeference: http://www.braeunig.us/space/
% atmmodel.htm.
% Based of coeffs from U.S. Standard Atmosphere 1976

Coeffs = [3.661771e-7 -2.154344e-4 0.04809214 -4.884744 172.3597;
          1.906032e-8 -1.527799e-5 0.004724294 -0.6992340 20.50921;
          1.199282e-9 -1.451051e-6 6.910474e-4 -0.1736220 -5.321644;
          1.140564e-10 -2.130756e-7 1.570762e-4 -0.07029296 -12.89844;
          8.105631e-12 -2.358417e-9 -2.635110e-6 -0.01562608 -20.02246;
          -3.701185e-12 -8.608611e-9 5.118829e-5 -0.06600998 -6.137674];

hceiling = [150; 200; 300; 500; 750; 1000]; 

%% Store Coefficients and Range Start Altitudes in Struct
Earth.Coeffs = Coeffs;
Earth.hceiling = hceiling;

end
            
          



