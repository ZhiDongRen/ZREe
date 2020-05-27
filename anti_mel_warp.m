function [imel] = anti_mel_warp(x);
%formula for warping the frequency axe into mel-freq
imel = (10.^(x/2595)-1)*700;
