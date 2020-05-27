function Lnccf = lag_nccf (s,lseg,rseg,Lmin,Lmax,thr) 
% function Lnccf = lag_nccf (s,lseg,rseg,Lmin,Lmax,thr); 
%
% estimation of lags by normalized cross-correlation 
% Lnccf - computed lags in a row vector - lag in samples in case frame is voiced, 
%   zero otherwise. 
% s - signal in a row vector. 
% lseg - length of window 
% rseg - overlap of window 
% Lmin - minimum lag, for 8000 Hz use 20. 
% Lmax - maximum lag, for 8000 Hz and 160 sample frames, use something like 150. 
% thr - threshold to determine voiceness - in case Rmax > thr * R[0], voiced
%                                                  Rmax <= thr * R[0], unvoiced
%   reasonable value is 0.7 

s = s(:)'; % this makes a row vector out of anything. 
sr = frame (s,lseg,rseg); 
Nfr = size (sr,2);  % just for fun as I am too lazy to retype the formula from 
   % lectures, these frames will be never used ... 

% prepare a version of s from which the shifted signal will be taken. Can have problems
% at the beginning, so pre-prend Lmax zeros at the beginning. 
% this signal will need special indexing, with an index always += Lmax. 
saux = [zeros(1,Lmax) s]; 

Lnccf = zeros (1,Nfr); 
from = 1; to = from + lseg - 1;
for fr = 1:Nfr 
  selected = s(from:to);  % nonshifted frame
  E1 = sum(selected .^ 2); % energy of non-shifted frame.  

  Rnccf = zeros(1,Lmax + 1); 
  for n = [0 Lmin:Lmax]
    froms = from-n+Lmax; tos = to-n+Lmax; % indexes of the shifted frame
                                          % Lmax is there because of the zeros
                                          % added at the beginning !
    shifted = saux(froms:tos); 
%    plot(1:160,selected,1:160,shifted); pause; 
    E2 = sum(shifted .^ 2); % energy of the shifted one
    numerator = selected * shifted'; 
    nccf = numerator / sqrt(E1 * E2);
    Rnccf(n+1) = nccf;  % Matlab indexing. 
  end
%  gg = 0:Lmax; plot (gg, Rnccf); pause
  [Rmax,ii] = max(Rnccf((Lmin+1):(Lmax+1)));  % needs to add 1 because of Matlab indexing
  if Rmax >= thr * Rnccf(1)  % R[0] in Matlab indexing 
    L=ii+Lmin-1;         % and here needs to remove it again... 
  else
    L=0;
  end
  Lnccf(fr) = L; 
  from = from + lseg - rseg; to = from + lseg - 1; % new frame
end
