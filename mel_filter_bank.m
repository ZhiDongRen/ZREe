function [mfb, cbin] = mel_filter_bank(FFTL, Num, Fsamp, Fstart);

%function [mfb, cbin] = mel_filter_bank(FFTL, Num, Fsamp, Fstart);
% computation of mel filter bank
% FFTL = number of samples for FFT computation  (often == 256)
% Num = number of filters 
% Fsamp = sampling frequency (Hz) 
% Fstart = starting frequency (Hz) (often 0, or 16, or 32)
% mfb = matrix [FFTL/2+1, Num] filter bank try to see using plot(mfb)
% cbin = centres of filters in samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%computation described in AURORA-project - computation of MFCC

%first computation of centres of filtres
for i = 1 : Num,
  Fcent(i) = anti_mel_warp(mel_warp(Fstart) + ((mel_warp(Fsamp/2) - mel_warp(Fstart))/(Num + 1))*i);
  cbin_help(i) = round(Fcent(i)/Fsamp*FFTL);
end;

%set beg and end of bank
cbin(1) = round(Fstart/Fsamp*FFTL);
cbin(2 : Num+1) = cbin_help;
cbin(Num+2) = FFTL/2;

%shifting for matlab matrix axes
cbin = cbin + 1;


mfb = zeros(FFTL/2+1, Num);

%compute filter 
for i = 2:Num+1,
   mfb(cbin(i), i-1) = 1;
   for j = cbin(i-1)+1 : cbin(i)-1,
       mfb(j,i-1) = (j - cbin(i-1))/(cbin(i)-cbin(i-1));
   end;

   for j = cbin(i)+1 : cbin(i+1)-1,
       mfb(j,i-1) = 1-((j - cbin(i))/(cbin(i+1)-cbin(i)));
   end;
end;
