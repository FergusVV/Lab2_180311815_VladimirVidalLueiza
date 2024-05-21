% Constructor
section(Point1, Point2, Distance, Cost, Section) :- 
    Section = [Point1, Point2, Distance, Cost].

% Predicados de pertenencia
is_section([Point1, Point2, Distance, Cost]) :-
    is_station(Point1),
    is_station(Point2),
    number(Distance),
    Distance > 0,
    number(Cost),
    Cost >= 0.

% Selectores
get_section_point1([Point1, _, _, _], Point1).
get_section_point2([_, Point2, _, _], Point2).
get_section_distance([_, _, Distance, _], Distance).
get_section_cost([_, _, _, Cost], Cost).

get_stations([], []).
get_stations([Section|Sections], Stations) :-
    get_section_point1(Section, Point1),
    get_section_point2(Section, Point2),
    get_stations(Sections, RestStations),
    append([Point1, Point2], RestStations, Stations).