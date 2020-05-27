function px=normal(x,mi,sigma)
%
% Syntax: px=normal(x,mi,sigma)
%
% Multivariate Gaussian distrib with diag. covar matrix given by st. deviations
% x - column vecto, lenght P
% mi - col. mean vector
% sigma - col. vector of std. deviations

PX=exp(-(x - mi).^2./(2*sigma.^2));
PX=PX / sqrt(2*pi);
PX=PX ./ sigma;
px=prod (PX);

