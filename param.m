function [A,G,Nram] = param (wavname,lram,pram,P) 
% [A,G,Nram] = param (wavname,lram,pram,P); 
% does the parameterization to an 
% - A matrix with predictor coefficients (each vector in a column, no a0 coefficient) 
% - G vector with gains (row, each element is one gain). 
% - Nram is the number of frames
% parameters are 
% - name of wav file 
% - length of analysis window - usually 160
% - overlap of analysis window - set this to 0 ! 
% - predictor order, set this usually to 10. 
% the function will subtract the mean of signal 

s = audioread (wavname); 
sm = s - mean(s); 
sr = frame (sm, lram, pram); % no overlap !

Nram = size(sr,2);    % number of frames 
A = zeros (P,Nram); % will store them without a0=1 ! 
G = zeros (1,Nram); 

for n=1:Nram
  [a,e] = lpc(sr(:,n),10); 
  a = a(2:(P+1))';         % discrading a0 = 1
  A(:,n) = a; 
  G(n) = sqrt(e); 
end

