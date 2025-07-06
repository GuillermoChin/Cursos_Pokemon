% Clase 6 - Estadística descriptiva básica
clear; clc;

% Cargar dataset limpio
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\AnimeList.csv');

% -----------------------------------------------------
%  Verificación y regeneración de columnas numéricas
% -----------------------------------------------------

% --------- Score ---------
if iscell(anime.score) || isstring(anime.score)
    anime.score = str2double(string(anime.score));
end

% --------- Members ---------
if iscell(anime.members) || isstring(anime.members)
    anime.members = str2double(string(anime.members));
end

% --------- Episodes (REGENERADO correctamente) ---------
if ismember('episodes', anime.Properties.VariableNames)
    anime.episodes = string(anime.episodes);
    anime.episodes(anime.episodes == "Unknown" | strlength(anime.episodes) == 0) = missing;
    anime.episodes_num = str2double(anime.episodes);
else
    error("La columna 'episodes' no está disponible en el archivo.")
end

% -----------------------------------------------------
%  Extraer columnas numéricas limpias
% -----------------------------------------------------
score    = anime.score;
episodes = anime.episodes_num;
members  = anime.members;

% -----------------------------------------------------
%  Estadísticas Descriptivas
% -----------------------------------------------------

% Score
meanScore   = mean(score, 'omitnan');
medianScore = median(score, 'omitnan');
modeScore   = mode(score);
stdScore    = std(score, 'omitnan');
rangeScore  = range(score);

% Episodes
meanEpisodes   = mean(episodes, 'omitnan');
medianEpisodes = median(episodes, 'omitnan');
stdEpisodes    = std(episodes, 'omitnan');

% Members
meanMembers   = mean(members, 'omitnan');
medianMembers = median(members, 'omitnan');
stdMembers    = std(members, 'omitnan');

% Mostrar resumen
fprintf("\n Estadísticas descriptivas:\n")
fprintf("Score    - Media: %.2f | Mediana: %.2f | Moda: %.2f | Std: %.2f | Rango: %.2f\n", ...
    meanScore, medianScore, modeScore, stdScore, rangeScore)
fprintf("Episodes - Media: %.2f | Mediana: %.0f | Std: %.2f\n", ...
    meanEpisodes, medianEpisodes, stdEpisodes)
fprintf("Members  - Media: %.0f | Mediana: %.0f | Std: %.0f\n", ...
    meanMembers, medianMembers, stdMembers)

% -----------------------------------------------------
%  Tabla resumen
% -----------------------------------------------------
Variable = ["Score"; "Episodios"; "Miembros"];
Media    = [meanScore; meanEpisodes; meanMembers];
Mediana  = [medianScore; medianEpisodes; medianMembers];
DesvStd  = [stdScore; stdEpisodes; stdMembers];

summaryTable = table(Variable, Media, Mediana, DesvStd);
disp(" Tabla resumen:")
disp(summaryTable)

% -----------------------------------------------------
%  Visualización – Boxplots con escalas adecuadas
% -----------------------------------------------------

figure

% Boxplot - Score
subplot(1,3,1)
boxplot(score)
title('Boxplot - Score')
ylabel('Score')
ylim([0 10])

% Boxplot - Episodes
subplot(1,3,2)
boxplot(episodes)
title('Boxplot - Episodios')
ylabel('Episodios')
ylim([0 150])  % puedes ajustar según distribución real

% Boxplot - Members
subplot(1,3,3)
boxplot(members)
title('Boxplot - Miembros')
ylabel('Miembros')
ylim([0 2000000])  % ajusta según tus datos