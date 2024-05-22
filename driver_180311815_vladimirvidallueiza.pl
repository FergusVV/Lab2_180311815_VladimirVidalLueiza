% TDA driver
% Representación: Lista
% Id (int)
% Nombre (string)
% TrainMaker (string)
% Driver (list of driver)

% Predicado constructor driver
% driver(Id, Nombre, TrainMaker, [Id, Nombre, TrainMaker])
% Dominio:
% id (int) X nombre (string) X train-maker (string) X driver
% Meta primaria: driver/4
% Metas secundarias:
driver(Id, Nombre, TrainMaker, Driver) :-
    Driver = [Id, Nombre, TrainMaker].

% Pertenencia
is_driver([Id, Nombre, TrainMaker]) :-
    integer(Id),
    string(Nombre),
    string(TrainMaker).

% Selectores
get_driver_id([Id, _, _], Id).
get_driver_nombre([_, Nombre, _], Nombre).
get_driver_train_maker([_, _, TrainMaker], TrainMaker).
