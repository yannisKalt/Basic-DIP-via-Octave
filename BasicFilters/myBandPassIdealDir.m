% myBandPassIdealDir(cutOffLow, cutOffHigh, M, theta, phi):Directional IBPF Generation 
% 
%   - cutOffLow: Low cut-off frequency 
% 
%   - cutOffHigh: High cut-off frequency 
% 
%   - M: Filter Dimentions (MxM) 
%
%   - (theta, phi): Directional Parameters.
%
%   - filtOut: Directional IBPF

function filtOut = myBandPassIdealDir(cutOffLow, cutOffHigh, M, theta, phi)

    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create IBPF
    idealBP = myBandPassIdeal(cutOffLow, cutOffHigh, M);

    filtOut = directiongrid .* idealBP;
end


