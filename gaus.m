function Y = gaus(X, MU, COV)
%Y = gaus(X, MU, COV)
%GAUS N-domensional normal probability density function
%    Y = GAUS(X,MU,SIGMA) Returns the normal pdf with mean vector,
%    MU, and covariance matrix, COV, at the vectors in X.
%
%    Every row X is one input vector. Y is column vector with the
%    same number of rows as X


sx=size(X);
X=reshape(X, sx(1), prod(sx(2:end))); %reshape more than 2-dimensional matrix

X=X-repmat(MU, size(X, 1), 1);
%X=X-ones(size(X, 1), 1) * MU;
if(size(COV) == size(MU))
  Y=1/(((2*pi)^(size(X, 2)/2))*sqrt(prod(COV))).*exp(-0.5*sum(X.^2*diag(1./COV), 2));
else
  Y=1/(((2*pi)^(size(X, 2)/2))*sqrt(det(COV))) .*exp(-0.5*sum(X*inv(COV).*X, 2));
end

Y=reshape(Y, [sx(1:end-1), 1]);