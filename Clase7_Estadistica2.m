% Clase 7 - Correlación entre variables
clear; clc;

% Leer archivo limpio
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\AnimeList.csv');

% Asegurar tipos correctos
anime.score = double(string(anime.score));
anime.members = double(string(anime.members));
anime.episodes = string(anime.episodes);
anime.episodes(anime.episodes == "Unknown" | strlength(anime.episodes) == 0) = missing;
anime.episodes_num = str2double(anime.episodes);

% Extraer variables
score = anime.score;
members = anime.members;
episodes = anime.episodes_num;

% Matriz de correlación
varsMatrix = [score, members, episodes];
corrMatrix = corrcoef(varsMatrix, 'Rows', 'pairwise');

% Mostrar matriz
disp(" Matriz de correlación entre variables:")
disp(array2table(corrMatrix, ...
    'VariableNames', {'Score', 'Members', 'Episodes'}, ...
    'RowNames', {'Score', 'Members', 'Episodes'}))

% ----------- Visualizaciones -----------

% Score vs Members
figure
scatter(members, score, 15, 'filled')
xlabel('Miembros')
ylabel('Score')
title('Relación entre Score y Members')
lsline
xlim([0 500000])
ylim([0 10])

% Score vs Episodios
figure
scatter(episodes, score, 15, 'filled')
xlabel('Episodios')
ylabel('Score')
title('Relación entre Score y Episodios')
lsline
ylim([0 10])