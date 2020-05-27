function swram = frame(sw,ls,rs)
% sw - signal
% ls - length of segment
% rs - segment overlap
% swram - output matrix, frames will be in columns. 

% frame shift 
fs = ls - rs;
%Number of frames. 
Nram = 1 + floor((length(sw) - ls) / fs);
% allocation for frames (they'll be in columns)
swram = zeros(ls, Nram);
% filling of frames. 
odtud=1; potud=ls;
for ii=1:Nram
  ramec = sw(odtud:potud)';
  swram(:,ii) = ramec;
  odtud = odtud + fs;
  potud = potud + fs;
end
