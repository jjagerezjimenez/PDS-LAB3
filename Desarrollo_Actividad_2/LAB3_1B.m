% Lista de archivos de audio
audioFiles = {'ernesto328k.wav', 'hector328k.wav', 'juanjo328k.wav', 'santi328k.wav'};  % Agrega los nombres de tus archivos aquí

% Número de archivos
numAudios = length(audioFiles);

for i = 1:numAudios
    % Crear una nueva figura para cada archivo de audio
    figure;
    
    % Cargar cada archivo de audio
    [audioData, fs] = audioread(audioFiles{i});
    
    % Crear el vector de tiempo
    t = (0:length(audioData)-1) / fs;
    
    % Graficar la señal de audio
    plot(t, audioData);
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    
    % Añadir el título con el nombre del archivo de audio
    title(['Señal de Audio - ', audioFiles{i}]);
    grid on;
end
