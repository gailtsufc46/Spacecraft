function Is = wheelMOI(sc)
% Written by Garrett Ailts
%
% Description: Function calculates momentum wheel moment of inertia about
% the body axis aligned with the spin axis. Function assumes 3 wheels with
% spin axes aligned to the spacecraft body axes.
%
%

Is = sc.Iwheel+sc.mwheel.*sc.dwheel.^2;

end