function Lacf = lag_acf (s,lseg,rseg,Lmin,Lmax,thr) 
% function Lacf = lag_acf (s,lseg,rseg,Lmin,Lmax,thr); 
%
% estimation of lags by autocorrelation. 
% Lacf - computed lags in a row vector - lag in samples in case frame is voiced, 
%   zero otherwise. 
% s - signal in a row vector. 
% lseg - length of window 
% rseg - overlap of window 
% Lmin - minimum lag, for 8000 Hz use 20. 
% Lmax - maximum lag, for 8000 Hz and 160 sample frames, use something like 150. 
% thr - threshold to determine voiceness - in case Rmax > thr * R[0], voiced
%                                                  Rmax <= thr * R[0], unvoiced
%   reasonable value is 0.3 

sr = frame (s,lseg,rseg); 
Nfr = size (sr,2); 
Lacf = zeros (1,Nfr); 

for n = 1:Nfr 
  x = sr(:,n); 
  R = xcorr (x); 
  R = R(lseg:end); 
  [Rmax,ii] = max(R((Lmin+1):(Lmax+1)));  % needs to add 1 because of Matlab indexing
  if Rmax >= thr * R(1)  % R[0] in Matlab indexing 
    L=ii+Lmin-1;         % and here needs to remove it again... 
  else
    L=0;
  end
 Lacf (n) = L; 
end
