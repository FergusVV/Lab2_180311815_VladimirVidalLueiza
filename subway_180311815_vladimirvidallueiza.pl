% TDA subway
% Representación: Lista
% Id (int)
% Name (string)
% Trains (list of train)
% Subway (list of subway)

% Predicado constructor de subway
% subway(Id, Name, Subway)
% Dominio:
% Id (int) X Name (string) X Subway (TDA subway)
% Meta primaria: subway/3

subway(Id, Name, Subway) :-
    Subway = [Id, Name, [], [], []].


% Predicado de pertenencia para verificar si es una red de metro válida
% is_subway(Subway)
% Dominio:
% Subway (TDA subway)
% Meta primaria: is_subway/1
% Metas secundarias:
% integer/1, string/1, is_list/1, maplist/2, is_train/1

is_subway([Id, Name, Trains]) :-
    integer(Id),
    string(Name),
    is_list(Trains),
    maplist(is_train, Trains).

% Selectores

% get_subway_id: selecciona el Id del metro
% Dominio:
% Subway (TDA subway)
% Recorrido:
% Id (int)
% Meta primaria: get_subway_id/1

get_subway_id([Id, _, _, _, _], Id).

% get_subway_Name: selecciona el nombre del metro
% Dominio:
% Subway (TDA subway)
% Recorrido:
% Name (string)
% Meta primaria: get_subway_Name/1

get_subway_Name([_, Name, _, _, _], Name).

% get_subway_trains: selecciona los trenes del metro
% Dominio:
% Subway (TDA subway)
% Recorrido:
% Trains (list of train)
% Meta primaria: get_subway_trains/1

get_subway_trains([_, _, Trains, _, _], Trains).

% get_subway_lines: selecciona las líneas del metro
% Dominio:
% Subway (TDA subway)
% Recorrido:
% Lines (list of lines)
% Meta primaria: get_subway_lines/1

get_subway_lines([_, _, _, Lines, _], Lines).

% get_subway_drivers: selecciona los conductores del metro
% Dominio:
% Subway (TDA subway)
% Recorrido:
% Drivers (list of drivers)
% Meta primaria: get_subway_drivers/1

get_subway_drivers([_, _, _, _, Drivers], Drivers).

% Modificador para añadir trenes a una red de metro
% subwayAddTrain(Subway, NewTrains, SubwayOut)
% Dominio:
% Subway (TDA subway) X NewTrains (list of trains) X SubwayOut (TDA subway)
% Recorrido:
% SubwayOut (TDA subway)
% Meta primaria: subwayAddTrain/3

