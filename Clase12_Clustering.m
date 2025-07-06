% CLASE 12 - Clustering y análisis de grupos en Pokémon
clear; clc;

% Cargar y preparar el dataset
pokemon = readtable("Pokemon.csv");
pokemon.Properties.VariableNames = matlab.lang.makeValidName(pokemon.Properties.VariableNames);
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Atk', 'Sp_Atk');
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Def', 'Sp_Def');

% Estadísticas a usar para clustering
stats = {'HP', 'Attack', 'Defense', 'Sp_Atk', 'Sp_Def', 'Speed', 'Total'};
X = pokemon{:, stats};

% Z-score
mu = mean(X, 'omitnan');
sigma = std(X, 'omitnan');
Z = (X - mu) ./ sigma;

% Filtrar filas válidas
valid_rows = all(~isnan(Z), 2);
Z = Z(valid_rows, :);
pokemon_clean = pokemon(valid_rows, :);

% Ejecutar K-means
k = 4;
rng(1);  % semilla
[cluster_labels, centroids] = kmeans(Z, k, 'Replicates', 5);
pokemon_clean.Cluster = cluster_labels;

% --------------------------------------------
%  1. Visualización en 2D y 3D
% --------------------------------------------
figure
gscatter(pokemon_clean.Attack, pokemon_clean.Speed, cluster_labels)
xlabel('Attack'); ylabel('Speed');
title('Clustering 2D - Attack vs Speed')
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4')

figure
scatter3(pokemon_clean.Attack, pokemon_clean.Speed, pokemon_clean.Defense, ...
    60, cluster_labels, 'filled')
xlabel('Attack'); ylabel('Speed'); zlabel('Defense')
title('Clustering 3D - Attack, Speed, Defense')
grid on; view(45, 30)

% --------------------------------------------
%  2. Análisis de estadísticas por grupo
% --------------------------------------------
cluster_summary = groupsummary(pokemon_clean, "Cluster", "mean", stats);
disp(" Promedios por cluster:")
disp(cluster_summary)

% --------------------------------------------
%  3. Boxplots por grupo
% --------------------------------------------
for i = 1:length(stats)
    figure
    boxplot(pokemon_clean{:, stats{i}}, pokemon_clean.Cluster)
    title(['Distribución de ', stats{i}, ' por Cluster'])
    xlabel('Cluster'); ylabel(stats{i})
end

% --------------------------------------------
%  4. Distribución de legendarios por cluster
% --------------------------------------------
% Convertir a variable lógica para poder contar
legend_is_true = strcmp(string(pokemon_clean.Legendary), "TRUE");

% Contar cuántos legendarios hay por cluster
legend_counts = grpstats(double(legend_is_true), pokemon_clean.Cluster, 'sum');

figure
bar(1:k, double(legend_counts))
title('Cantidad de legendarios por cluster')
xlabel('Cluster')
ylabel('N° de Legendarios')
xticks(1:k)

% --------------------------------------------
%  5. Distribución por tipo
% --------------------------------------------
% Paso previo: asegurar que Type_1 sea texto
if iscategorical(pokemon_clean.Type1)
    tipo_str = string(pokemon_clean.Type1);
elseif iscell(pokemon_clean.Type1)
    tipo_str = string(pokemon_clean.Type1);
else
    tipo_str = pokemon_clean.Type1;
end

% Crear la tabla cruzada: tipo vs cluster
[tab, tipos, ~] = crosstab(tipo_str, pokemon_clean.Cluster);

% Gráfica corregida
figure
bar(tab, 'stacked')
title('Distribución de Tipos por Cluster')
xlabel('Tipo')
ylabel('Cantidad')
legend("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", 'Location', 'northeast')

% Aplicar nombres de tipo en eje X
set(gca, 'XTick', 1:length(tipos), 'XTickLabel', tipos)
xtickangle(90)