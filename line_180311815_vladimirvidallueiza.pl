
% Constructor
line(Id, Name, RailType, Sections, Line) :- 
    Line = [Id, Name, RailType, Sections].

% Predicados de pertenencia
isLine([Id, Name, RailType, Sections]) :-
    integer(Id),
    string(Name),
    string(RailType),
    is_list(Sections),
    maplist(is_section, Sections).

% Selectores
get_line_id([Id, _, _, _], Id).
get_line_name([_, Name, _, _], Name).
get_line_railtype([_, _, RailType, _], RailType).
get_line_sections([_, _, _, Sections], Sections).

% Verifica si una estación es única en una lista de tramos
unique_station(_, []).
unique_station(Station, [Section|Sections]) :-
    get_section_point1(Section, P1),
    get_section_point2(Section, P2),
    Station \= P1,
    Station \= P2,
    unique_station(Station, Sections).

%Predicado lineLength
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


lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost) :-
    get_line_sections(Line, Sections),
    find_station_name(Station1Name, Station1),
    find_station_name(Station2Name, Station2),
    find_path(Station1, Station2, Sections, [], Path),
    calculate_distance(Path, Distance),
    calculate_cost(Path, Cost).

% Encuentra una estacion por nombre en la base de datos
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

lineAddSection(Line, Section, LineOut) :-
    get_line_sections(Line, Sections), % Obtiene las secciones de la línea
    (   member(Section, Sections)
    % Si la sección ya está en las secciones de la línea
    ->  get_line_id(Line, Id), % Obtiene el ID de la línea
        get_line_name(Line, Name), % Obtiene el nombre de la línea
        get_line_railtype(Line, RailType),
        LineOut = line(Id, Name, RailType, Sections)  % la línea de salida es la misma línea sin cambios
    ;   add_section(Line, Sections, Section, LineOut)
    ).

% add_section(Line, Sections, Section, LineOut)
add_section(Line, Sections, Section, LineOut) :-
    get_line_id(Line, Id), % Obtiene el ID de la línea
    get_line_name(Line, Name), % Obtiene el nombre de la línea
    get_line_railtype(Line, RailType), % Obtiene el tipo de riel de la línea
    append(Sections, [Section], NSections), % Añade la nueva sección a las secciones existentes
    LineOut = line(Id, Name, RailType, NSections). % Crea la nueva línea con las secciones actualizadas    