subwayAddTrain(Subway, NewTrains, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_trains(Subway, Trains),
    get_subway_lines(Subway, Lines),
    get_subway_drivers(Subway, Drivers),
    append(Trains, NewTrains, UpdatedTrains),
    SubwayOut = [Id, Name, UpdatedTrains, Lines, Drivers].

% Modificador para añadir líneas a una red de metro
% subwayAddLine(Subway, NewLines, SubwayOut)
% Dominio:
% Subway (TDA subway) X NewLines (list of lines) X SubwayOut (TDA subway)
% Recorrido:
% SubwayOut (TDA subway)
% Meta primaria: subwayAddLine/3

subwayAddLine(Subway, NewLines, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_trains(Subway, Trains),
    get_subway_lines(Subway, Lines),
    get_subway_drivers(Subway, Drivers),
    append(Lines, NewLines, UpdatedLines),
    SubwayOut = [Id, Name, Trains, UpdatedLines, Drivers].


% Modificador para añadir conductores a una red de metro
% subwayAddDriver(Subway, NewDrivers, SubwayOut)
% Dominio:
% Subway (TDA subway) X NewDrivers (list of drivers) X SubwayOut (TDA subway)
% Recorrido:
% SubwayOut (TDA subway)
% Meta primaria: subwayAddDriver/3

subwayAddDriver(Subway, NewDrivers, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_trains(Subway, Trains),
    get_subway_lines(Subway, Lines),
    get_subway_drivers(Subway, Drivers),
    append(Drivers, NewDrivers, UpdatedDrivers),
    SubwayOut = [Id, Name, Trains, Lines, UpdatedDrivers].


% Predicado que permite expresar una red de metro en un formato String
% Subway es la red de metro
% Subout es el string resultante que describe la red de metro
% subwayToString(Subway, Subout)
% Dominio:
% Subway (TDA subway) X Subout (string)
% Recorrido:
% Subout (string)
% Meta primaria: subwayToString/2

subwayToString(Subway, Subout) :-
    Subway = [Id, Name, Trains, Lines, Drivers],
    format(string(TrainsToStr), "~w~n", [Trains]),
    format(string(LinesToStr), "~w~n", [Lines]),
    format(string(DriversToStr), "~w~n", [Drivers]),
    format(string(Subout), "Subway ID: ~w~nName: ~w~nTrains: ~w~nLines: ~w~nDrivers: ~w", [Id, Name, TrainsToStr, LinesToStr, DriversToStr]).  


% Predicado que permite modificar el tiempo de parada de una estación
% subwaySetStationStoptime(Subway, StationName, NewTime, SubwayOut)
% Dominio:
% Subway (TDA subway) X StationName (string) X NewTime (positive integer) X SubwayOut (TDA subway)
% Recorrido:
% SubwayOut (TDA subway)
% Meta primaria: subwaySetStationStoptime/4

subwaySetStationStoptime(Subway, StationName, NewTime, SubwayOut) :-
    get_subway_id(Subway, Id),
    get_subway_Name(Subway, Name),
    get_subway_lines(Subway, Lines),
    get_subway_trains(Subway, Trains),
    maplist(update_line_stoptime(StationName, NewTime), Lines, UpdatedLines),
    SubwayOut = [Id, Name, UpdatedLines, Trains].

% Predicado auxiliar para actualizar el tiempo de parada de una estación en una línea
% update_line_stoptime(StationName, NewTime, Line, UpdatedLine)
% Dominio:
% StationName (string) X NewTime (positive integer) X Line (TDA line) X UpdatedLine (TDA line)
% Recorrido:
% UpdatedLine (TDA line)
% Meta primaria: update_line_stoptime/4

update_line_stoptime(StationName, NewTime, Line, UpdatedLine) :-
    get_line_id(Line, LineId),
    get_line_name(Line, LineName),
    get_line_railtype(Line, LineRailType),
    get_line_sections(Line, Sections),
    maplist(update_section_stoptime(StationName, NewTime), Sections, UpdatedSections),
    UpdatedLine = [LineId, LineName, LineRailType, UpdatedSections].


% Predicado para actualizar el tiempo de parada de una estación en una sección
% update_section_stoptime(StationName, NewTime, Section, UpdatedSection)
% Dominio:
% StationName (string) X NewTime (positive integer) X Section (TDA section) X UpdatedSection (TDA section)
% Recorrido:
% UpdatedSection (TDA section)
% Meta primaria: update_section_stoptime/4

update_section_stoptime(StationName, NewTime, Section, UpdatedSection) :-
    get_section_point1(Section, Point1),
    get_section_point2(Section, Point2),
    update_station_stoptime(Point1, StationName, NewTime, UpdatedPoint1),
    update_station_stoptime(Point2, StationName, NewTime, UpdatedPoint2),
    get_section_distance(Section, Distance),
    get_section_cost(Section, Cost),
    UpdatedSection = [UpdatedPoint1, UpdatedPoint2, Distance, Cost].

% Predicado para actualizar el tiempo de parada de una estación
% update_station_stoptime(Station, StationName, NewTime, UpdatedStation)
% Dominio:
% Station (TDA station) X StationName (string) X NewTime (positive integer) X UpdatedStation (TDA station)
% Recorrido:
% UpdatedStation (TDA station)
% Meta primaria: update_station_stoptime/4

update_station_stoptime(Station, StationName, NewTime, UpdatedStation) :-
    get_station_name(Station, Name),
    ( Name = StationName ->
        get_station_id(Station, Id),
        get_station_type(Station, Type),
        UpdatedStation = [Id, Name, Type, NewTime]
    ;   UpdatedStation = Station
    ).

