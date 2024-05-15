line(ID, Name, RailType, Sections, Line) :- integer(ID), string(Name), string(RailType), Line = line(ID, Name, RailType, Sections).


lineLength(line(_, _, _, Sections), Length, TotalDistance, TotalCost) :-
    extract_stations(Sections, Stations),
    sort(Stations, UniqueStations),
    length(UniqueStations, Length),
    sum_section(Sections, TotalDistance, TotalCost).

extract_stations([], []).
extract_stations([[Start, End, _, _]|T], [Start, End|R]) :-
    extract_stations(T, R).

sum_section([], 0, 0).
sum_section([[_, _, Distance, Cost]|T], TotalDistance, TotalCost) :-
    sum_section(T, SubTotalDistance, SubTotalCost),
    TotalDistance is SubTotalDistance + Distance,
    TotalCost is SubTotalCost + Cost.
