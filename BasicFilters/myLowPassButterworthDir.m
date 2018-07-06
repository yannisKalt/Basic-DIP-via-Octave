% myLowPassButterworthDir(cutOff, n, M, theta, phi): MxM Directional BLPF Generation 
% 
%   - cutOff: cut-off frequency for the filter 
% 
%   - n: Butterworth's filter order
% 
%   - M: filter size (MxM) 
%
%   - (theta, phi): Directional Parameters.
%
%   - filtOut: MxN Directional BLPF (DFT representation).

function filtOut = myLowPassButterworthDir(cutOff, n, M, theta, phi)

    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create BLPF
    butterworthLP = myLowPassButterworth(cutOff, n, M);

    filtOut = directiongrid .* butterworthLP;
end
