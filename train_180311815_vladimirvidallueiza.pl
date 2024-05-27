
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
train(Id, Maker, RailType, Speed, PCars, Train) :-
    Train = [Id, Maker, RailType, Speed, PCars].


% Predicado de pertenencia para verificar si es un tren válido
% isTrain(Train)
% Dominio:
% Train (TDA train)
% Meta primaria: isTrain/1
% Metas secundarias:
% integer/1, string/1, is_list/1, maplist/2, is_pcar/1, valid_train/1

isTrain([Id, Maker, RailType, Speed, PCars]) :-
    integer(Id),
    string(Maker),
    string(RailType),
    integer(Speed),
    Speed > 0,
    is_list(PCars),
    maplist(is_pcar, PCars),
    valid_train(PCars).


% valid_train(PCars)
% Dominio:
% PCars (list of pcar)
% Meta primaria: valid_train/1

valid_train([Car|PCars]) :-
    get_pcar_cartype(Car, "tr"), % El primer carro debe ser terminal
    valid_internal(PCars).

% Verificar la configuración interna del tren
% valid_internal(PCars)
% Dominio:
% PCars (list of pcar)
% Meta primaria: valid_internal/1

valid_internal([Car|[]]) :-
    get_pcar_cartype(Car, "tr"). % El último carro debe ser terminal
valid_internal([Car|PCars]) :-
    get_pcar_cartype(Car, "ct"), % Los carros intermedios deben ser centrales
    valid_internal(PCars).

% Selectores

% get_train_id: selecciona el Id del tren
% Dominio:
% Train (TDA train)
% Recorrido:
% Id (int)
% Meta primaria: get_train_id/1

get_train_id([Id, _, _, _, _], Id).

% get_train_maker: selecciona el fabricante del tren
% Dominio:
% Train (TDA train)
% Recorrido:
% Maker (string)
% Meta primaria: get_train_maker/1

get_train_maker([_, Maker, _, _, _], Maker).

% get_train_railtype: selecciona el tipo de riel del tren
% Dominio:
% Train (TDA train)
% Recorrido:
% RailType (string)
% Meta primaria: get_train_railtype/1

get_train_railtype([_, _, RailType, _, _], RailType).

% get_train_speed: selecciona la velocidad del tren
% Dominio:
% Train (TDA train)
% Recorrido:
% Speed (positive number)
% Meta primaria: get_train_speed/1

get_train_speed([_, _, _, Speed, _], Speed).

% get_train_pcars: selecciona los carros del tren
% Dominio:
% Train (TDA train)
% Recorrido:
% PCars (list of pcar)
% Meta primaria: get_train_pcars/1

get_train_pcars([_, _, _, _, PCars], PCars).


% Predicado para añadir un carro a un tren en una posición dada
% trainAddCar(Train, Pcar, Position, NewTrain)
% Dominio:
% Train (TDA train) X Pcar (pcar) X Position (int) X NewTrain (TDA train)
% Meta primaria: trainAddCar/4

trainAddCar([Id, Maker, RailType, Speed, PCars], Pcar, Position, [Id, Maker, RailType, Speed, NewPCars]) :-
    insert(PCars, Pcar, Position, TempPCars),
   %valid_train(TempPCars),
    NewPCars = TempPCars.

% Predicado auxiliar para insertar un elemento en una lista en una posición dada
% insert(List, Elem, Pos, NewList)
% Dominio:
% List (list) X Elem (any) X Pos (int) X NewList (list)
% Meta primaria: insert/4

insert(List, Elem, 0, [Elem|List]).
insert([H|T], Elem, Pos, [H|R]) :-
    Pos > 0,
    Pos1 is Pos - 1,
    insert(T, Elem, Pos1, R).

% Predicado para remover un carro de un tren en una posición dada
% trainRemoveCar(Train, Position, NewTrain)
% Dominio:
% Train (TDA train) X Position (int) X NewTrain (TDA train)
% Meta primaria: trainRemoveCar/3

trainRemoveCar([Id, Maker, RailType, Speed, PCars], Position, [Id, Maker, RailType, Speed, NewPCars]) :-
    removep(PCars, Position, TPCars),
    NewPCars = TPCars.

% Predicado auxiliar para remover un elemento en una posición específica
% removep(List, Pos, NewList)
% Dominio:
% List (list) X Pos (int) X NewList (list)
% Meta primaria: removep/3

removep([_|T], 0, T).
removep([H|T], Pos, [H|R]) :-
    Pos > 0,
    Pos1 is Pos - 1,
    removep(T, Pos1, R).    

% Predicado para calcular la capacidad total del tren
% trainCapacity(Train, Capacity)
% Dominio:
% Train (TDA train) X Capacity (int)
% Meta primaria: trainCapacity/2

trainCapacity([_, _, _, _, PCars], C) :-
    calculate_capacity(PCars, C).

% Predicado auxiliar para calcular la capacidad total
% calculate_capacity(PCars, TotalCapacity)
% Dominio:
% PCars (list of pcar) X TotalCapacity (int)
% Meta primaria: calculate_capacity/2

calculate_capacity([], 0).
calculate_capacity([Car|Resto], Total) :-
    get_pcar_capacity(Car, CarCapacity),
    calculate_capacity(Resto, Resto2),
    Total is CarCapacity + Resto2.    