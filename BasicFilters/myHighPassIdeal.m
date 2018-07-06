% myHighPassIdeal(cutOff, M): MxM IHPF Generation 
% 
%   - cutOff: cut-off frequency for the filter 
%
%   - M: The IHPF shall be a squared MxM filter 
%
%   - filtOut: MxM IHPF (DFT representation) 

%  Note: The smaller the cutOff freq, the higher the 
%        the ringing effect and vice versa. 

function filtOut = myHighPassIdeal(cutOff, M)
    filtOut = 1 - myLowPassIdeal(cutOff, M);
end
