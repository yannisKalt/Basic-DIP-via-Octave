% myLowPassIdeal(cutOff, M): MxM ILPF Generation 
%
%   - cutOff: cut-off frequency for the filter 
% 
%   - M: The ILPF shall be a squared MxM filter. 
%
%   - filtOut: MxM ILPF (DFT representation).  

%  Note: 
%      *The smaller the cutOff freq, the higher the ringing effect 
%        and vice versa.            

function filtOut = myLowPassIdeal(cutOff, M)
    
    [Y, X] = meshgrid(1:M, 1:M);

    % center at [ceil(M/2), ceil(M/2)] since grid starts from [1,1].
    % center Would be (floor[M/2], floor[M/2]) if grid started from [0,0].
    center = ceil(M/2);
    filtOut = double(sqrt((X - center).^2 + (Y - center).^2) <= cutOff); 
end


