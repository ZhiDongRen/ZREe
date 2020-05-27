function SCB=vq_split(CB);
%
% Syntax:  SCB=vq_split(CB);
%
% Splitting VQ codebook. 
%
% CB (dimensions P x L) codebook. Each column contains one code-vector.
% SCB (dimensions P x 2L) is the split codebook. 
%
% Each codevector is split into two, moved in opposite directions by
% +const * c, -const * c, where c is the code-vector

CONST=0.01;
[P,L]=size (CB);
SCB=zeros (P, 2*L);

for ii=1:L,
  ii1=2*ii-1; 
  ii2=2*ii;
  
  c=CB(:,ii);
  sc1=c+CONST*c;
  sc2=c-CONST*c;
  
  SCB(:,ii1)=sc1;
  SCB(:,ii2)=sc2;
end

