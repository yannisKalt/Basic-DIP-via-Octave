% myHighPassButterworthDir(cutOff, n, M, theta, phi): MxM Directional BHPF Generation 
% 
%   - cutOff: cut-off frequency for the filter 
% 
%   - n: Butterworth's filter order
% 
%   - M: filter size (MxM) 
%
%   - (theta, phi): Directional Parameters.
%
%   - filtOut: MxM Directional BHPF (DFT representation).

function filtOut = myHighPassButterworthDir(cutOff, n, M, theta, phi)

    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create BHPF
    butterworthHP = myHighPassButterworth(cutOff, n, M);

    filtOut = directiongrid .* butterworthHP;
end
