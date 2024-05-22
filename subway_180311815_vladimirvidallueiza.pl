% TDA subway
% Representación: Lista
% Id (int)
% Nombre (string)
% Subway (list of subway)

% Predicado constructor subway
% subway(Id, Nombre, [Id, Nombre])
% Dominio:
% id (int) X nombre (string) X subway
% Meta primaria: subway/3
% Metas secundarias:
subway(Id, Nombre, Subway) :-
    Subway = [Id, Nombre].

% Predicado de pertenencia para verificar si es una red de metro válida
is_subway([Id, Nombre]) :-
    integer(Id),
    string(Nombre).

% Selectores
get_subway_id([Id, _], Id).
get_subway_nombre([_, Nombre], Nombre).
get_subway_trains([_, _, Trains], Trains).


% Predicado para añadir trenes a una red de metro
subwayAddTrain(Subway, NewTrains, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_nombre(Subway, Nombre),
    get_subway_trains(Subway, ExistingTrains),
    append(ExistingTrains, NewTrains, UpdatedTrains),
    SubwayOut = [Id, Nombre, UpdatedTrains].