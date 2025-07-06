% Clase 9 - An�lisis por tipo y legendarios (versi�n corregida)
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

% Convertir 'Legendary' y 'Type_1' a categ�ricos si no lo son
if ~iscategorical(pokemon.Legendary)
    pokemon.Legendary = categorical(pokemon.Legendary);
end
if ~iscategorical(pokemon.Type1)
    pokemon.Type1 = categorical(pokemon.Type1);
end

% --------------------------------------------
% 1. Agrupaci�n por tipo (Type_1)
% --------------------------------------------
groupType = groupsummary(pokemon, "Type1", "mean", stats);
disp(" Promedios por tipo:")
disp(groupType(:, [1 2:end]))

% --------------------------------------------
% 2. Boxplot: Total por tipo
% --------------------------------------------
figure
boxplot(pokemon.Total, pokemon.Type1)
title("Distribuci�n de Total por Tipo de Pok�mon")
xlabel("Tipo")
ylabel("Total")
xtickangle(45)

% --------------------------------------------
% 3. Comparaci�n entre legendarios y no legendarios
% --------------------------------------------
figure
boxplot(pokemon.Total, pokemon.Legendary)
xticklabels({'No Legendario', 'Legendario'})
title("Total: Legendarios vs No legendarios")
ylabel("Total")

% --------------------------------------------
% 4. Promedio de estad�sticas entre legendarios y no
% --------------------------------------------
groupLegend = groupsummary(pokemon, "Legendary", "mean", stats);
disp(" Promedios para legendarios vs no legendarios:")
disp(groupLegend)

% --------------------------------------------
% 5. Gr�fico de barras comparativo
% --------------------------------------------
figure
bar(categorical(groupLegend.Legendary), [groupLegend.mean_HP, groupLegend.mean_Attack, ...
    groupLegend.mean_Sp_Atk, groupLegend.mean_Speed])
title("Comparaci�n de medias entre Legendarios y No")
legend({'HP','Attack','Sp.Atk','Speed'}, 'Location','northwest')
ylabel("Media de estad�stica")