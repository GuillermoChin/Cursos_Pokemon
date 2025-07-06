% Clase 10 - Normalización y escalamiento de estadísticas Pokémon
clear; clc;

% Cargar dataset
pokemon = readtable("Pokemon.csv");

% Estandarizar nombres de variables
pokemon.Properties.VariableNames = matlab.lang.makeValidName(pokemon.Properties.VariableNames);

% Corregir nombres con puntos
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Atk', 'Sp_Atk');
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Def', 'Sp_Def');

% Seleccionar estadísticas numéricas
stats = {'HP', 'Attack', 'Defense', 'Sp_Atk', 'Sp_Def', 'Speed', 'Total'};
X = pokemon{:, stats};  % Matriz numérica

% --------------------------------------------
% 1. Normalización Min-Max (rango [0, 1])
% --------------------------------------------
X_min = min(X, [], 1);
X_max = max(X, [], 1);
X_norm = (X - X_min) ./ (X_max - X_min);

% --------------------------------------------
% 2. Estandarización Z-score (media 0, std 1)
% --------------------------------------------
X_mean = mean(X, 'omitnan');
X_std  = std(X, 'omitnan');
X_z    = (X - X_mean) ./ X_std;

% --------------------------------------------
% 3. Visualización: comparación antes y después
% --------------------------------------------
figure
subplot(1,3,1)
boxplot(X, 'Labels', stats)
title('Datos originales')

subplot(1,3,2)
boxplot(X_norm, 'Labels', stats)
title('Normalización Min-Max')

subplot(1,3,3)
boxplot(X_z, 'Labels', stats)
title('Estandarización Z-score')

sgtitle(' Comparación de Escalamiento de Estadísticas Pokémon')

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