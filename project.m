 % ZhiDong Ren 
%login: xrenzh00

%==============================================================
%PRAT 2 
%==============================================================

%2. Linear prediction
signal = audioread('ESLPod451.wav');%∑÷÷°
l = 25e-3; r = 10e-3; %length of the frames 25 ms, shift 10 ms.
ls = round (l * 8000);
rs = round (r * 8000);
signal_mean=signal-mean(signal);
signal_frame = frame(signal_mean, 320, 0);%signal = signal_mean,length of segment= 160,segment overlap=0
P = 10;
Nram = size(signal_frame,2);%number of frames 
Aall = zeros (P,Nram); % will store them without a0=1 ! 
Gall = zeros (1,Nram);
for n=1:Nram
    [a,e] = lpc(signal_frame(:,n), 10); 
    a = a(2:(P+1))'; % discarding a0 = 1 
    Aall(:,n) = a; 
    Gall(n) = sqrt(e); 
end
%ff=fopen('features_frames','w');
%fprintf(ff,'%f %d\n',signal_frame,Aall);    
%fclose(ff);
save frame_LPC Aall;%each frame has 10 lpc coff and number of frame = 7500
disp('=====step2:binary files with features-frame_LPC=====')
pause;
%===================================================
%PART 3
%===================================================
%============Data preparation=======================
% get some training and test dat
[A,G,Nram]=param('ESLPod451_4mins.wav',320,0,10);
%[At,Gt,Nramt] =param ('ESLPod451_1mins.wav',320,0,10);%for test

%% bigger CB - size 512
% init
aux = randperm (Nram); theones = aux(1:512); 
CB512 = A(:,theones);
%% iterations: coding (+ visualization) and re-training
%lterations = 1:10 for task 11.1
for iter=1:10 [sym, gd] = vq_code(A,CB512); 
   % show (A,CB512,sym);
    %gd; 
    %pause 
    [CB512, nbs]=vq_clust(A, sym, 512); 
   % nbs; 
   % pause
end

% synt. with original coeffs: 
%sst = syntnoise(At,Gt,10,320); 
%plot (sst); soundsc(sst);
% codebook 
%[symt, gd] = vq_code(At, CB512); 
%Atdecoded = CB512(:,symt); 
%sstdec = syntnoise(Atdecoded,Gt,10,320); 
%plot (sstdec); 
%soundsc(sstdec);

