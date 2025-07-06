% Clase 4 - Limpieza de datos II Estandarizaci�n
clear; clc;

% Cargar dataset original
anime = readtable('C:\Users\ching\Documents\MATLAB\Mis Cursos\Cursos_Pokemon\Data_Sets\anime_cleaned.csv');

% Distribuci�n de 'Genero'
disp('Frecuencia de "type":')
tabulate(anime.genre)

% --------- Estandarizaci�n de 'type' ---------
anime.type = lower(strtrim(string(anime.type)));

% Verificar tipos �nicos
disp("Valores �nicos de 'type':")
disp(unique(anime.type))

% --------- Estandarizaci�n preliminar de 'genre' ---------
if iscell(anime.genre)
    anime.genre = string(anime.genre);
end
anime.genre = strtrim(anime.genre);

% --------- Eliminaci�n de duplicados ---------
anime = unique(anime, 'rows');

% --------- Detecci�n de outliers ---------
% out_ep = isoutlier(anime.episodes);
out_ep = isoutlier(anime.episodes_num);
out_members = isoutlier(anime.members);

disp(['Outliers en episodios: ', num2str(sum(out_ep))])
disp(['Outliers en miembros: ', num2str(sum(out_members))])

% Eliminaci�n de outliers
anime(out_ep | out_members, :) = [];

% --------- Guardar dataset final limpio ---------
writetable(anime, 'anime_clean_final.csv')