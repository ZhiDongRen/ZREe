function c=a_to_cepst(a,NBC)
% Syntax: c=a_to_cepst(a)
%      ou c=a_to_cepst(a,NBC)
%
% a is a column vector of dimension N+1: [1 a(1) a(2) ... a(N)]'
% NBC is the nb. of desired cepstral coeffs. (default N)
% c is a column vector of dimension NBC+1: [0 c(1) c(2) ... c(NBC)]'
% note, that those coeffs are equivalent to complex cepstrum ! (but are
% not complex :-)
%----------------------------------------------------------------------
% a est vecteur colonne de la dimension N+1: [1 a(1) a(2) ... a(N)]'
% NBC est le nombre de coefficients cepstraux desires (default N)
% c sera vecteur colonne de la dimension NBC+1: [0 c(1) c(2) ... c(NBC)]'
% les coeffs sont equivalent au cepstre complex !

if nargin==1
 NBC=length(a)-1;
end
 
c=zeros(NBC+1,1);
ahelp=[a; zeros(NBC-length(a)+1,1)];  % "prolongation" of a
c(2)=-ahelp(2); 

for n=2:NBC
  divis=(1:n-1)/n;
  som=divis*(c(2:n).*ahelp(n:-1:2));   % "vectorized" sum 
  c(n+1)=-ahelp(n+1)-som; 
end					% end of for n  
