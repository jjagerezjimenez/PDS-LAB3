% Cerrar todas las figuras abiertas
close all;

% Lista de archivos de audio
audioFiles = {'ernesto328k.wav', 'hector328k.wav', 'juanjo328k.wav', 'santi328k.wav'};  % Agrega los nombres de tus archivos aquí


% Especifica los rangos de los ejes
% Para frecuencia en Hz
xMin = -5000;     % Rango mínimo de frecuencia
xMax = 5000;      % Rango máximo de frecuencia
% Para magnitud
yMin = 0;         % Rango mínimo de magnitud
yMax = 0.02;      % Rango máximo de magnitud

% Número de archivos
numAudios = length(audioFiles);

for i = 1:numAudios
    % Cargar cada archivo de audio
    [audioData, fs] = audioread(audioFiles{i});
    
    % Realizar la Transformada de Fourier
    L = length(audioData);       % Longitud de la señal
    Y = fftshift(fft(audioData)); % FFT y cambio para centrar el espectro
    f = (-L/2:L/2-1)*(fs/L);      % Vector de frecuencia que incluye negativas
    
    % Calcular la magnitud del espectro
    P = abs(Y)/L;
    
    % Crear una nueva figura para el espectro de frecuencia
    figure;
    
    % Graficar el espectro en frecuencia (incluyendo frecuencias negativas)
    plot(f, P);
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    
    % Añadir el título con el nombre del archivo de audio
    title(['Espectro en Frecuencia - ', audioFiles{i}]);
    grid on;
    
    % Ajustar los rangos de los ejes
    xlim([xMin, xMax]);  % Rango del eje x (frecuencia)
    ylim([yMin, yMax]);  % Rango del eje y (magnitud)
end
