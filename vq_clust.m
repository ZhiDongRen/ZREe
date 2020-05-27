function [cb, nbs]=vq_clust(M, sym, L);
%
% Syntax:  [cb, nbs]=vq_clust(M, sym, L);
%
% Making VQ centroids, which will serve as new code-vectors.
%
% M (dimensions P x N) is the matrix of training vectors. 
%                      Each column contains one vector.
% sym (dimensions 1 x N) is the associated string of symbols (range 1 to L).
% L  is the size of codebook. 
% CB (dimensions P x L) is the resulting codebook. 
%                       Each column contains one code-vector.
% nbc (dimensions 1 x L) is the vector of numbers of training vectors 
%                        associated to clusters.
%
% The centroids are computes using simple means.

[P,N]=size (M);

cb = zeros (P, L);
nbs = zeros (1,L);
for ii=1:L
  indices = find (sym==ii);
  nbs (ii) = length (indices);
  chosen_vecs = M (:,indices);
  centroid = mean(chosen_vecs')';
  cb (:,ii) = centroid;
end
