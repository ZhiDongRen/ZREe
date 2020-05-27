% shows couple of Baum-Welch iterations


disp ('--- initialization ---'); 
[NEWA, NEWMI, NEWSIGMA, Ptot, ALFA, BETA, L] = reestim (c1, A, MI, SIGMA); 
subplot(211); plot (1:T, L); axis tight; subplot(212); plot (training_1); axis tight; 
disp(Ptot); pause;  
for iter=1:20
  disp (['--- iteration ' num2str(iter) ' ---']); 
  [NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c1, NEWA, NEWMI, SIGMA); 
  subplot(211); plot (1:T, L); axis tight; subplot(212); plot (training_1); axis tight; 
  disp(Ptot);   pause;
end 
