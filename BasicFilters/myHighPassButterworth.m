% myHighPassButterworth(cutOff, n, M): MxM BHPF Generation 
% 
%   - cutOff: cut-off frequency for the filter 
% 
%   - n: Butterworth's filter order. 
% 
%   - M: The HP-Butterworth shall be a squared MxM filter. 
%
%   - filtOut: MxM BHPF (DFT representation). 

%  Notes: 
%       * The higher the order, the BHPF seems like an IHPF. 
%       * The lower the order, the BHPF seems like a GHPF, 
%         although the sharpening is more aggressive.
%       * No visible ringing effect for low orders.
%       * Usually order 2 BPLF is a good compromise between
%         effective HP-filtering and acceptable ringing. 

function filtOut = myHighPassButterworth(cutOff, n, M)
    filtOut = 1 - myLowPassButterworth(cutOff, n, M);
end
