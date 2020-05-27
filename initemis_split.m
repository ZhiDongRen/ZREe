function [MI,SIGMA]=initemis(O,N)
%
% Syntax: [MI,SIGMA]=initemis(O,N);
%
% initializes means and st. deviations of N state HMM. Pb. distributions
% are mono-gaussian with diag. cpvar matrix given by vectors of st. deviations
% O is matrix of observation vectors (P x T)
% N is nb. of states, including the first-entry and last-exit, which are
%   non-emitting.
% MI is matrix of means (each column=mean of one state), first and last columns
%   are dummy
% SIGMA is matrix of std (each column=std of one state), first and last columns
%   are dummy
 
[P,T]=size(O);
if T<N
 error ('Not enough obs. vectors to initialize all states');
end

X=round(linspace(2,N-1,T));

MI=zeros(P,N);
SIGMA=zeros(P,N);

for i=2:(N-1)
  ggg=find(X==i);
  MI(:,i) = mean (O(:,ggg)')';
  SIGMA(:,i) = std (O(:,ggg)')';
end

