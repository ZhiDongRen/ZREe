function [ALFA_new,MM_new,EE_new,lnP]=dgmixtrain(d,ALFA,MM,EE)
%
% Syntax: [ALFA_new,MM_new,EE_new,lnP]=dgmixtrain(d,ALFA,MM,EE,M)
%
% 1 iteration of training GAussian mixtures 
% ALFA, MM, EE are weights, means and variances. 
% d is training data.
% M is number of Gaussian components. 
% lnP is total log likelihood with the old parameters. 

M = size(MM, 2);
n = size(d, 2);
gama=zeros(M, n); 
for ii =1:M 
  gama(ii,:) = ALFA(ii) * gaus(d', MM(:,ii)', EE(:,ii)'); 
end
% jeste musime normalizovat
gamasum = sum(gama); 
gama =  gama ./ repmat(gamasum, M, 1);

% delam jeste total log likelihood ... 
lnP = sum (log (gamasum)); 

% now the computation of new parameters 
gamasum = sum(gama');
ALFA_new = gamasum / n; 
MM_new = d    * gama' ./ repmat(gamasum, size(d, 1), 1);
EE_new = d.^2 * gama' ./ repmat(gamasum, size(d, 1), 1) - MM_new.^2;
