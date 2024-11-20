% Configuraci?n inicial
Fs = 328000; % Frecuencia de muestreo
archivosAudio = {'ernesto328k.wav', 'hector328k.wav', 'juanjo328k.wav', 'santi328k.wav'};
frecuenciasPortadoras = [60000, 64000, 68000, 72000]; % Frecuencias portadoras

% Modulaci?n de las se?ales
senalesModuladas = cell(1, length(archivosAudio)); % Inicializar

for k = 1:length(archivosAudio)
    % Leer cada archivo de audio
    [Xk_n, ~] = audioread(archivosAudio{k});
    n = (0:length(Xk_n)-1)'; % Vector de muestras
    
    % Calcular la frecuencia angular
    omega_k = 2 * pi * frecuenciasPortadoras(k) / Fs;
    
    % Modulaci?n
    senalesModuladas{k} = Xk_n .* cos(omega_k * n);
    
    % Guardar las se?ales moduladas
    audiowrite(['modulada_', archivosAudio{k}], senalesModuladas{k}, Fs);
end

% Dise?o del filtro pasa-altos para eliminar la banda lateral inferior
Fc = 60000; % Frecuencia de corte
Wn = Fc / (Fs / 2); % Normalizaci?n

% Incrementar el orden del filtro y usar un filtro Chebyshev
orden = 10; % Ajusta seg?n sea necesario
Rp = 1; % Ondulaci?n permitida en la banda de paso (en dB)
[b, a] = cheby1(orden, Rp, Wn, 'high'); % Filtro pasa-altos Chebyshev

% Verificar la respuesta del filtro
fvtool(b, a); % Visualizar la respuesta en frecuencia

% Aplicar el filtro a cada se?al modulada
senalesFiltradas = cell(1, length(senalesModuladas)); % Inicializar

for k = 1:length(senalesModuladas)
    % Filtrar la se?al
    senalesFiltradas{k} = filter(b, a, senalesModuladas{k});
    
    % Guardar las se?ales filtradas
    audiowrite(['filtrada_', archivosAudio{k}], senalesFiltradas{k}, Fs);
end

% Graficar la se?al filtrada y su espectro (ejemplo con la primera se?al)
senal = senalesFiltradas{1}; % Seleccionar la primera se?al filtrada
t = (0:length(senal)-1) / Fs; % Vector de tiempo

% Gr?fico en el dominio del tiempo
figure;
plot(t, senal);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Se?al Filtrada en el Tiempo');
grid on;
xlim([0, 3]); % Ajuste

% Espectro de frecuencia
L = length(senal);
Y = fftshift(fft(senal));
f = (-L/2:L/2-1) * (Fs / L);
P = abs(Y) / L;

figure;
plot(f, P);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
title('Espectro de Frecuencia - Se?al Filtrada');
grid on;
xlim([0, 100000]); % Ajuste

% Obtener la se?al portadora de banda ancha sumando las se?ales filtradas
senalBandaAncha = zeros(size(senalesFiltradas{1})); % Inicializar

for k = 1:length(senalesFiltradas)
    senalBandaAncha = senalBandaAncha + senalesFiltradas{k};
end

% Guardar la se?al de banda ancha
audiowrite('senal_banda_ancha.wav', senalBandaAncha, Fs);

% Graficar la se?al de banda ancha y su espectro
t = (0:length(senalBandaAncha)-1) / Fs;

% Gr?fico en el dominio del tiempo
figure;
plot(t, senalBandaAncha);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Se?al de Banda Ancha en el Tiempo');
grid on;
xlim([0, 3]); % Ajuste

% Espectro de frecuencia
L = length(senalBandaAncha);
Y = fftshift(fft(senalBandaAncha));
f = (-L/2:L/2-1) * (Fs / L);
P = abs(Y) / L;

figure;
plot(f, P);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
title('Espectro de Frecuencia - Se?al de Banda Ancha');
grid on;
xlim([0, 100000]); % Ajuste

