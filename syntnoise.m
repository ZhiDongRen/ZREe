function ss = syntnoise(A,G,P,lram); 
% ss = syntnoise(A,G,P,lram); 
% 
% synthesizes signal excited by whte noise out of a matrix with predictor 
% parameters and vector of gains. 
% - A matrix with predictor coefficients (each vector in a column, no a0 coefficient) 
% - G vector with gains (row, each element is one gain). 
% - P order of predictor 
% - lram - length of window. The function does not support overlapped frames. 
% output: 
% - ss is a long row vector with resulting signal. 
% The implementation is quite inefficient so do not dare to synthesize too long signals!

Nram = length(G); 
init=zeros(P,1);        % initial conditions of the filter
ss = [];              % very inefficient, if long signal, pre-allocate !
for n = 1:Nram
  a = [1; A(:,n)]; % appending with 1 for filtering
  g = G(n); 
  excit = randn (1,lram); % this has power one ... 
  [synt,final] = filter (g,a,excit,init); 
  init = final; 
  ss = [ss synt];
end

