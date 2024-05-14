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
station(ID, Name, Type, StopTime, Station) :-
    Station = [ID, Name, Type, StopTime].

% Predicado para verificar si un término es una estación válida
is_station(Station) :- Station = station(Id, Name, Type, StopTime),integer(Id),string(Name),string(Type),integer(StopTime),StopTime>=0.
