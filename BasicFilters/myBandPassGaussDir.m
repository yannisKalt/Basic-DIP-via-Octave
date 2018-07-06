% myBandPassGaussDir (sigmaLow, sigmaHigh, M, theta, phi): DGBPF Generation 
% 
%   - sigmaLow: Low cut-off frequency (like cutOffLow) 
% 
%   - sigmaHigh: High cut-off frequency (like cutOffHigh) 
%
%   - M: Filter Dimentions (MxM) 
%
%   -(theta, phi): Directional Dimentions.
%
%   - filtOut: Directional Gaussian Band Pass Filter

function filtOut = myBandPassGaussDir(sigmaLow, sigmaHigh, M, theta, phi)

    % Create directional Grid
    directiongrid = directiongrid(theta, phi, M);

    % Create GBPF
    gaussianBP = myBandPassGauss(sigmaLow, sigmaHigh, M);
     
    filtOut = directiongrid .*  gaussianBP;
end
