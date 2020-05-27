% HMM exercise  - trains HMMs for our 5 digits 
% --------------------------------------------

disp ('-------- training model for 1 ----------');
N=9; c = c1; s = training_1; T = size(c,2); A=inittran(N); [MI,SIGMA]=initemis(c,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot, ALFA, BETA, L] = reestim (c, A, MI, SIGMA);
disp(sprintf('Ptot %e',Ptot)); 
for iter=1:20,
   [NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c, NEWA, NEWMI, SIGMA);  
   disp(sprintf('iter %d Ptot %e',iter, Ptot)); 
end
subplot(211); plot (1:T, L); axis tight; subplot(212); plot (s); axis tight; 
A1=NEWA; MI1=NEWMI; SIGMA1=SIGMA;

disp ('-------- training model for 2 ----------');
N=9; c = c2; s = training_2; T = size(c,2); A=inittran(N); [MI,SIGMA]=initemis(c,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot, ALFA, BETA, L] = reestim (c, A, MI, SIGMA);
disp(sprintf('Ptot %e',Ptot)); 
for iter=1:20,
   [NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c, NEWA, NEWMI, SIGMA);  
   disp(sprintf('iter %d Ptot %e',iter, Ptot)); 
end
subplot(211); plot (1:T, L); axis tight; subplot(212); plot (s); axis tight; 
A2=NEWA; MI2=NEWMI; SIGMA2=SIGMA;

disp ('-------- training model for 3 ----------');
N=9; c = c3; s = training_3; T = size(c,2); A=inittran(N); [MI,SIGMA]=initemis(c,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot, ALFA, BETA, L] = reestim (c, A, MI, SIGMA);
disp(sprintf('Ptot %e',Ptot)); 
for iter=1:20,
   [NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c, NEWA, NEWMI, SIGMA);  
   disp(sprintf('iter %d Ptot %e',iter, Ptot)); 
end
subplot(211); plot (1:T, L); axis tight; subplot(212); plot (s); axis tight; 
A3=NEWA; MI3=NEWMI; SIGMA3=SIGMA;

disp ('-------- training model for 4 ----------');
N=9; c = c4; s = training_4; T = size(c,2); A=inittran(N); [MI,SIGMA]=initemis(c,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot, ALFA, BETA, L] = reestim (c, A, MI, SIGMA);
disp(sprintf('Ptot %e',Ptot)); 
for iter=1:20
   [NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c, NEWA, NEWMI, SIGMA);  
   disp(sprintf('iter %d Ptot %e',iter, Ptot)); 
end
subplot(211); plot (1:T, L); axis tight; subplot(212); plot (s); axis tight; 
A4=NEWA; MI4=NEWMI; SIGMA4=SIGMA;
disp ('-------- training model for 5 ----------');
N=9; c = c5; s = training_5; T = size(c,2); A=inittran(N); [MI,SIGMA]=initemis(c,N);
for iter=1:20
   [NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c, NEWA, NEWMI, SIGMA);  
   disp(sprintf('iter %d Ptot %e',iter, Ptot)); 
end
subplot(211); plot (1:T, L); axis tight; subplot(212); plot (s); axis tight; 
A5=NEWA; MI5=NEWMI; SIGMA5=SIGMA;