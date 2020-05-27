function [NEWA,NEWMI,NEWSIGMA,Ptot, ALFA, BETA, L] = reestim (O, A, MI, SIGMA)
%
%Syntax: [NEWA,NEWMI,NEWSIGMA,Ptot, ALFA, BETA, L] = reestim (O, A, MI, SIGMA);
%
% Reestimation of HMM using Baum Welch.

[P,T]=size(O);
N=size(A,1);

if T<N
 error ('Not enough obs. vectors to reestim all states');
end

NEWA=zeros(size(A));
NEWMI=zeros(size(MI));
NEWSIGMA=zeros(size(SIGMA));


ALFA=zeros(N,T);   % forward sample
BETA=zeros(N,T);   % backward sample
L=zeros(N,T);      % state occup

NORMA=zeros(1,T);
NORMB=zeros(1,T);

%%% fwd sample estimation
% init
ALFA(1,1) = 1;
for j=2:(N-1)
   suma = A(1,j);
   emis = normal (O(:,1), MI(:,j), SIGMA(:,j));
   ALFA(j,1)=suma*emis;
end
%>>> norm
NORMA(1)=max(ALFA(:,1));
ALFA(:,1) = ALFA(:,1) / NORMA(1);
%ALFA(:,1)

% cycle
for t=2:T
  for j=2:(N-1)
    suma =  sum ( ALFA(2:(N-1),t-1).*A(2:(N-1),j) ) ;
    emis =  normal (O(:,t), MI(:,j), SIGMA(:,j));
    ALFA(j,t) = suma * emis;
%    suma
%    emis
  end
% ALFA(:,t)
% pause
%>>> norm
  NORMA(t)=max(ALFA(:,t));
  if t~=T
    ALFA(:,t) = ALFA(:,t) / NORMA(t);
  end
end

% last one
suma =  sum ( ALFA(2:(N-1),T).*A(2:(N-1),N) );
ALFA(N,T) = suma;
%>>> norm
NORMA(T)=max(ALFA(:,T));
ALFA(:,T) = ALFA(:,T) / NORMA(T);

%%% backwd
% init 
for i=2:N-1
  BETA (i,T) = A(i,N);
end
%>>> norm
NORMB(T)=max(BETA(:,T));
BETA(:,T) = BETA(:,T) / NORMB(T);

% cycle
for t=(T-1):-1:1
  for i=2:(N-1)
    suma =  0;
    for j=2:(N-1)
      suma=suma+ A(i,j)*normal (O(:,t+1), MI(:,j), SIGMA(:,j))*BETA(j, t+1);
    end
    BETA(i,t) = suma;
  end
%>>> norm
  NORMB(t)=max(BETA(:,t));
  if t ~= 1
    BETA(:,t) = BETA(:,t) / NORMB(t);
  end
end
  
% first one
for j=2:(N-1)
  suma=suma+ A(1,j)*normal (O(:,1), MI(:,j), SIGMA(:,j))*BETA(j,1);
end
BETA(1,1) = suma;
%>>> norm
NORMB(1)=max(BETA(:,1));
BETA(:,1) = BETA(:,1) / NORMB(1);

%%% products of norm factors %%%
PNA=zeros(1,T); PNB=zeros(1,T); 
for t=1:T
  PNA(t) = prod(NORMA(1:t));
end
for t=T:-1:1
  PNB(t) = prod(NORMB(t:T));
end

%%%%%%%%%%%% final B-W sample %%%%%%%%%%%%%
Ptot=PNA(T) * ALFA(N,T);
Ptott=PNB(1) * BETA(1,1);

%Ptot=prod(NORMB) * BETA(1,1)
%Ptottt=prod(NORMA)* ALFA(N,T)

%Ptot=BETA(1,1)
%Ptott=ALFA(N,T)

%%%%%%%% do normal alfa and beta %%%%%%%%
ALFA=ones(N,1) * PNA .* ALFA;
BETA=ones(N,1) * PNB .* BETA;

%%%%%%%%%%%% reestim trans %%%%%%%%%%%%%%
% ordinary ones
for i=2:(N-1)
  for j=2:(N-1)
    up=0; down=0;
    for t=1:(T-1)
      up=up+ALFA(i,t) * A(i,j) * ...
         normal (O(:,t+1), MI(:,j), SIGMA(:,j))*BETA(j, t+1); 
    end
    for t=1:T
      down=down+ALFA(i,t) * BETA(i,t);
    end
    NEWA(i,j) = up / down;
  end
end

% entry
for j=2:(N-1)
    NEWA(1,j) = ALFA (j,1) * BETA(j,1) / Ptot;
end

% exit
for i=2:(N-1)
  for j=2:(N-1)
    up=ALFA(i,T) * BETA (i,T);
     for t=1:T
      down=down+ALFA(i,t) * BETA(i,t);
    end
    NEWA(i,N) = up / down;
  end
end

%%% means and stds %%%%%
% state occups
L=ALFA .* BETA / Ptot;

for j=2:(N-1)
  Lvec = L(j,:);
  Lmat=ones(P,1) * Lvec;
  NEWMI(:,j) = sum((Lmat .* O)')' / sum(Lvec);
  NEWSIGMA(:,j) = sum((Lmat .* ((O-NEWMI(:,j) * ones(1,T)).^2))')' / sum(Lvec);
end
