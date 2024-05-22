
% TDA train
% Representación: Lista
% Id (int)
% Maker (string)
% Rail-type (string)
% Speed (positive number)
% PCars (list of PCar)
% Train (list of train)

% Predicado constructor train
% train(Id, Maker, RailType, Speed, PCars, [Id, Maker, RailType, Speed, PCars])
% Dominio:
% id (int) X maker (string) X rail-type (string) X speed (positive number) X pcars (list of pcar) X train
% Meta primaria: train/6
% Metas secundarias:
train(Id, Maker, RailType, Speed, PCars, Train) :-
    Train = [Id, Maker, RailType, Speed, PCars].


% Predicado de pertenencia para verificar si es un tren válido
isTrain([Id, Maker, RailType, Speed, PCars]) :-
    integer(Id),
    string(Maker),
    string(RailType),
    integer(Speed),
    Speed > 0,
    is_list(PCars),
    maplist(is_pcar, PCars),
    valid_train(PCars).

valid_train([Car|PCars]) :-
    get_pcar_cartype(Car, "tr"), % El primer carro debe ser terminal
    valid_internal(PCars).

% Verificar la configuración interna del tren
valid_internal([Car|[]]) :-
    get_pcar_cartype(Car, "tr"). % El último carro debe ser terminal
valid_internal([Car|PCars]) :-
    get_pcar_cartype(Car, "ct"), % Los carros intermedios deben ser centrales
    valid_internal(PCars).

% Selectores
get_train_id([Id, _, _, _, _], Id).
get_train_maker([_, Maker, _, _, _], Maker).
get_train_railtype([_, _, RailType, _, _], RailType).
get_train_speed([_, _, _, Speed, _], Speed).
get_train_pcars([_, _, _, _, PCars], PCars).


% Predicado para añadir un carro a un tren en una posición dada
trainAddCar([Id, Maker, RailType, Speed, PCars], Pcar, Position, [Id, Maker, RailType, Speed, NewPCars]) :-
    insert(PCars, Pcar, Position, TempPCars),
   %valid_train(TempPCars),
    NewPCars = TempPCars.

% Predicado auxiliar
insert(List, Elem, 0, [Elem|List]).
insert([H|T], Elem, Pos, [H|R]) :-
    Pos > 0,
    Pos1 is Pos - 1,
    insert(T, Elem, Pos1, R).


trainRemoveCar([Id, Maker, RailType, Speed, PCars], Position, [Id, Maker, RailType, Speed, NewPCars]) :-
    removep(PCars, Position, TPCars),
    NewPCars = TPCars.

% Elimina un elemento en una posición específica
removep([_|T], 0, T).
removep([H|T], Pos, [H|R]) :-
    Pos > 0,
    Pos1 is Pos - 1,
    removep(T, Pos1, R).    

trainCapacity([_, _, _, _, PCars], C) :-
    calculate_capacity(PCars, C).

calculate_capacity([], 0).
calculate_capacity([Car|Resto], Total) :-
    get_pcar_capacity(Car, CarCapacity),
    calculate_capacity(Resto, Resto2),
    Total is CarCapacity + Resto2.    