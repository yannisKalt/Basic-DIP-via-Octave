% myLowPassButterworth(cutOff, n, M): MxM BLPF Generation 
% 
%   - cutOff: cut-off frequency for the filter 
% 
%   - n: Butterworth's filter order.
% 
%   - M: The LP-Butterworth shall be a squared MxM filter. 
%
%   - filtOut: MxM BLPF (DFT representation).

%  Notes:
%       * The higher the order, the BLPF seems like an ILPF.
%       * The lower the order, the BLPF seems like a GLPF,
%         although the smoothing is more aggressive.
%       * No visible ringing effect for low orders.
%       * Usually order 2 BPLF is a good compromise between
%         effective LP-filtering and acceptable ringing.


function filtOut = myLowPassButterworth(cutOff, n, M)

    [Y, X] = meshgrid(1:M, 1:M);

    % center at [ceil(M/2), ceil(M/2)] since grid starts from [1,1].
    % center Would be (floor[M/2], floor[M/2]) if grid started from [0,0].
    center = ceil(M/2);
   
    D = sqrt((X - center).^ 2 + (Y - center).^ 2);
    filtOut = 1 ./ (1 + (D ./ cutOff) .^ (2 * n)); 

end
