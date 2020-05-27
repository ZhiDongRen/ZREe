
function A=inittran (N)
% Syntax:  A=inittran (N);
%
% initialize transition pb. matrix of an HMM having N states (including the
% first-entry and last-exit, which are non-emitting). 
% Allowed transitions are only to the same state and to the next one.

STAYPB=0.5;
NEXTPB=0.5;

A=zeros(N,N);
A(1,2)=1;
for i=2:(N-1)
  A(i,i)=STAYPB;
  A(i,i+1)=NEXTPB;
end
