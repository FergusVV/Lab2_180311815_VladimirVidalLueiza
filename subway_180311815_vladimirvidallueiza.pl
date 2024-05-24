% TDA subway
% Representación: Lista
% Id (int)
% Name (string)
% Trains (list of train)
% Subway (list of subway)

% Predicado constructor subway
% subway(Id, Name, Trains, [Id, Name, Trains])
% Dominio:
% id (int) X Name (string) X trains (list of train) X subway
% Meta primaria: subway/4
% Metas secundarias:
subway(Id, Name, Subway) :-
    Subway = [Id, Name, [], [], []].


% Predicado de pertenencia para verificar si es una red de metro válida
is_subway([Id, Name, Trains]) :-
    integer(Id),
    string(Name),
    is_list(Trains),
    maplist(is_train, Trains).

% Selectores
get_subway_id([Id, _, _, _, _], Id).
get_subway_Name([_, Name, _, _, _], Name).
get_subway_trains([_, _, Trains, _, _], Trains).
get_subway_lines([_, _, _, Lines, _], Lines).
get_subway_drivers([_, _, _, _, Drivers], Drivers).

% Modificador para añadir trenes a una red de metro
subwayAddTrain(Subway, NewTrains, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_trains(Subway, Trains),
    get_subway_lines(Subway, Lines),
    get_subway_drivers(Subway, Drivers),
    append(Trains, NewTrains, UpdatedTrains),
    SubwayOut = [Id, Name, UpdatedTrains, Lines, Drivers].

% Modificador para añadir líneas a una red de metro
subwayAddLine(Subway, NewLines, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_trains(Subway, Trains),
    get_subway_lines(Subway, Lines),
    get_subway_drivers(Subway, Drivers),
    append(Lines, NewLines, UpdatedLines),
    SubwayOut = [Id, Name, Trains, UpdatedLines, Drivers].

% Modificador para añadir conductores a una red de metro
subwayAddDriver(Subway, NewDrivers, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_trains(Subway, Trains),
    get_subway_lines(Subway, Lines),
    get_subway_drivers(Subway, Drivers),
    append(Drivers, NewDrivers, UpdatedDrivers),
    SubwayOut = [Id, Name, Trains, Lines, UpdatedDrivers].


% Función que permite expresar una red de metro en un formato String
% subwayToString(Subway, Subout)
% Subway es la red de metro
% Subout es el string resultante que describe la red de metro
subwayToString(Subway, Subout) :-
    Subway = [Id, Name, Trains, Lines, Drivers],
    format(string(TrainsToStr), "~w", [Trains]),
    format(string(LinesToStr), "~w", [Lines]),
    format(string(DriversToStr), "~w", [Drivers]),
    format(string(Subout), "Subway ID: ~w~nName: ~w~nTrains: ~w~nLines: ~w~nDrivers: ~w", [Id, Name, TrainsToStr, LinesToStr, DriversToStr]).  


subwaySetStationStoptime(Subway, StationName, NewTime, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_lines(Subway, Lines),
    get_subway_trains(Subway, Trains),
    maplist(update_line_stoptime(StationName, NewTime), Lines, UpdatedLines),
    SubwayOut = [Id, Name, UpdatedLines, Trains].

% Predicado para actualizar el tiempo de parada de una estación en una línea
update_line_stoptime(StationName, NewTime, Line, UpdatedLine) :-
    get_line_id(Line, LineId),
    get_line_name(Line, LineName),
    get_line_railtype(Line, LineRailType),
    get_line_sections(Line, Sections),
    maplist(update_section_stoptime(StationName, NewTime), Sections, UpdatedSections),
    UpdatedLine = [LineId, LineName, LineRailType, UpdatedSections].

% Predicado para actualizar el tiempo de parada de una estación en una sección
update_section_stoptime(StationName, NewTime, Section, UpdatedSection) :-
    get_section_point1(Section, Point1),
    get_section_point2(Section, Point2),
    update_station_stoptime(Point1, StationName, NewTime, UpdatedPoint1),
    update_station_stoptime(Point2, StationName, NewTime, UpdatedPoint2),
    get_section_distance(Section, Distance),
    get_section_cost(Section, Cost),
    UpdatedSection = [UpdatedPoint1, UpdatedPoint2, Distance, Cost].

% Predicado para actualizar el tiempo de parada de una estación
update_station_stoptime(Station, StationName, NewTime, UpdatedStation) :-
    get_station_name(Station, Name),
    ( Name = StationName ->
        get_station_id(Station, Id),
        get_station_type(Station, Type),
        UpdatedStation = [Id, Name, Type, NewTime]
    ;   UpdatedStation = Station
    ).