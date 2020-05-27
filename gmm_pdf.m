function y = gmm_pdf(data, w, m, v)
%Y = gaus(data, m, v)
%GAUS N-domensional normal probability density function
%    Y = GAUS(data,m,SIGMA) Returns the normal pdf with mean vector,
%    m, and covariance matrix, v
%    for each sample (column) from data
%
%    Every row data is one input vector. Y is column vector with the
%    same number of rows as data


n_mixtures  = size(m, 2);
N           = size(data, 2);
y           = zeros(1, N); 

for ii =1:n_mixtures 
  y = y + w(ii) * gaus(data', m(:,ii)', v(:,ii)')';
end

