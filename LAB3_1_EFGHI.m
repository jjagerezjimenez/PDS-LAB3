% Cerrar todas las figuras abiertas
close all;

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
orden = 20; % Ajusta seg?n sea necesario
Rp = 1; % Ondulaci?n permitida en la banda de paso (en dB)
[b, a] = cheby1(orden, Rp, Wn, 'high'); % Filtro pasa-altos Chebyshev

% Verificar la respuesta del filtro
[H, f] = freqz(b, a, 1024, Fs); % Respuesta en frecuencia en Hz
figure;
plot(f, 20*log10(abs(H))); % Graficar en dB
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (dB)');
title('Respuesta del Filtro Pasa-Altos');
grid on;

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
f = (-L/2:L/2-1) * (Fs / L); % Eje de frecuencia en Hz
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
f = (-L/2:L/2-1) * (Fs / L); % Eje de frecuencia en Hz
P = abs(Y) / L;

figure;
plot(f, P);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
title('Espectro de Frecuencia - Se?al de Banda Ancha');
grid on;
xlim([0, 100000]); % Ajuste


