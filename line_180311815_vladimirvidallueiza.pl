:- module(line_180311815_vladimirvidallueiza, 
    [line/5, isLine/1, get_line_id/2, get_line_name/2, get_line_railtype/2, get_line_sections/2, 
     unique_station/2, lineLength/4, lineSectionLength/6, find_station_name/2, find_path/5, lineAddSection/3]).

% TDA Line
% Representación: Lista
% Constructor
% line(Id, Name, RailType, Sections, Line)
% Dominio:
% Id (int) X Name (string) X RailType (string) X Sections (list of sections) X Line (TDA line)
% Meta primaria: line/5

line(Id, Name, RailType, Sections, Line) :- 
    Line = [Id, Name, RailType, Sections].

% Predicados de pertenencia
% isLine(Line)
% Dominio:
% Line (TDA line)
% Meta primaria: isLine/1
% Metas secundarias:
% integer/1, string/1, is_list/1, maplist/2, is_section/1

isLine(Line) :-
    get_line_id(Line, Id),
    get_line_name(Line, Name),
    get_line_railtype(Line, RailType),
    get_line_sections(Line, Sections),
    integer(Id),
    string(Name),
    string(RailType),
    is_list(Sections),
    Sections \= [],
    maplist(is_section, Sections),
    first_and_last_sections(Sections, FirstSection, LastSection),
    (is_terminal_section(FirstSection); is_terminal_section(LastSection)).

% Predicado para verificar si una sección tiene una estación de tipo "t"
is_terminal_section(Section) :-
    get_section_point1(Section, Station),
    get_station_type(Station, "t").
is_terminal_section(Section) :-
    get_section_point2(Section, Station),
    get_station_type(Station, "t").

% Obtener la primera y última sección de la lista
first_and_last_sections([First|Rest], First, Last) :-
    last_section(Rest, Last).

% Obtener la última sección de la lista
last_section([Last], Last).
last_section([_|Rest], Last) :-
    last_section(Rest, Last).

% Selectores

% get_line_id: selecciona el Id de la línea
% Dominio:
% Line (TDA line)
% Recorrido:
% Id (int)

get_line_id([Id, _, _, _], Id).

% get_line_name: selecciona el nombre de la línea
% Dominio:
% Line (TDA line)
% Recorrido:
% Name (string)

get_line_name([_, Name, _, _], Name).

% get_line_railtype: selecciona el tipo de riel de la línea
% Dominio:
% Line (TDA line)
% Recorrido:
% RailType (string)

get_line_railtype([_, _, RailType, _], RailType).

% get_line_sections: selecciona las secciones de la línea
% Dominio:
% Line (TDA line)
% Recorrido:
% Sections (list of sections)
get_line_sections([_, _, _, Sections], Sections).

% Verifica si una estación es única en una lista de tramos
% unique_station(Station, Sections)
% Dominio:
% Station (station) X Sections (list of sections)
% Meta primaria: unique_station/2
% Metas secundarias:
% get_section_point1/2, get_section_point2/2, (\=)/2

unique_station(_, []).
unique_station(Station, [Section|Sections]) :-
    get_section_point1(Section, P1),
    get_section_point2(Section, P2),
    Station \= P1,
    Station \= P2,
    unique_station(Station, Sections).

% Predicado lineLength : Predicado que permite determinar el largo
% total de una línea (cantidad de estaciones), la distancia (en la unidad de medida
% expresada en cada tramo) y su costo.
% lineLength(Line, Length, Distance, Cost)
% Dominio:
% Line (TDA line) X Length (int) X Distance (number) X Cost (number)
% Meta primaria: lineLength/4
% Metas secundarias:
% get_line_sections/2, get_line_id/2, get_line_name/2, get_line_railtype/2, get_line_cost

lineLength(Line, Length, Distance, Cost) :-
    get_line_sections(Line, Sections),
    get_stations(Sections, Stations),
    sort(Stations, StationsUni), %Predicado que recibe una lista de estación y Verifica si hay estaciones repetidas, luego retorna la lista en StationUni
    length(StationsUni, Length),
    calculate_distance(Sections, Distance),
    calculate_cost(Sections, Cost).

calculate_distance([], 0).
calculate_distance([Section|Sections], Distance) :-
    get_section_distance(Section, D),
    calculate_distance(Sections, RestDistance),
    Distance is D + RestDistance.

calculate_cost([], 0).
calculate_cost([Section|Sections], Cost) :-
    get_section_cost(Section, C),
    calculate_cost(Sections, RestCost),
    Cost is C + RestCost. 


% lineSectionLength Predicado que permite determinar el trayecto
% entre una estación origen y una final, la distancia de ese trayecto y el costo. 
% lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost)
% Dominio:
% Line (TDA line) X Station1Name (string) X Station2Name (string) X Path (list of sections) X Distance (number) X Cost (number)
% Meta primaria: lineSectionLength/6

lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost) :-
    get_line_sections(Line, Sections),
    find_station_name(Station1Name, Station1),
    find_station_name(Station2Name, Station2),
    find_path(Station1, Station2, Sections, [], Path),
    calculate_distance(Path, Distance),
    calculate_cost(Path, Cost).

% Encuentra el path entre dos estaciones
% find_path(Current, Destination, Sections, Visited, Path)
% Dominio:
% Current (station) X Destination (station) X Sections (list of sections) X Visited (list of sections) X Path (list of sections)
% Meta primaria: find_path/5
% find_station_name(Name, Station)
% Dominio:
% Name (string) X Station (station)
% Meta primaria: find_station_name/2
find_station_name(Name, Station) :-
    station(_, Name, _, _, Station).

% Encuentra el path entre dos estaciones
find_path(Destination, Destination, _, Path, Path).
find_path(Current, Destination, Sections, Visited, Path) :-
    member(Section, Sections),(
    get_section_point1(Section, Current), get_section_point2(Section, Next);
    get_section_point2(Section, Current), get_section_point1(Section, Next)),
    \+ member(Section, Visited),
    find_path(Next, Destination, Sections, [Section|Visited], Path).


% lineAddSection Predicado que permite añadir tramos a una línea
% lineAddSection(Line, Section, LineOut)
% Dominio:
% Line (TDA line) X Section (section) X LineOut (TDA line)
% Meta primaria: lineAddSection/3

lineAddSection(Line, Section, LineOut) :-
    get_line_sections(Line, Sections),
    \+ member(Section, Sections), % Verifica que la sección no este en la línea
    append(Sections, [Section], UpdatedSections),
    get_line_id(Line, Id),
    get_line_name(Line, Name),
    get_line_railtype(Line, RailType),
    LineOut = [Id, Name, RailType, UpdatedSections].
lineAddSection(Line, Section, Line) :- % Si la sección ya está en la línea, no hace cambios
    get_line_sections(Line, Sections),
    member(Section, Sections).