function []=show(A,CB,sym); 
% function show (A,CB,sym)
% 
% shows the clusters and centroids of VQ 
% A - data 
% CB - codebook 
% sym - symbols produced by vq_code. 
 
% limitation of data to show ... NOT NOW 
%LIMIT = 1500; 
%toshow = Aspeech(:,1:LIMIT); 
toshow = A; 

% get the size of CB
[dummy,L] = size (CB);

cols='ymcrgb';
ncols=6;

% figure(2);
hold off;

% >>> the setting of coefficients we want to look at is HERE <<<
i1=1; i2=2; i3=3;
for ii=1:L
%  indices = find (sym(1:LIMIT) == ii);
  indices = find (sym == ii);
  plot3 (toshow(i1, indices), toshow(i2, indices), toshow(i3, indices), ...
       [cols(rem(ii, ncols)+1) , 'x']); hold on;
  
  plot3 (CB(i1, ii), CB (i2, ii), CB (i3, ii), ...
       [cols(rem(ii, ncols)+1) , 'o'],'MarkerSize', 15);
  
  text (CB(i1, ii), CB (i2, ii), CB (i3, ii), num2str(ii), 'FontSize', 15, 'FontWeight', 'bold' );
  hold on;
end
grid
