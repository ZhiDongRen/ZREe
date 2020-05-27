function [A,G,L,Nram] = param2 (sm,lram,pram,P,Lmin,Lmax,thr) 
% function [A,G,L,Nram] = param2 (sm,lram,pram,P,Lmin,Lmax,thr); 
% 
% mega-parameterization function
% A - matrix with predictor coefficients (each vector in a column, no a0 coefficient) 
% G - vector with gains (row, each element is one gain). 
% L - vector with lags (row), if frame unvoiced, zero. 
% Nram - is the number of frames
%
% parameters are 
% sm - signal (should be centered) 
% lram - length of analysis window - usually 160
% pram - overlap of analysis window - set this to 0 ! 
% P - predictor order, set this usually to 10. 
% Lmin - minimum lag, for 8000 Hz use 20. 
% Lmax - maximum lag, for 8000 Hz and 160 sample frames, use something like 150. 
% thr - threshold to determine voiceness - in case Rmax > thr * R[0], voiced
%                                                  Rmax <= thr * R[0], unvoiced
%   reasonable value is 0.7 
% the function uses NCCF + median of 5th order to detect lag 

sr = frame (sm, lram, pram); % no overlap !

Nram = size(sr,2);    % number of frames 
A = zeros (P,Nram); % will store them without a0=1 ! 
G = zeros (1,Nram); 

for n=1:Nram
  [a,e] = lpc(sr(:,n), 10); 
  a = a(2:(P+1))';         % discrading a0 = 1
  A(:,n) = a; 
  G(n) = sqrt(e); 
end

Lnccf = lag_nccf (sm,lram,pram,Lmin,Lmax,thr); 
L = medfilt1 (Lnccf,5); 
