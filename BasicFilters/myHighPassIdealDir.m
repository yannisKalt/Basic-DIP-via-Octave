% myHighPassIdealDir(cutOff, M, theta, phi): MxM Directional IHPF Generation 
% 
%   - cutOff: cut-off frequency for the filter 
%
%   - M: Filter size (MxM) 
%
%   - (theta, phi): Directional Parameters
%
%   - filtOut: MxM IHPF (DFT representation) 

function filtOut = myHighPassIdealDir(cutOff, M, theta, phi)
    
    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create IHPF
    idealHP = myHighPassIdeal(cutOff, M);

    filtOut = directiongrid .* idealHP;
end
