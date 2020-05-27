function ss=decoder(filecod, filewav) 
% function ss=decoder(filewav, filecod); 
%
% ZRE decoder 1050 bits per second
% filecod - name of file with coded input. 
% filewav - name of synthesized wav file (8kHz, 1 channel, lin)
% s - an auxiliary output with the synthesized signal. 
% makes use of codebooks cb210.txt for A coefficients and gcb64.txt for gain

load cb512.txt 
load gcb512.txt 

% reading the file 
[asym,gsym,L] = textread (filecod,'%d%d%d'); 

Adecoded = cb512(:,asym);
Gdecoded = gcb512(:,gsym);

% and synthesis
ss = synthesize (Adecoded,Gdecoded,L,10,160); 

% write it out 
audiowrite (filewav,ss,8000); 


