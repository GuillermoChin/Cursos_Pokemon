% Clase 10 - Normalizaci�n y escalamiento de estad�sticas Pok�mon
clear; clc;

% Cargar dataset
pokemon = readtable("Pokemon.csv");

% Estandarizar nombres de variables
pokemon.Properties.VariableNames = matlab.lang.makeValidName(pokemon.Properties.VariableNames);

% Corregir nombres con puntos
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Atk', 'Sp_Atk');
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Def', 'Sp_Def');

% Seleccionar estad�sticas num�ricas
stats = {'HP', 'Attack', 'Defense', 'Sp_Atk', 'Sp_Def', 'Speed', 'Total'};
X = pokemon{:, stats};  % Matriz num�rica

% --------------------------------------------
% 1. Normalizaci�n Min-Max (rango [0, 1])
% --------------------------------------------
X_min = min(X, [], 1);
X_max = max(X, [], 1);
X_norm = (X - X_min) ./ (X_max - X_min);

% --------------------------------------------
% 2. Estandarizaci�n Z-score (media 0, std 1)
% --------------------------------------------
X_mean = mean(X, 'omitnan');
X_std  = std(X, 'omitnan');
X_z    = (X - X_mean) ./ X_std;

% --------------------------------------------
% 3. Visualizaci�n: comparaci�n antes y despu�s
% --------------------------------------------
figure
subplot(1,3,1)
boxplot(X, 'Labels', stats)
title('Datos originales')

subplot(1,3,2)
boxplot(X_norm, 'Labels', stats)
title('Normalizaci�n Min-Max')

subplot(1,3,3)
boxplot(X_z, 'Labels', stats)
title('Estandarizaci�n Z-score')

sgtitle(' Comparaci�n de Escalamiento de Estad�sticas Pok�mon')

% --------------------------------------------
% 4. Guardar resultados (opcional)
% --------------------------------------------
% % Crear nuevas tablas
% pokemon_norm = array2table(X_norm, 'VariableNames', stats);
% pokemon_z    = array2table(X_z,    'VariableNames', stats);
% 
% % Adjuntar a la tabla original
% pokemon_normalizado = [pokemon(:,1:2) pokemon_norm];
% pokemon_estandarizado = [pokemon(:,1:2) pokemon_z];
% 
% % Guardar como archivos nuevos
% writetable(pokemon_normalizado, 'pokemon_normalizado.csv');
% writetable(pokemon_estandarizado, 'pokemon_estandarizado.csv');