% myBandPassButterworthDir(cutOffLow, cutOffHigh, n, M, theta, phi): DBBPF Generation 
% 
%   - cutOffLow: Low cut-off frequency 
% 
%   - cutOffHigh: High cut-off frequency 
%
%   - n: Butterworth's filter order
%
%   -(theta, phi): Directional Parameters
% 
%   - M: Filter Dimentions (MxM) 
%
%   - filtOut: Directional Butterworth Band Pass Filter.

function filtOut = myBandPassButterworthDir(cutOffLow, cutOffHigh, n, M, theta, phi)

    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create BBPF 
    butterworthBP = myBandPassButterworth(cutOffLow, cutOffHigh, n, M);

    filtOut = directiongrid .* butterworthBP;
end
