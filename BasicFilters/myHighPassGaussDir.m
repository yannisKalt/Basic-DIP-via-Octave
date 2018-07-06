% myHighPassGaussDir(sigma, M, theta, phi): MxM Directional GHPF Generation 
% 
%   - sigma: Standard Deviation (spread around the origin) 
%            It is used in the same manner as cutOff freq. 
% 
%   - M: Filter size (MxM)
%
%   - (theta, phi): Directional Parameters.
%
%   - filtOut: MxM Directional GHPF (DFT representation). 

function filtOut = myHighPassGaussDir(sigma, M, theta, phi)
   
    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create GHPF 
    gaussianHP = myHighPassGauss(sigma, M);

    filtOut = directiongrid .* gaussianHP;
end
