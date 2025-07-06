% Clase 4 - Limpieza de datos II Estandarización
clear; clc;

% Cargar dataset original
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\anime_cleaned.csv');

% Distribución de 'Genero'
disp('Frecuencia de "type":')
tabulate(anime.genre)

% --------- Estandarización de 'type' ---------
anime.type = lower(strtrim(string(anime.type)));

% Verificar tipos únicos
disp("Valores únicos de 'type':")
disp(unique(anime.type))

% --------- Estandarización preliminar de 'genre' ---------
if iscell(anime.genre)
    anime.genre = string(anime.genre);
end
anime.genre = strtrim(anime.genre);

% --------- Eliminación de duplicados ---------
anime = unique(anime, 'rows');

% --------- Detección de outliers ---------
% out_ep = isoutlier(anime.episodes);
out_ep = isoutlier(anime.episodes_num);
out_members = isoutlier(anime.members);

disp(['Outliers en episodios: ', num2str(sum(out_ep))])
disp(['Outliers en miembros: ', num2str(sum(out_members))])

% Eliminación de outliers
anime(out_ep | out_members, :) = [];

% --------- Guardar dataset final limpio ---------
writetable(anime, 'anime_clean_final.csv')