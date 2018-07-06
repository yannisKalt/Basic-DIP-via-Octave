% myHighPassGauss(sigma, M): MxM GHPF Generation 
% 
%   - sigma: Standard Deviation (spread around the origin) 
% 
%   - M: The HP-Gaussian shall be a squared MxM filter. 
%
%   - filtOut: MxM GHPF (DFT representation).

%  Notes: 
%       * Smoother filtering than BHPF without artifacts 
%         caused by ringing effects. 

function filtOut = myHighPassGauss(sigma, M)
    filtOut = 1 - myLowPassGauss(sigma, M);
end
