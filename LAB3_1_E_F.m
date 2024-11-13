% Cerrar todas las figuras abiertas
close all;


% Lista de archivos de se?ales moduladas
archivosModulados = {'modulada_ernesto328k.wav', 'modulada_hector328k.wav', 'modulada_juanjo328k.wav', 'modulada_santi328k.wav'};

% Frecuencia de muestreo
Fs = 328000;  % 328 kHz

% Frecuencias portadoras para cada canal (en Hz)
frecuenciasPortadoras = [60000, 64000, 68000, 72000];  % 60 kHz, 64 kHz, 68 kHz, 72 kHz

% Inicializar celda para almacenar las se?ales filtradas
senalesFiltradas = cell(1, length(archivosModulados));

for k = 1:length(archivosModulados)
    % Leer la se?al modulada
    [Xk_modulada, ~] = audioread(archivosModulados{k});
    
    % Especificaciones del filtro
    fc = frecuenciasPortadoras(k) - 2000;  % Frecuencia de corte (para probar uso 2 kHz por debajo de la portadora, hay que revisar bien esto con el criterio de los 3dB)
    
    % Frecuencia de corte normalizada
    Wn = fc / (Fs/2);  % Normalizar respecto a la frecuencia de Nyquist
    
    % Orden del filtro
    N = 6;  % ajustar segun convenga - Esto tenemos que ver bien en papel (ver lab 2)
    
    % Dise?o del filtro pasa altos Butterworth
    [b, a] = butter(N, Wn, 'high');
    
    % Verificar la respuesta en frecuencia del filtro
    [H, f_resp] = freqz(b, a, 1024, Fs);
    figure;
    plot(f_resp, 20*log10(abs(H)));
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud (dB)');
    title(['Respuesta en Frecuencia del Filtro - Canal ', num2str(k)]);
    grid on;
    
    
    
    
        % f) Procesar la se?al correspondiente a cada canal utilizando la funci?n ?filter? de Matlab.
    
    % Aplicar el filtro a la se?al modulada
    Xk_filtrada = filter(b, a, Xk_modulada);
    
    % Guardar la se?al filtrada
    senalesFiltradas{k} = Xk_filtrada;
    
    % Guardar la se?al filtrada en un archivo 
    nombreArchivoFiltrado = ['filtrada_' archivosModulados{k}];
    audiowrite(nombreArchivoFiltrado, Xk_filtrada, Fs);
    
    % Calcular y graficar el espectro antes y despu?s del filtrado
    L = length(Xk_modulada);
    f_vec = (-L/2:L/2-1)*(Fs/L);    %probar bien
    
    Y_modulada = fftshift(fft(Xk_modulada));
    P_modulada = abs(Y_modulada)/L;
    
    Y_filtrada = fftshift(fft(Xk_filtrada));
    P_filtrada = abs(Y_filtrada)/L;
    
    figure;
    subplot(2,1,1);
    plot(f_vec, P_modulada);
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    title(['Espectro Antes del Filtrado - Canal ', num2str(k)]);
    xlim([frecuenciasPortadoras(k)-15000, frecuenciasPortadoras(k)+15000]);
    grid on;
    
    subplot(2,1,2);
    plot(f_vec, P_filtrada);
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    title(['Espectro Despu?s del Filtrado - Canal ', num2str(k)]);
    xlim([frecuenciasPortadoras(k)-15000, frecuenciasPortadoras(k)+15000]);
    grid on;
end
