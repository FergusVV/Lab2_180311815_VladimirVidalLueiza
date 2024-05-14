section(Station1, Station2, Distance, Cost, [Station1, Station2, Distance, Cost]) :-
    integer(Distance), Distance > 0,
    integer(Cost), Cost >= 0.
