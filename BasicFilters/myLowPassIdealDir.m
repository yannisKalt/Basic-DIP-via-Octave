% myLowPassIdealDir(cutOff, M, theta, phi): MxM Directional ILPF Generation.
%
%   - cutOff: cut-off frequency for the filter 
% 
%   - M: Filter size (MxM)
%
%   - (theta, phi): Directional Filter Parameters 
%
%   - filtOut: MxM Directional ILPF (DFT representation).  

function filtOut = myLowPassIdealDir(cutOff, M, theta, phi)
    
    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create ILPF
    idealLP = myLowPassIdeal(cutOff, M);

    filtOut = directiongrid .* idealLP;
end
