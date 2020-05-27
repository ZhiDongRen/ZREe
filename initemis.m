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
% this version initializes everything to global mean and std ! 
 
[P,T]=size(O);

MI=zeros(P,N);
SIGMA=zeros(P,N);

for i=2:(N-1)
  MI(:,i) = mean (O')';
  SIGMA(:,i) = std (O')';
end

