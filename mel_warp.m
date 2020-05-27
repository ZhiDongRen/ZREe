function [mel] = mel_warp(x);
%formula for warping the frequency axe into mel-freq
mel = 2595*log10(1 + x/700);
