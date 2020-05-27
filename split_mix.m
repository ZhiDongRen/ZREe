function [new_w new_m new_v] = split_mix(w, m, v)
%function [new_w new_m new_v] = split_mix(w, m, v)
%
% -> doubles the number of gaussian mixtures
% 
% The weights are duplicated  and divided by 2;
% The means are duplicated. To the first 0.2*STD is added, from the other
%   0.2*STD is substracted
% The variances are duplicated
% 

% duplicate and process means and variances
new_w = zeros(size(w,1) * 2, 1);
new_m = zeros(size(m,1), size(m,2)*2);
new_v = zeros(size(v,1), size(v,2)*2);

for ii=1:size(w,2)
  aux = sqrt(v(:, ii)) * 0.2;

  new_w(ii*2 - 1)   = w(ii) / 2;
  new_w(ii*2)       = w(ii) / 2;

  new_m(:, ii*2-1)  = m(:, ii) - aux;
  new_m(:, ii*2)    = m(:, ii) + aux;

  new_v(:, ii*2-1)  = v(:, ii);
  new_v(:, ii*2)    = v(:, ii);
end

