% myBandPassButterworth (cutOffLow, cutOffHigh, n, M): BBPF Generation 
% 
%   - cutOffLow: Low cut-off frequency 
% 
%   - cutOffHigh: High cut-off frequency 
%
%   - n: Butterworth's filter order
% 
%   - M: Filter Dimentions (MxM) 
%
%   - filtOut: Butterworth Band Pass Filter

function filtOut = myBandPassButterworth(cutOffLow, cutOffHigh, n, M)
    W = cutOffHigh -cutOffLow; 
    D0 = (cutOffHigh + cutOffLow) / 2;
    filtOut = 1 - butterworthBandStop(W, D0, M, n);
end

function BBSF = butterworthBandStop(W, D0, M, n)
    [Y, X] = meshgrid(1:M, 1:M);
    center = ceil(M/2);

    D = sqrt((X - center).^ 2 + (Y - center).^ 2);
    BBSF = 1 ./ (1 + ((D .* W) ./ (D.^2 - D0 ^ 2)) .^ (2 * n));
end

