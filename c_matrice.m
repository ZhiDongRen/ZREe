function [C,A]=c_matrice(s,N,lseg,rseg);
% Syntax: C=c_matrice(s,N,lseg)
%      ou C=c_matrice(s,N,lseg,rseg)
%      ou [C,A]=c_matrice(s,N,lseg...)
%
% Function for computation of LPC-cepstral coefficients from signal. The
% window is rectangular and no preemphasis is done. 
%	s - signal vector
%	N - no. of cepstral coefficients
%	lseg - frame length
%	rseg - frame overlap (optional)
% In the resulting matyrix C, the vectors of LPCC coeffs. are in columns
% without c(0)=0. 
% Optional matrix A contains the vectors of LPC coefficients in columns, 
% without a(0)=1
%-------------------------------------------------------------------------
% Fonction pour le calcul des coefficients cepstraux a partir du signal
%	s - vecteur signal
%	N - nombre des coefficients cepstraux
%	lseg - longeur du segment
%	rseg - recouvrement des segments (optionnel)
% Dans la matrice C, les vecteurs cepstraux sont stockes colonne par colonne
%    sans c(0)=0
% La matrice A (optionelle) contient les vecteurs de coeff. LPC stockes
%    colonne par colonne sans a(0)=1

if(nargin==3),
 rseg=0;
end

M=floor((length(s)-rseg)/(lseg-rseg));	% no. de seg.

%-------------------------------------------------------------------------
C=zeros(N,M);    % initialization of cepstral matrix 
if nargout==2,
 A=zeros(N,M);    % initalization of LPC coeff matrix 
end

pos=1;

for i=1:M,
% --- choix de la fenetre 
 fen=s(pos:pos+lseg-1);		% rectangular window  
 pos=pos+lseg-rseg;
 
% --- calcul de coeff. LPC 
 r=xcorr(fen);
 r(1:lseg-1)=[];			% deletes 1st half of the vector 
 a=levinson(r,N)';
			% all this replaces  a=(lpc(fen,N))'; 

%  computation of cepstrum
 c=a_to_cepst(a);	% c -> a conversion
 C(1:N,i)=c(2:N+1);
 if nargout==2,
  A(1:N,i)=a(2:N+1);
 end
end	% for i 
