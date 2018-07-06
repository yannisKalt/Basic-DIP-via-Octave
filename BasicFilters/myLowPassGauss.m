% myLowPassGauss(sigma, M): MxM GLPF Generation 
% 
%   - sigma: Standard Deviation (spread around the origin) 
%            It is used in the same manner as cutOff freq. 
% 
%   - M: The LP-Gaussian shall be a squared MxM filter. 
%
%   - filtOut: MxM GLPF (DFT representation). 

%  Notes: 
%       * Smoother filtering than BLPF without artifacts 
%         caused by ringing effects. 


function filtOut = myLowPassGauss(sigma, M)

    [Y, X] = meshgrid(1:M, 1:M);

    % center at [ceil(M/2), ceil(M/2)] since grid starts from [1,1].
    % center Would be (floor[M/2], floor[M/2]) if grid started from [0,0].
    center = ceil(M/2);
   
    D = sqrt((X - center).^ 2 + (Y - center).^ 2);
    filtOut = exp(-(D.^2) ./ (2 * sigma ^ 2)); 
end

