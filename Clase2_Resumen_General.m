% Clase 2 - Exploración del dataset real
clear; clc;

% Leer datos reales
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\AnimeList.csv');

% Ver primeras filas y nombres de columnas
disp('Primeras filas:')
disp(head(anime,10))
disp('Columnas:')
disp(anime.Properties.VariableNames')

% Conteo de filas y columnas
[nRows, nCols] = size(anime);
disp(['Filas: ' num2str(nRows) ', Columnas: ' num2str(nCols)])

% Tipos de variables
disp('Tipos de columnas:')
disp(varfun(@class, anime, 'OutputFormat','table'))

% % Valores faltantes por columna
% disp('Valores faltantes por columna:')
% disp(sum(ismissing(anime))')
% 
% numericCols = {'episodes','rating','members'};
% for i = 1:numel(numericCols)
%     col = numericCols{i};
%     figure;
%     histogram(anime.(col))
%     title(['Distribución de ', col])
%     xlabel(col)
%     ylabel('Frecuencia')
% end


% Histogramas de columnas numéricas
numericCols = {'episodes','rating','members'};
for i=1:length(numericCols)
    col = numericCols{i};
    try
        figure
        histogram(anime.(col))
        title(['Distribución de ', col])
    catch
        warning(['No se pudo graficar ',col,'; revisa tipo de datos.'])
    end
end

% Distribución de 'type'
disp('Frecuencia de "type":')
tabulate(anime.type)