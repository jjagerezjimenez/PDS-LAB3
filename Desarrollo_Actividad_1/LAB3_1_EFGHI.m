% Cerrar todas las figuras abiertas
close all;

% Configuraci?n inicial
Fs = 328000; % Frecuencia de muestreo
archivosAudio = {'ernesto328k.wav', 'hector328k.wav', 'juanjo328k.wav', 'santi328k.wav'};
frecuenciasPortadoras = [60000, 64000, 68000, 72000]; % Frecuencias portadoras

% Modulaci?n y filtrado de las se?ales
senalesFiltradas = cell(1, length(archivosAudio)); % Inicializar

for k = 1:length(archivosAudio)
    % Leer cada archivo de audio
    [Xk_n, ~] = audioread(archivosAudio{k});
    n = (0:length(Xk_n)-1)'; % Vector de muestras
    
    % Calcular la frecuencia angular
    omega_k = 2 * pi * frecuenciasPortadoras(k) / Fs;
    
    % Modulaci?n
    senalModulada = Xk_n .* cos(omega_k * n);
    
    % Dise?o del filtro pasa-altos para este canal
    Fc = frecuenciasPortadoras(k); % Frecuencia de corte para este canal
    Wn = Fc / (Fs / 2); % Normalizaci?n
    orden = 20; % Orden del filtro
    Rp = 1; % Ondulaci?n permitida en la banda de paso (en dB)
    [b, a] = cheby1(orden, Rp, Wn, 'high'); % Filtro pasa-altos Chebyshev
    
    % Aplicar el filtro pasa-altos
    senalesFiltradas{k} = filter(b, a, senalModulada);
    
    % Guardar las se?ales filtradas
    audiowrite(['filtrada_', archivosAudio{k}], senalesFiltradas{k}, Fs);
    
    % Graficar amplitud vs tiempo
    t = (0:length(senalesFiltradas{k})-1) / Fs; % Vector de tiempo
    figure;
    plot(t, senalesFiltradas{k});
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    title(['Se?al Filtrada Canal ', num2str(k), ' en el Tiempo']);
    grid on;
    
    % Espectro de frecuencia de cada se?al filtrada
    L = length(senalesFiltradas{k});
    Y = fftshift(fft(senalesFiltradas{k}));
    f = (-L/2:L/2-1) * (Fs / L); % Eje de frecuencia en Hz
    P = abs(Y) / L;
    
    % Graficar espectro individual
    figure;
    plot(f, P);
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    title(['Espectro de Frecuencia - Se?al Filtrada Canal ', num2str(k)]);
    grid on;
    xlim([0, 100000]); % Ajuste
end

% Sumar las se?ales filtradas para obtener la se?al de banda ancha
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

