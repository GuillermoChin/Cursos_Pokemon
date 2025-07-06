% Clase 5: Limpieza III
clear; clc;

% Cargar dataset limpio
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\anime_clean_final.csv');

% Eliminar filas vacías en genre
anime = anime(~ismissing(anime.genre), :);

% Convertimos a string si no lo es
anime.genre = string(anime.genre);

% Crear lista para almacenar géneros separados
allGenres = [];

% Iterar sobre cada fila para separar los géneros por coma
for i = 1:height(anime)
    % Separar la lista de géneros
    g = strtrim(split(anime.genre(i), ','));
    
    % Añadir a la lista global
    allGenres = [allGenres; g];
end

% Contar frecuencia de cada género
[uniqueGenres, ~, idx] = unique(allGenres);
counts = accumarray(idx, 1);

% Crear tabla de resultados
genreTable = table(uniqueGenres, counts, ...
    'VariableNames', {'Genre','Count'});

% Ordenar por frecuencia descendente
genreTable = sortrows(genreTable, 'Count', 'descend');

% Mostrar top 10 géneros
disp(genreTable(1:10,:))

% Graficar top 10 géneros
figure
barh(genreTable.Count(1:10))
yticklabels(genreTable.Genre(1:10))
ytickangle(0)
xlabel('Número de apariciones')
title('Top 10 géneros de anime')
set(gca, 'YDir','reverse') % para que el más alto esté arriba