save cb512.txt -ascii CB512;
%save cb512_fix.txt CBclean  -ascii;
gcb = logspace(log10(min(G)), log10(max(G)), 512); 
save gcb512.txt gcb -ascii 
disp('=============step3:code-book-generated-done=========')
pause;
%==================================================
% PART 4
%==================================================
%signal = audioread('ESLPod451.wav');
%signal_mean=signal-mean(signal);
%signal_frame=frame(signal_mean,320,0);
init=zeros(P,1); 
syntbig = [];
for n = 1:Nram
    a = [1; Aall(:,n)]; 
    G = Gall(n); 
    excit = signal_frame (:,n) + 0.1 * randn (320,1);
    excit = excit ./ sqrt(sum(excit .^ 2) / 320); 
    [synt,final] = filter (G,a,excit,init); 
    init = final;
    syntbig = [syntbig synt']; 
end
   % plot (syntbig);
   %soundsc(syntbig);
save encoded_excit syntbig;
disp('==step4:binary files with encoded excitation-done==')
pause;
%==================================================
%PART 5
%==================================================
load cb512.txt
load gcb512.txt
load encoded_excit.mat %which contains 'syntbig'
load frame_LPC.mat
[A,G,L,Nram]= param2 (syntbig,320,0,10,20,310,0.7); 
[asym,gd] = vq_code(Aall, cb512); %Aall from liner predicate
gsym = vq_code(G, gcb512);%gain from excit speech 
%decodnig
Adecoded = cb512(:,asym); 
Gdecoded = gcb512(:,gsym);
% and synthesis 
ss = synthesize (Adecoded,Gdecoded,L,10,320);
%plot (ss); soundsc(ss);%for test


%audiowrite ('excit_LPC.wav',ss,8000); 
%s = coder('excit_LPC.wav','excit_cod');
%ss = decoder ('excit_cod','decoing_excit.wav');
%pause;
%soundsc(ss); 

s = coder('ESLPod451_1mins.wav', 'CB_cod');
ss = decoder ('CB_cod', 'synthesized.wav');
soundsc(ss); pause; soundsc (s);
disp('step5:synthesized wav files for 1/5 of the recorded read speech-done')
pause;
%==============================================================
%PART 6
%==============================================================
%command word damage
command_word_damage_1=audioread('damage1.wav')';
command_word_damage_2=audioread('damage2.wav')';
command_word_damage_3=audioread('damage3.wav')';
command_word_damage_4=audioread('damage4.wav')';
command_word_damage_5=audioread('damage5.wav')';

%command word driver
command_word_driver_1 = audioread('driver.wav')';
command_word_driver_2 = audioread('driver (2).wav')';
command_word_driver_3 = audioread('driver (3).wav')';
command_word_driver_4 = audioread('driver (4).wav')';
command_word_driver_5 = audioread('driver (5).wav')';

%command word insurance
command_word_insurance_1 = audioread('insurance.wav')';
command_word_insurance_2 = audioread('insurance (2).wav')';
command_word_insurance_3 = audioread('insurance (3).wav')';
command_word_insurance_4 = audioread('insurance (4).wav')';
command_word_insurance_5 = audioread('insurance (5).wav')';

%command word medical
command_word_medical_1 = audioread('medical.wav')';
command_word_medical_2 = audioread('medical (2).wav')';
command_word_medical_3 = audioread('medical (3).wav')';
command_word_medical_4 = audioread('medical (4).wav')';
command_word_medical_5 = audioread('medical (5).wav')';

%command word passenger 
command_word_passenger_1 = audioread('passenger.wav')';
command_word_passenger_2 = audioread('passenger (2).wav')';
command_word_passenger_3 = audioread('passenger (3).wav')';
command_word_passenger_4 = audioread('passenger (4).wav')';
command_word_passenger_5 = audioread('passenger (5).wav')';

% reading speech files - training
training_1=command_word_damage_5;
training_2=command_word_driver_5;
training_3=command_word_insurance_5;
training_4=command_word_medical_4;
training_5=command_word_passenger_5;

% reading speech files - test
test_1=command_word_damage_2;
test_2=command_word_driver_2;
test_3=command_word_insurance_2;
test_4=command_word_medical_2;
test_5=command_word_passenger_3;
disp ('all signals read'); 
whos training_1 training_2 training_3 training_4 training_5  test_1 test_2 test_3 test_4 test_5
save data\male\test\test_1.raw test_1;
save data\male\test\test_2.raw test_2;
save data\male\test\test_3.raw test_3;
save data\male\test\test_4.raw test_4;
save data\male\test\test_5.raw test_5;

c1 = c_matrice (training_1,10,480,200);
c2 = c_matrice (training_2,10,480,200);
c3 = c_matrice (training_3,10,480,200);
c4 = c_matrice (training_4,10,480,200);
c5 = c_matrice (training_5,10,480,200);
c1t = c_matrice (test_1,10,480,200);
c2t = c_matrice (test_2,10,480,200);
c3t = c_matrice (test_3,10,480,200);
c4t = c_matrice (test_4,10,480,200);
c5t = c_matrice (test_5,10,480,200);
disp ('feature extraction with LPCC coeffs done ');
whos c1 c2 c3 c4 c5  c1t c2t c3t c4t c5t

D=dtw(c5,c5);
%soundsc([training_5 training_5]);
D=dtw (c5, c5t); 
%soundsc ([training_5 test_5]);
%figure(1); pause(1); soundsc([test_2 training_1]); 
D1=dtw (c1, c2t);
%figure(2); pause(1); soundsc([test_2 training_2]);
D2=dtw (c2, c2t);
%figure(3); pause(1); soundsc([test_2 training_3]);
D3=dtw (c3, c2t);
%figure(4); pause(1); soundsc([test_2 training_4]); 
D4=dtw (c4, c2t); 
%figure(5); pause(1); soundsc([test_2 training_5]); 
D5=dtw (c5, c2t);
[m,mini]=min([D1 D2 D3 D4 D5]);  
fprintf('recognizing start ======= %d ========\n\n', mini);
reco_dtw;
N=9; A=inittran(N); [MI,SIGMA]=initemis(c1,N); %A ;MI ;SIGMA;
[NEWA, NEWMI, NEWSIGMA, Ptot, ALFA, BETA, L] = reestim (c1, A, MI, SIGMA);
T = size (c1,2); plot (1:T, L) ;
sum(L(2:N-1,:));
[NEWA,NEWMI,NEWSIGMA,Ptot,ALFA,BETA,L] = reestim (c1, NEWA, NEWMI, NEWSIGMA); 
plot (1:T, L); 
show_bw_iters;
train_hmms;
reco_hmms;

% %Read all the training and test data into cell-arrays
 train_m = raw2mfcc('data/male/train');
 train_f = raw2mfcc('data/female/train');
[test_m, files_m] = raw2mfcc('data/male/test');
 [test_f, files_f] = raw2mfcc('data/female/test');
% % For training, we do not need to know which frame come from which training segment.
% % So, for each gender, concatenate all the training feature matrices into single matrix
train_m=cell2mat(train_m);
train_f=cell2mat(train_f);



l_m = gaus(test_m{1}, mean(train_m), var(train_m, 1)); %likelihood of male model
l_f = gaus(test_m{1}, mean(train_f), var(train_f, 1)); %likelihood of female model
% % Plot the frame-by-frame likelihoods obtained with the two models
 %figure; plot(l_m, 'b'); hold on; plot(l_f, 'r');
 sum(l_m) - sum(l_f);
% % Plot frame-by-frame posteriors
 %figure; plot(l_m./(l_m+l_f), 'b'); hold on; plot(l_f./(l_m+l_f), 'r');
sum(l_m./(l_m+l_f)) - sum(l_f./(l_m+l_f));
% % Plot frame-by-frame log-likelihoods
%figure; plot(log(l_m), 'b'); hold on; plot(log(l_f), 'r');
% 
sum(log(l_m)) - sum(log(l_f));



testdata=test_f{1};
l_m = gaus(testdata, mean(train_m), cov(train_m, 1));
l_f = gaus(testdata, mean(train_f), cov(train_f, 1));
% figure; plot(l_m./(l_m+l_f), 'b'); hold on; plot(l_f./(l_m+l_f), 'r');
 %figure; plot(log(l_m), 'b'); hold on; plot(log(l_f), 'r');
 sum(log(l_m))-sum(log(l_f));



mean_m = mean(train_m);
cov_m = cov(train_m, 1);
 mean_f = mean(train_f);
 cov_f = cov(train_f, 1);
test_set = test_f;
 for ii=1:length(test_set)
     l_m = gaus(test_set{ii}, mean_m, cov_m);
     l_f = gaus(test_set{ii}, mean_f, cov_f);
     score_f(ii)=sum(log(l_m))-sum(log(l_f));
 end
 score_f
 pause;
dlmwrite('score_female.txt', score_f);

 %train male model
% %start with single gaussian with diagonal covariance matrix
 WW_m = [1];
 MM_m = [mean(train_m)'];
 EE_m = [var(train_m, 1)'];
% % Function 'split_mix' doubles the number of gaussian components
% % Function 'dgmixtrain' updates GMM parameters using single EM iteration
 [WW_m, MM_m, EE_m] = split_mix(WW_m, MM_m, EE_m);
 [WW_m, MM_m, EE_m] = dgmixtrain(train_m', WW_m, MM_m, EE_m);
 
WW_f = [1];
MM_f = [mean(train_f)'];
EE_f = [var(train_f, 1)'];
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = split_mix(WW_f, MM_f, EE_f);
[WW_f, MM_f, EE_f] = dgmixtrain(train_f', WW_f, MM_f, EE_f);
 
% 
 test_set=test_m;
for ii=1:length(test_set)
 l_m = gmm_pdf(test_set{ii}', WW_m, MM_m, EE_m);
 l_f = gmm_pdf(test_set{ii}', WW_f, MM_f, EE_f);
 score_m(ii)=sum(log(l_m))-sum(log(l_f));
 end
 score_m
dlmwrite('score_male.txt', score_m);
disp('step6:output file with scores and result-done')




