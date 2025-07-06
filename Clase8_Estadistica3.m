% Clase 8 - Correlación entre estadísticas de Pokémon
clear; clc;

% Cargar el dataset
pokemon = readtable("Pokemon.csv");

% Seleccionar columnas numéricas relevantes
vars = {'HP', 'Attack', 'Defense', 'Sp_Atk', 'Sp_Def', 'Speed', 'Total'};

% Algunos nombres pueden tener puntos o espacios, corregimos:
pokemon.Properties.VariableNames = matlab.lang.makeValidName(pokemon.Properties.VariableNames);

% Extraer los datos como matriz numérica
datos = pokemon{:, vars};

% --------------------------------------------
% 1. Calcular la matriz de correlación
% --------------------------------------------
corrMatrix = corrcoef(datos, 'Rows','pairwise');

% Mostrar la matriz como tabla
disp(" Matriz de correlación:")
disp(array2table(corrMatrix, 'VariableNames', vars, 'RowNames', vars))

% --------------------------------------------
% 2. Visualización tipo heatmap
% --------------------------------------------
figure
h = heatmap(vars, vars, corrMatrix, ...
    'Colormap', 1-hot, ...
    'ColorbarVisible','on', ...
    'CellLabelFormat','%.2f');
title(" Matriz de Correlación - Estadísticas de Pokémon")

% --------------------------------------------
% 3. Visualización tipo scatter matrix
% --------------------------------------------
figure
gplotmatrix(datos, [], [], 'brgmcyk', '.', [], [], 'variable', vars)
title(" Matriz de Dispersión - Estadísticas de Pokémon")