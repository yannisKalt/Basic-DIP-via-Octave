% myBandPassIdeal(cutOffLow, cutOffHigh, M): IBPF Generation 
% 
%   - cutOffLow: Low cut-off frequency 
% 
%   - cutOffHigh: High cut-off frequency 
% 
%   - M: Filter Dimentions (MxM) 
%
%   - filtOut: Ideal Band Pass Filter

function filtOut = myBandPassIdeal(cutOffLow, cutOffHigh, M)
    [Y, X] = meshgrid(1:M, 1:M);

    % center at [ceil(M/2), ceil(M/2)] since grid starts from [1,1].
    % center Would be (floor[M/2], floor[M/2]) if grid started from [0,0].
    center = ceil(M/2);
    
    D = sqrt((X - center).^ 2 + (Y - center).^2);
    filtOut = double((D >= cutOffLow) .* (D <= cutOffHigh));
end
