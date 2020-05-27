function [D,ch]=dtw(cr,ct)
%Syntax:  [D,ch]=dtw(cr,ct)
%
% JC, last update Mon Dec 16 13:27:50 CET 2002
%
%DTW between reference sequence of vectors cr and test sequence of vectors ct.
%cr has dimensions P x R, where P is the size of parameter vectors and
%                               R is their number (length of cr).
%ct has dimensions P x T, where P is the size of parameter vectors and
%                               T is their number (length of ct).
%D  is the distance over the optimal path, normalized by T+R.
%ch is the optimal path (2-column array). 
%
%Graphical output:
%  1) matrix of local distances
%  2) matrix of cumulated distances
%  3) DTW path 

% get sizes of test and reference - numbers of coefficients in a vector, numbers of frames. 
[nc_t,nt_t]=size(ct);
[nc_r,nt_r]=size(cr);

% do something only if the vectors are comparable, i.e. have same lengths. 
if nc_r==nc_t

  % allocate for matrix of partial cummulated distances and local distances 
  g=zeros(nt_t+1,nt_r+1);
  dist=g;
  
  % set 1st column and 1st row of cummulated distances to VERY BIG values. 
  g(1,:)=1000*ones(1,nt_r+1);
  g(:,1)=1000*ones(nt_t+1,1);
  % and set the element 1,1 to zero - here it will begin 
  g(1,1)=0;
  trace=g;
  
  % cycle over test 
  for t=1:nt_t
    % cycle over reference 
    for r=1:nt_r
      % compute the local sitances - just squared Euclidean distance 
      d=sum(abs(ct(:,t)-cr(:,r)).^2);
      dist(t,r)=d;
      
      % computhe the 3 possibilities how could we get here  
      g1=g(t,r+1)+d;
      g0=g(t,r)+2*d;
      g2=g(t+1,r)+d;
      
      % and select the maximum - nor programmed very nicely :-( trace will 
      % contain an indication where we came from. 
      if g0 <g1
	if g0<g2
          g(t+1,r+1)=g0;
          trace(t+1,r+1)=0;
	else 
          g(t+1,r+1)=g2;
          trace(t+1,r+1)=2;
	end
      else 
	if g1 <g2
          g(t+1,r+1)=g1;
          trace(t+1,r+1)=1;
	else 
          g(t+1,r+1)=g2;
          trace(t+1,r+1)=2;
	end
      end	
    end
  end
  
  % we are done with the 'd' matrix, now let's compute the DTW distance by normalizaion by 
  % the sum of lengths of test and reference. 
  D=g(nt_t+1,nt_r+1)/(nt_r+nt_t);
  
  % now going to abck-trace the optimal path 
  k=1;
  encore=1;
  ch(k,:)=[nt_t+1 nt_r+1];
  while (ch(k,1)+ch(k,2)) >=2
    tr=trace(ch(k,1),ch(k,2));
    if tr ==0 
      ch(k+1,:)=[ch(k,1)-1 ch(k,2)-1];
      k=k+1;
    elseif tr==1
      ch(k+1,:)=[ch(k,1)-1 ch(k,2)];
      k=k+1;
    elseif tr==2
      ch(k+1,:)=[ch(k,1) ch(k,2)-1];
      k=k+1;
    else ch(k+1,:)=[0 0];
      k=k+1;
    end
  end
  
  % and visualize everyhing  
  % --- local distance martrix ---
  subplot (311);
  imagesc(dist); colormap('hot'); 
  axis xy
  
  % --- cumulated distance matrix ---
  subplot(312);
  imagesc(g(2:(nt_t+1),2:(nt_r+1))); colormap('hot'); 
  axis xy
  
  % --- path ---
  subplot(313); 
  plot(ch(k-1:-1:1,2),ch(k-1:-1:1,1)); axis tight
  titre= 'dtw path,  D=';
  titre=[titre num2str(D)];
  title(titre); xlabel('reference'); ylabel('test') 
  ch = flipud(ch);
end
