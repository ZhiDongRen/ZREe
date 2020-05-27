function [sym, gd]=vq_code(M, CB)
%
% Syntax: [sym, gd]=vq_code(M, CB);
%
% Coding using VQ codebook.
% M (dimensions P x N) is the matrix to code. Each column contains one vector.
% CB (dimensions P x L) is the codebook. Each column contains one code-vector.
% sym (dimensions 1 x N) is the string of symbols in the range 1 to L.
% gd is the global distance normalized by N. 
%
% All distances are quadratic cepstral (x-y)'*(x-y)
%

[P,N]=size (M);
[P,L]=size (CB);

% now compute the distance of all vectors to all codevectors.

D=zeros (L,N);
gd=0;
for ii=1:N
  for jj=1:L
    v=M(:,ii);
    c=CB(:,jj);
    D(jj,ii) = (v-c)' * (v-c);
  end
end

% now search the minima

[mind , sym] = min (D,[],1);

% compute the glob dist

gd = sum (mind) / N;
