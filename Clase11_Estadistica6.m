% Clase 11 - Detecci�n de outliers con Z-score
clear; clc;

% Leer dataset y preparar columnas
pokemon = readtable("Pokemon.csv");
pokemon.Properties.VariableNames = matlab.lang.makeValidName(pokemon.Properties.VariableNames);
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Atk', 'Sp_Atk');
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Def', 'Sp_Def');

% Estad�sticas a analizar
stats = {'HP', 'Attack', 'Defense', 'Sp_Atk', 'Sp_Def', 'Speed', 'Total'};
X = pokemon{:, stats};

% Estandarizar con Z-score
mu = mean(X, 'omitnan');
sigma = std(X, 'omitnan');
Z = (X - mu) ./ sigma;

% --------------------------------------------
% 1. Detectar outliers por criterio |Z| > 3
% --------------------------------------------
is_outlier = abs(Z) > 3;

% Marcar Pok�mon como outliers si tienen al menos un atributo fuera de rango
outlier_idx = any(is_outlier, 2);

% Tabla de Pok�mon outliers
outliers_table = pokemon(outlier_idx, :);
disp(" Pok�mon considerados outliers por Z-score > 3:")
disp(outliers_table(:, {'Name', 'Type1', 'Legendary', 'Total'}))

% --------------------------------------------
% 2. Visualizaci�n: Boxplot con todos los stats (Z)
% --------------------------------------------
figure
boxplot(Z, 'Labels', stats)
title('Z-score de estad�sticas Pok�mon')
ylabel('Z-score')
yline(3, '--r', 'Outlier +3', 'LabelHorizontalAlignment','left')
yline(-3, '--r', 'Outlier -3', 'LabelHorizontalAlignment','left')