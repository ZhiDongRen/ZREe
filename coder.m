function s=coder(filewav, filecod); 
% function s=coder(filewav, filecod); 
%
% ZRE coder 1050 bits per second
% filewav - name of wav file (8kHz, 1 channel, lin)
% filecod - name of file with coded output. 
% s - an auxiliary output with the read sound (centered) 
% makes use of codebooks cb210.txt for A coefficients and gcb64.txt for gain

load cb512.txt 
load gcb512.txt 

s = audioread (filewav); 
sm = s - mean(s); 
% first parameterization function: 
[A,G,L,Nram] = param2 (sm,160,0,10,20,146,0.7); 
[asym,gd] = vq_code(A, cb512); 
gsym = vq_code(G, gcb512); 

OUT = [asym; gsym; L]; 
ff= fopen(filecod,'w');   
fprintf (ff,'%d %d %d\n',OUT);
fclose (ff);                    
