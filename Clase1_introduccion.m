% Análisis de Datos - Clase 1: Introducción y carga de datos
clear; clc;

% Ruta del archivo CSV
%archivo = 'anime.csv'; % Asegúrate de tener el archivo en el mismo directorio
archivo = 'C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\AnimeList.csv'

% Leer el archivo CSV como tabla
animeData = readtable(archivo);
%%
% Mostrar las primeras 10 filas
disp("Primeras filas del dataset:")
disp(head(animeData,10))
%%

% Mostrar resumen general
disp("Resumen del dataset:")
summary(animeData)
%%

% Número de registros
numAnimes = height(animeData);
disp(['Número total de animes: ', num2str(numAnimes)])
%%

% Mostrar nombres de las variables
disp("Columnas del dataset:")
disp(animeData.Properties.VariableNames)
%%

% Mostrar los tipos de datos de cada columna
disp("Tipos de datos por columna:")
varTypes = varfun(@class, animeData, 'OutputFormat','table');
disp(varTypes)
%%

% Guardar copia preliminar
% writetable(animeData, 'animeData_clean.csv')