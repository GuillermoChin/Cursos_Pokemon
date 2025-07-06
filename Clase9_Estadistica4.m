% Clase 9 - Análisis por tipo y legendarios (versión corregida)
clear; clc;

% Cargar el dataset
pokemon = readtable("Pokemon.csv");

% Estandarizar nombres de columnas
pokemon.Properties.VariableNames = matlab.lang.makeValidName(pokemon.Properties.VariableNames);

% Mostrar nombres para confirmar
disp(" Nombres de columnas disponibles:")
disp(pokemon.Properties.VariableNames')

% Renombrar columnas con puntos si es necesario
% 'Sp..Atk'  'Sp_Atk', 'Sp..Def'  'Sp_Def'
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Atk', 'Sp_Atk');
pokemon.Properties.VariableNames = strrep(pokemon.Properties.VariableNames, 'Sp__Def', 'Sp_Def');

% Verifica nombres exactos de nuevo
stats = {'HP', 'Attack', 'Defense', 'Sp_Atk', 'Sp_Def', 'Speed', 'Total'};

% Convertir 'Legendary' y 'Type_1' a categóricos si no lo son
if ~iscategorical(pokemon.Legendary)
    pokemon.Legendary = categorical(pokemon.Legendary);
end
if ~iscategorical(pokemon.Type1)
    pokemon.Type1 = categorical(pokemon.Type1);
end

% --------------------------------------------
% 1. Agrupación por tipo (Type_1)
% --------------------------------------------
groupType = groupsummary(pokemon, "Type1", "mean", stats);
disp(" Promedios por tipo:")
disp(groupType(:, [1 2:end]))

% --------------------------------------------
% 2. Boxplot: Total por tipo
% --------------------------------------------
figure
boxplot(pokemon.Total, pokemon.Type1)
title("Distribución de Total por Tipo de Pokémon")
xlabel("Tipo")
ylabel("Total")
xtickangle(45)

% --------------------------------------------
% 3. Comparación entre legendarios y no legendarios
% --------------------------------------------
figure
boxplot(pokemon.Total, pokemon.Legendary)
xticklabels({'No Legendario', 'Legendario'})
title("Total: Legendarios vs No legendarios")
ylabel("Total")

% --------------------------------------------
% 4. Promedio de estadísticas entre legendarios y no
% --------------------------------------------
groupLegend = groupsummary(pokemon, "Legendary", "mean", stats);
disp(" Promedios para legendarios vs no legendarios:")
disp(groupLegend)

% --------------------------------------------
% 5. Gráfico de barras comparativo
% --------------------------------------------
figure
bar(categorical(groupLegend.Legendary), [groupLegend.mean_HP, groupLegend.mean_Attack, ...
    groupLegend.mean_Sp_Atk, groupLegend.mean_Speed])
title("Comparación de medias entre Legendarios y No")
legend({'HP','Attack','Sp.Atk','Speed'}, 'Location','northwest')
ylabel("Media de estadística")