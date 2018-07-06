% myLowPassGaussDir(sigma, M, theta, phi): MxM Directional GLPF Generation 
% 
%   - sigma: Standard Deviation (spread around the origin) 
%            It is used in the same manner as cutOff freq. 
% 
%   - M: Filter size (MxM)
%
%   - (theta, phi): Directional Parameters.
%
%   - filtOut: MxM Directional GLPF (DFT representation). 

function filtOut = myLowPassGaussDir(sigma, M, theta, phi)
   
    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create GLPF 
    gaussianLP = myLowPassGauss(sigma, M);

    filtOut = directiongrid .* gaussianLP;
end
