%1. Implementacion de multiplexado 
%a.
%Metodo 1

[audio, Fs]= audioread('hector8k.wav');
Fs_new=8000;
audio_fsnew = resample(audio, Fs_new, Fs);
audiowrite('hector328k.wav',audio_fsnew, Fs_new);

[audio, Fs]= audioread('santi8k.wav');
Fs_new=8000;
audio_fsnew = resample(audio, Fs_new, Fs);
audiowrite('santi328k.wav',audio_fsnew, Fs_new);


[audio, Fs]= audioread('juanjo8k.wav');
Fs_new=8000;
audio_fsnew = resample(audio, Fs_new, Fs);
audiowrite('juanjo328k.wav',audio_fsnew, Fs_new);

[audio, Fs]= audioread('ernesto8k.wav');
Fs_new=8000;
audio_fsnew = resample(audio, Fs_new, Fs);
audiowrite('ernesto328k.wav',audio_fsnew, Fs_new);


