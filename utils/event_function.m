function [value,isterminal,direction] = event_function(t,x,params) %#ok<INUSL>
R = params.Earth.Rmean;
if norm(x(1:3))-R<=100e3
    value = 0;
else
    value = 1;
end
isterminal = 1; % terminate after first event
direction = 0; % get all events