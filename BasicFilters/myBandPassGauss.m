% myBandPassGauss (sigmaLow, sigmaHigh, M): GBPF Generation 
% 
%   - sigmaLow: Low cut-off frequency (like cutOffLow) 
% 
%   - sigmaHigh: High cut-off frequency (like cutOffHigh) 
%
%   - M: Filter Dimentions (MxM) 
%
%   - filtOut: Gaussian Band Pass Filter

function filtOut = myBandPassGauss(sigmaLow, sigmaHigh, M)

    W = sigmaHigh -sigmaLow; 
    D0 = (sigmaHigh + sigmaLow) / 2;
    filtOut = 1 - gaussianBandStop(W, D0, M);
end


function GBSF = gaussianBandStop(W, D0, M)
    [Y, X] = meshgrid(1:M, 1:M);
    center = ceil(M/2);
    D = sqrt((X - center).^ 2 + (Y - center).^ 2);
    GBSF = 1 - exp(-( (D.^2 - D0^2) ./ (D .* W) ) .^ 2);
end
