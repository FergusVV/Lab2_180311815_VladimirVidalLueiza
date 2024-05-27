:- module(section_180311815_vladimirvidallueiza, 
    [section/5, is_section/1, get_section_point1/2, get_section_point2/2, get_section_distance/2, get_section_cost/2, get_stations/2]).


% TDA Section
% Representación: Lista
% section(Point1, Point2, Distance, Cost, Section)
% Dominio:
% Point1 (station) X Point2 (station) X Distance (number) X Cost (number) X Section (TDA section)
% Meta primaria: section/5

% Constructor
section(Point1, Point2, Distance, Cost, Section) :- 
    Section = [Point1, Point2, Distance, Cost].

% Predicados de pertenencia
% is_section(Section)
% Dominio:
% Section (TDA section)
% Meta primaria: is_section/1
% Metas secundarias:
% is_station/1, number/1
is_section([Point1, Point2, Distance, Cost]) :-
    is_station(Point1),
    is_station(Point2),
    number(Distance),
    Distance > 0,
    number(Cost),
    Cost >= 0.

% Selectores

% get_section_point1: selecciona el primer punto de la sección
% Dominio:
% Section (TDA section)
% Recorrido:
% Point1 (station)
% Meta primaria: get_section_point1/1

get_section_point1([Point1, _, _, _], Point1).

% get_section_point2: selecciona el segundo punto de la sección
% Dominio:
% Section (TDA section)
% Recorrido:
% Point2 (station)
% Meta primaria: get_section_point2/1

get_section_point2([_, Point2, _, _], Point2).

% get_section_distance: selecciona la distancia de la sección
% Dominio:
% Section (TDA section)
% Recorrido:
% Distance (number)
% Meta primaria: get_section_distance/1

get_section_distance([_, _, Distance, _], Distance).

% get_section_cost: selecciona el costo de la sección
% Dominio:
% Section (TDA section)
% Recorrido:
% Cost (number)
% Meta primaria: get_section_cost/1

get_section_cost([_, _, _, Cost], Cost).

% get_stations: obtiene todas las estaciones de una lista de secciones
% Dominio:
% Sections (list of TDA sections) X Stations (list of stations)
% Meta primaria: get_stations/2

get_stations([], []).
get_stations([Section|Sections], Stations) :-
    get_section_point1(Section, Point1),
    get_section_point2(Section, Point2),
    get_stations(Sections, RestStations),
    append([Point1, Point2], RestStations, Stations).
  