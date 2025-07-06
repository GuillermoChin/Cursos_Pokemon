% Clase 8 - Correlaci�n entre estad�sticas de Pok�mon
clear; clc;

% Cargar el dataset
pokemon = readtable("Pokemon.csv");

% Seleccionar columnas num�ricas relevantes
vars = {'HP', 'Attack', 'Defense', 'Sp_Atk', 'Sp_Def', 'Speed', 'Total'};

% Algunos nombres pueden tener puntos o espacios, corregimos:
pokemon.Properties.VariableNames = matlab.lang.makeValidName(pokemon.Properties.VariableNames);

% Extraer los datos como matriz num�rica
datos = pokemon{:, vars};

% --------------------------------------------
% 1. Calcular la matriz de correlaci�n
% --------------------------------------------
corrMatrix = corrcoef(datos, 'Rows','pairwise');

% Mostrar la matriz como tabla
disp(" Matriz de correlaci�n:")
disp(array2table(corrMatrix, 'VariableNames', vars, 'RowNames', vars))

% --------------------------------------------
% 2. Visualizaci�n tipo heatmap
% --------------------------------------------
figure
h = heatmap(vars, vars, corrMatrix, ...
    'Colormap', 1-hot, ...
    'ColorbarVisible','on', ...
    'CellLabelFormat','%.2f');
title(" Matriz de Correlaci�n - Estad�sticas de Pok�mon")

% --------------------------------------------
% 3. Visualizaci�n tipo scatter matrix
% --------------------------------------------
figure
gplotmatrix(datos, [], [], 'brgmcyk', '.', [], [], 'variable', vars)
title(" Matriz de Dispersi�n - Estad�sticas de Pok�mon")