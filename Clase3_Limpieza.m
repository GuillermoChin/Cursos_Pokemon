% Clase 3 - Limpieza de datos I
clear; clc;

% Cargar dataset original
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\AnimeList.csv');

% --------- Episodios: de texto a número ---------
% Convertimos a string si fuera necesario
if ~isa(anime.episodes, 'string')
    anime.episodes = string(anime.episodes);
end

% Convertimos a numérico (Unknown se vuelve NaN)
anime.episodes_num = str2double(anime.episodes);

% Eliminamos la columna original
anime.episodes = [];

% --------- Rating: eliminar registros vacíos ---------
anime = rmmissing(anime, 'DataVariables', {'rating'});

% --------- Members: convertir si fuera string ---------
if iscell(anime.members) || isstring(anime.members)
    anime.members = str2double(string(anime.members));
end

% --------- Género y Studio: solo revisar ---------
disp(['Faltantes en genre: ', num2str(sum(ismissing(anime.genre)))])
disp(['Faltantes en studio: ', num2str(sum(ismissing(anime.studio)))])

% --------- Guardar dataset limpio ---------
writetable(anime, 'anime_cleaned.csv')