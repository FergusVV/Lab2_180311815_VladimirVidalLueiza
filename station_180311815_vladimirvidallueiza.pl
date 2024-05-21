

%TDA station
%Representación: Lista
%Id (int)
%Name (string)
%type(string)
%stopTime (int)
%station (list of station)

%Reglas

%Predicado constructor station
% station(Id, Name, Type, StopTime, [Id, Name, Type, StopTime])
% Dominio:
%station id (int) X name (String)  X type (stationType) X stopTime X (positive integer)  X station (TDA station)
%Meta primaria: station/5
%Metas secundarias:
station(Id, Name, Type, StopTime, Station) :-
    Station = [Id, Name, Type, StopTime].

is_station([Id, Name, Type, StopTime]) :-
    integer(Id),
    string(Name),
    string(Type),
    integer(StopTime),
    StopTime > 0.    

% Selectores
get_station_id([Id, _, _, _], Id).
get_station_name([_, Name, _, _], Name).
get_station_type([_, _, Type, _], Type).
get_station_stop_time([_, _, _, StopTime], StopTime).    


