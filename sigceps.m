% sigceps - loads signals for DTW / HMM lab and makes feature extraction 

% reading speech files - training
s1 = audioread('1.wav')';
s2 = audioread('2.wav')';
s3 = audioread('3.wav')';
s4 = audioread('4.wav')';

% reading speech files - test
s1t = audioread('1t.wav')';
s2t = audioread('2t.wav')';
s3t = audioread('3t.wav')';
s4t = audioread('4t.wav')';

% reading speech files - wierd tests
s1l = audioread('1l.wav')';
s2l = audioread('2l.wav')';
sb = audioread('b.wav')';

disp ('all signals read'); 
whos s1 s2 s3 s4 s1t s2t s3t s4t s1l s2l sb 

% feature extraction by LPCC coefficients. 

c1 = c_matrice (s1,10,240,160);
c2 = c_matrice (s2,10,240,160);
c3 = c_matrice (s3,10,240,160);
c4 = c_matrice (s4,10,240,160);
c1t = c_matrice (s1t,10,240,160);
c2t = c_matrice (s2t,10,240,160);
c3t = c_matrice (s3t,10,240,160);
c4t = c_matrice (s4t,10,240,160);
c1l = c_matrice (s1l,10,240,160);
c2l = c_matrice (s2l,10,240,160);
cb = c_matrice (sb,10,240,160);

disp ('feature extraction with LPCC coeffs done '); 
whos c1 c2 c3 c4 c1t c2t c3t c4t c1l c2l cb 
D=dtw(c4,c4);
soundsc([s4 s4]);
D=dtw (c4, c4t); 
soundsc ([s4 s4t]);
figure(1); pause(1); soundsc([s2t s1]); D1=dtw (c1, c2t);
figure(2); pause(1); soundsc([s2t s2]); D2=dtw (c2, c2t);
figure(3); pause(1); soundsc([s2t s3]); D3=dtw (c3, c2t);
figure(4); pause(1); soundsc([s2t s4]); D4=dtw (c4, c2t); 
D1 D2 D3 D4 [m,mini]=min([D1 D2 D3 D4]); 
fprintf('recognized ======= %d ========\n\n', mini);
reco_dtw;
N=9; A=inittran(N); [MI,SIGMA]=initemis(c1,N); 
A ;
MI ;
SIGMA;
[NEWA, NEWMI, NEWSIGMA, Ptot, ALFA, BETA, L] = reestim (c1, A, MI, SIGMA); 
ALFA;
BETA;
T = size (c1,2); plot (1:T, L) ;
sum(L(2:N-1,:));
[NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c1, NEWA, NEWMI, NEWSIGMA); plot (1:T, L); 
Ptot;
L;
show_bw_iters;
train_hmms;
reco_hmms;



