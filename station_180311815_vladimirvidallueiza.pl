% TDA Station
% Representación: Lista
% Id (int)
% Name (string)
% Type (symbol)
% StopTime (positive integer)

% Reglas

% Predicado constructor de una Estación
% station(Id, Name, Type, StopTime, Station)
% Dominio:
% Id(int) X Name (string) X Type (symbol) X StopTime (positive integer) X Station (TDA station)
% Meta primaria: station/5
% Metas secundarias:

station(Id, Name, Type, StopTime, Station) :-
    Station = [Id, Name, Type, StopTime].

% Predicado de pertenencia de una Estación
% station?(Station)
% Dominio:
% Station (TDA station)
% Meta primaria: is_station?/1
% Metas secundarias:
% integer/1, string/1, positive_integer/1

is_station([Id, Name, Type, StopTime]) :-
    integer(Id),
    string(Name),
    string(Type),
    integer(StopTime),
    StopTime > 0.    

% Selectores

% get_station_id: selecciona el Id de la estación
% Dominio:
% Station (TDA station)
% Recorrido:
% Id (int)

get_station_id([Id, _, _, _], Id).

% get_station_name: selecciona el nombre de la estación
% Dominio:
% Station (TDA station)
% Recorrido:
% Name (string)

get_station_name([_, Name, _, _], Name).

% get_station_type: selecciona el tipo de la estación
% Dominio:
% Station (TDA station)
% Recorrido:
% Type (symbol)


get_station_type([_, _, Type, _], Type).

% get_station_stop_time: selecciona el tiempo de parada de la estación
% Dominio:
% Station (TDA station)
% Recorrido:
% StopTime (positive integer)
get_station_stop_time([_, _, _, StopTime], StopTime).    


