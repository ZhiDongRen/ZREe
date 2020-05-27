function ss = synthesize(A,G,L,P,lram) 
% ss = syntnoise(A,G,P,lram); 
% 
% synthesizes signal excited by white noise (unvoiced) or periodic pulses (voiced)
% by a matrix with predictor parameters and vector of gains. 
% A - matrix with predictor coefficients (each vector in a column, no a0 coefficient) 
% G - vector with gains (row, each element is one gain). 
% L - lags (row, zero means unvoiced, lag is in samples) 
% P - order of predictor 
% lram - length of window. The function DOES NOT SUPPORT OVERLAPPED FRAMES!
%
% output: 
% ss - a long row vector with the resulting signal. 
%
% the function does not do much error-checking, so if A, G or L are of bad sizes,
% sorry...

Nram = length(G); 
init=zeros(P,1);        % initial conditions of the filter
ss = zeros(1,Nram * lram); % preallocation is needed for long signals. 

% some initial values - position of the next pulse for voiced frames (Matlab indexing)
nextvoiced = 1; 

from = 1; to = from + lram -1; 
for n = 1:Nram
  a = [1; A(:,n)]; % appending with 1 for filtering
  g = G(n); 
  l = L(n); 
  
  % in case the frame is unvoiced, generate noise
  if l == 0 
    excit = randn (1,lram); % this has power one ...
  else % if it is voiced, generate some pulses
    where = nextvoiced:l:lram;
    % ok, this is for the current frame, but where should be the 1st pulse in the 
    % next one ? 
    nextvoiced = max(where) + l - lram; 
    % generate the pulses
    excit = zeros(1,lram); excit(where) = 1;
  end
  % and set the power of excitation  to one - no necessary for noise, but anyway ...
  power = sum(excit .^ 2) / lram; 
  excit = excit / sqrt(power); 
  % check 
%  power = sum(excit .^ 2) / lram
  
  % now just generate the output  
  [synt,final] = filter (g,a,excit,init); 
  init = final; 
  from = from + lram; to = from + lram -1; 
  ss(from:to) = synt; 
end

