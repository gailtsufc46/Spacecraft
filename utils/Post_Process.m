%% Post Processing Script
% Written by Garrett Ailts

%% Preallocate
E = zeros(1,length(t));


%% Compute System Energy
for lv1 = 1:length(t)
    E(lv1) = Ep(xout(:,lv1),params);
end
    