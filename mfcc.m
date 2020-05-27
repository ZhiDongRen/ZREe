function cps = mfcc(s, NFFT, Fs, window, noverlap, nbanks, nceps)
%MFCC Mel Frequency Cepstral Coefficients
%  cps = mfcc(s, FFTL, Fs, window, noverlap, nbanks, nceps)
%
%  NFFT          - number of frequency points used to calculate the discrete
%                  Fourier transforms
%  Fs            - sampling frequency [Hz]
%  window        - window lentgth for frame (in samples)
%  noverlap      - overlapping between frames (in samples)
%  nbanks        - numer of mel filter bank bands
%  nceps         - number of cepstral coefficients - the output dimensionality

s = s + rand(size(s)) - 0.5;         % add low level noise to avoid log of zero
mfb = mel_filter_bank(NFFT, nbanks, Fs, 32); % first filer starts at 32Hz
dct_mx = dct(eye(nbanks));
cps =  log(abs(spectrogram(s, window, noverlap, NFFT, Fs))' * mfb) * dct_mx(1:nceps,:)';