%ACTIVIDAD 2
close all
%fdatool
	% Filtro
	canal1filt= filter(A,B,senalBandaAncha);
	% % 
	% Graficas
	figure;
	t=1/Fs;
	n=length(canal1filt);
	z=(0:n-1)*t;
	stem(z,canal1filt);
	title('Señal filtrada ');
	xlabel('tiempo (seg)');
	ylabel('Amplitud');
	 
	%espectro
	Resp= fft(canal1filt);
	n_1=length(canal1filt);
	M=abs(Resp);
	f_1=(0:n_1-1)*(Fs/n_1);
	figure;
	plot(f_1, M);
	title('Espectro de señal filtrada ');
	xlabel('Frecuencia (Hz)');
	ylabel('Magnitud');

    % Filtro
	canal2filt= filter(C,D,senalBandaAncha);
	% % 
	% Graficas
	figure;
	t=1/Fs;
	n=length(canal2filt);
	z=(0:n-1)*t;
	stem(z,canal2filt);
	title('Señal filtrada ');
	xlabel('tiempo (seg)');
	ylabel('Amplitud');
	 
	%espectro
	Resp= fft(canal2filt);
	n_1=length(canal2filt);
	M=abs(Resp);
	f_1=(0:n_1-1)*(Fs/n_1);
	figure;
	plot(f_1, M);
	title('Espectro de señal filtrada ');
	xlabel('Frecuencia (Hz)');
	ylabel('Magnitud');
    
    % Filtro
	canal3filt= filter(E,F,senalBandaAncha);
	%% 
	% Graficas
	figure;
	t=1/Fs;
	n=length(canal3filt);
	z=(0:n-1)*t;
	stem(z,canal3filt);
	title('Señal filtrada ');
	xlabel('tiempo (seg)');
	ylabel('Amplitud');
	 
	%espectro
	Resp= fft(canal3filt);
	n_1=length(canal3filt);
	M=abs(Resp);
	f_1=(0:n_1-1)*(Fs/n_1);
	figure;
	plot(f_1, M);
	title('Espectro de señal filtrada ');
	xlabel('Frecuencia (Hz)');
	ylabel('Magnitud');
    
    % Filtro
	canal4filt= filter(G,H,senalBandaAncha);
	% % 
	% Graficas
	figure;
	t=1/Fs;
	n=length(canal4filt);
	z=(0:n-1)*t;
	stem(z,canal4filt);
	title('Señal filtrada ');
	xlabel('tiempo (seg)');
	ylabel('Amplitud');
	 
	%espectro
	Resp= fft(canal4filt);
	n_1=length(canal4filt);
	M=abs(Resp);
	f_1=(0:n_1-1)*(Fs/n_1);
	figure;
	plot(f_1, M);
	title('Espectro de señal filtrada ');
	xlabel('Frecuencia (Hz)');
	ylabel('Magnitud');
    
    %d)
    close all;
   
      N = length(canal1filt); % Número de muestras
     t = (0:N-1) / Fs; % Vector de tiempo, basado en la longitud de las señales

% Generar tonos portadores para cada señal
portadora1 = cos(2*pi*60000*t);
portadora2 = cos(2*pi*64000*t);
portadora3 = cos(2*pi*68000*t);
portadora4 = cos(2*pi*72000*t);

% Demodulación: multiplicar las señales por sus respectivas portadoras
demod1 = canal1filt .* portadora1';
demod2 = canal2filt .* portadora2';
demod3 = canal3filt .* portadora3';
demod4 = canal4filt .* portadora4';

% Graficas
	figure;
	t=1/Fs;
	n=length(demod1);
	z=(0:n-1)*t;
	stem(z,demod1);
	title('Señal demodulada ');
	xlabel('tiempo (seg)');
	ylabel('Amplitud');
	 
	%espectro
	Resp= fft(demod1);
	n_1=length(demod1);
	M=abs(Resp);
	f_1=(0:n_1-1)*(Fs/n_1);
	figure;
	plot(f_1, M);
	title('Espectro de señal demodulada ');
	xlabel('Frecuencia (Hz)');
	ylabel('Magnitud');


    %f) g) H)
    % Filtro
	BBcanal1= filter(I,J,demod1);
    BBcanal2= filter(I,J,demod2);
    BBcanal3= filter(I,J,demod3);
    BBcanal4= filter(I,J,demod4);
	% Graficas
	figure;
	t=1/Fs;
	n=length(BBcanal1);
	z=(0:n-1)*t;
	stem(z,BBcanal1);
	title('Señal banda base ');
	xlabel('tiempo (seg)');
	ylabel('Amplitud');
	 
	%espectro
	Resp= fft(BBcanal1);
	n_1=length(BBcanal1);
	M=abs(Resp);
	f_1=(0:n_1-1)*(Fs/n_1);
	figure;
	plot(f_1, M);
	title('Espectro de señal banda base ');
	xlabel('Frecuencia (Hz)');
	ylabel('Magnitud');
    
    %i)
    
    audiowrite('BBcanal1.wav', BBcanal1, Fs);
    audiowrite('BBcanal2.wav', BBcanal2, Fs);
    audiowrite('BBcanal3.wav', BBcanal3, Fs);
    audiowrite('BBcanal4.wav', BBcanal4, Fs);
    
    [audio, Fs]= audioread('BBcanal1.wav');
    Fs_new= 8000;
    audio_fsnew = resample(audio, Fs_new, Fs);
    audiowrite('ernesto8Kdem.wav',audio_fsnew, Fs_new);
    
      [audio, Fs]= audioread('BBcanal2.wav');
    Fs_new= 8000;
    audio_fsnew = resample(audio, Fs_new, Fs);
    audiowrite('hector8Kdem.wav',audio_fsnew, Fs_new);
    
      [audio, Fs]= audioread('BBcanal3.wav');
    Fs_new= 8000;
    audio_fsnew = resample(audio, Fs_new, Fs);
    audiowrite('juanjo8Kdem.wav',audio_fsnew, Fs_new);
    
      [audio, Fs]= audioread('BBcanal4.wav');
    Fs_new= 8000;
    audio_fsnew = resample(audio, Fs_new, Fs);
    audiowrite('santi8Kdem.wav',audio_fsnew, Fs_new);
    