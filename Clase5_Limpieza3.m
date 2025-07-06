% Clase 5: Limpieza III
clear; clc;

% Cargar dataset limpio
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\anime_clean_final.csv');

% Eliminar filas vac�as en genre
anime = anime(~ismissing(anime.genre), :);

% Convertimos a string si no lo es
anime.genre = string(anime.genre);

% Crear lista para almacenar g�neros separados
allGenres = [];

% Iterar sobre cada fila para separar los g�neros por coma
for i = 1:height(anime)
    % Separar la lista de g�neros
    g = strtrim(split(anime.genre(i), ','));
    
    % A�adir a la lista global
    allGenres = [allGenres; g];
end

% Contar frecuencia de cada g�nero
[uniqueGenres, ~, idx] = unique(allGenres);
counts = accumarray(idx, 1);

% Crear tabla de resultados
genreTable = table(uniqueGenres, counts, ...
    'VariableNames', {'Genre','Count'});

% Ordenar por frecuencia descendente
genreTable = sortrows(genreTable, 'Count', 'descend');

% Mostrar top 10 g�neros
disp(genreTable(1:10,:))

% Graficar top 10 g�neros
figure
barh(genreTable.Count(1:10))
yticklabels(genreTable.Genre(1:10))
ytickangle(0)
xlabel('N�mero de apariciones')
title('Top 10 g�neros de anime')
set(gca, 'YDir','reverse') % para que el m�s alto est� arriba