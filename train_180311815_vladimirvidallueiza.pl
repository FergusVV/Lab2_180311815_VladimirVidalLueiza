
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
is_train([Id, Maker, RailType, Speed, PCars]) :-
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