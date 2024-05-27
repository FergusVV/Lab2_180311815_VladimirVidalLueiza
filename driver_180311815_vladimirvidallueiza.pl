:- module(driver_180311815_vladimirvidallueiza, 
    [driver/4, is_driver/1, get_driver_id/2, get_driver_nombre/2, get_driver_train_maker/2]).
    
% TDA driver
% Representación: Lista
% Id (int)
% Nombre (string)
% TrainMaker (string)
% Driver (list of driver)

% Predicado constructor de driver
% driver(Id, Nombre, TrainMaker, Driver)
% Dominio:
% Id (int) X Nombre (string) X TrainMaker (string) X Driver (TDA driver)
% Meta primaria: driver/4

driver(Id, Nombre, TrainMaker, Driver) :-
    Driver = [Id, Nombre, TrainMaker].

% Predicado de pertenencia para verificar si es un conductor válido
% is_driver(Driver)
% Dominio:
% Driver (TDA driver)
% Meta primaria: is_driver/1
% Metas secundarias:
% integer/1, string/1

is_driver([Id, Nombre, TrainMaker]) :-
    integer(Id),
    string(Nombre),
    string(TrainMaker).

% Selectores

% get_driver_id: selecciona el Id del conductor
% Dominio:
% Driver (TDA driver)
% Recorrido:
% Id (int)
% Meta primaria: get_driver_id/1

get_driver_id([Id, _, _], Id).

% get_driver_nombre: selecciona el nombre del conductor
% Dominio:
% Driver (TDA driver)
% Recorrido:
% Nombre (string)
% Meta primaria: get_driver_nombre/1

get_driver_nombre([_, Nombre, _], Nombre).

% get_driver_train_maker: selecciona el fabricante del tren asociado al conductor
% Dominio:
% Driver (TDA driver)
% Recorrido:
% TrainMaker (string)
% Meta primaria: get_driver_train_maker/1

get_driver_train_maker([_, _, TrainMaker], TrainMaker).
