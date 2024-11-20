% Cerrar todas las figuras abiertas
close all;

% Lista de archivos de audio
audioFiles = {'ernesto328k.wav', 'hector328k.wav', 'juanjo328k.wav', 'santi328k.wav'};  % Agrega los nombres de tus archivos aqu�


% Especifica los rangos de los ejes
% Para frecuencia en Hz
xMin = -5000;     % Rango m�nimo de frecuencia
xMax = 5000;      % Rango m�ximo de frecuencia
% Para magnitud
yMin = 0;         % Rango m�nimo de magnitud
yMax = 0.02;      % Rango m�ximo de magnitud

% N�mero de archivos
numAudios = length(audioFiles);

for i = 1:numAudios
    % Cargar cada archivo de audio
    [audioData, fs] = audioread(audioFiles{i});
    
    % Realizar la Transformada de Fourier
    L = length(audioData);       % Longitud de la se�al
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
    
    % A�adir el t�tulo con el nombre del archivo de audio
    title(['Espectro en Frecuencia - ', audioFiles{i}]);
    grid on;
    
    % Ajustar los rangos de los ejes
    xlim([xMin, xMax]);  % Rango del eje x (frecuencia)
    ylim([yMin, yMax]);  % Rango del eje y (magnitud)
end
