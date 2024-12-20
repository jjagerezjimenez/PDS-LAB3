% Cerrar todas las figuras abiertas
close all;

% Lista de archivos de audio resampleados
archivosAudio = {'ernesto328k.wav', 'hector328k.wav', 'juanjo328k.wav', 'santi328k.wav'};

% Frecuencia de muestreo
Fs = 328000;  % 328 kHz

% Frecuencias portadoras para cada canal (en Hz)
frecuenciasPortadoras = [60000, 64000, 68000, 72000];  % 60 kHz, 64 kHz, 68 kHz, 72 kHz

% Inicializar celda para almacenar las se?ales moduladas
senalesModuladas = cell(1, length(archivosAudio));

for k = 1:length(archivosAudio)
    % Leer la se?al de audio resampleada
    [Xk_n, ~] = audioread(archivosAudio{k});
    
    % Crear vector de muestras n
    n = (0:length(Xk_n)-1)';  % Vector columna de enteros
    
    % Calcular la frecuencia angular omega_k
    fk = frecuenciasPortadoras(k);         % Frecuencia portadora en Hz
    omega_k = 2 * pi * fk / Fs;            % Frecuencia angular en radianes
    
    % Calcular cos(omega_k * n)
    cos_omega_n = cos(omega_k * n);
    
    % Realizar el desplazamiento en frecuencia utilizando la ecuaci?n X'_k[n] = X_k[n] * cos(omega_k * n)
    Xk_modulada = Xk_n .* cos_omega_n;
    
    % Guardar la se?al modulada
    senalesModuladas{k} = Xk_modulada;
    
    %Guardar la se?al modulada en un archivo -- no se si es necesario,
    %consultar (no se escuchan los audios)
    nombreArchivoModulado = ['modulada_' archivosAudio{k}];
    audiowrite(nombreArchivoModulado, Xk_modulada, Fs);
end

% Seleccionar el canal a graficar (del 1 al 4)
k = 1;

% Obtener la se?al modulada
Xk_modulada = senalesModuladas{k};

% Crear vector de tiempo 'n' en segundos
t = n / Fs;

% Graficar la se?al modulada en el dominio del tiempo
figure;
plot(t, Xk_modulada);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title(['Se?al Modulada en el Tiempo - Canal ', num2str(k), ' (', archivosAudio{k}, ')']);
grid on;

% Calcular y graficar el espectro de frecuencia
L = length(Xk_modulada);               % Longitud de la se?al
Y = fftshift(fft(Xk_modulada));        % FFT y centrar el espectro
f = (-L/2:L/2-1)*(Fs/L);               % Vector de frecuencia

% Calcular la magnitud del espectro
P = abs(Y)/L;

% Graficar el espectro en frecuencia
figure;
plot(f, P);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
title(['Espectro en Frecuencia - Se?al Modulada Canal ', num2str(k), ' (', archivosAudio{k}, ')']);
grid on;

% Ajustar los l?mites del eje x para enfocarse en la regi?n de inter?s
xlim([0, 100000]);  % Solo frecuencias positivas