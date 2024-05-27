:- module(pcar_180311815_vladimirvidallueiza, 
    [pcar/5, is_pcar/1, get_pcar_id/2, get_pcar_capacity/2, get_pcar_model/2, get_pcar_cartype/2]).

%TDA pcar
%Representación: Lista
%Id (int)
%Capacity (positive integer)
%Modele(string)
%Car-type (type)
%pcar (list of pcar)

%Reglas

%Predicado constructor pcar
% pcar(Id, Capacity, Model, Cartype,[Id, Capacity, Model, Cartype])
% Dominio:
%Pcar id (int) X capacity (positive integer) Xmodel (string) X type(car-type)XPCar
%Meta primaria: pcar/5
%Metas secundarias:
pcar(Id, Capacity, Model, Cartype, Pcar) :-
    Pcar = [Id, Capacity, Model, Cartype].

% Predicados de pertenencia para PCar
% is_pcar(Pcar)
% Dominio:
% Pcar (TDA pcar)
% Meta primaria: is_pcar/1
% Metas secundarias:
% integer/1, string/1, member/2

is_pcar([Id, Capacity, Model, Cartype]) :-
    integer(Id),
    integer(Capacity),
    Capacity > 0,
    string(Model),
    member(Cartype, ["tr", "ct"]). 

% Selectores

% get_pcar_id: selecciona el Id del pcar
% Dominio:
% Pcar (TDA pcar)
% Recorrido:
% Id (int)
% Meta primaria: get_pcar_id/1

get_pcar_id([Id, _, _, _], Id).

% get_pcar_capacity: selecciona la capacidad del pcar
% Dominio:
% Pcar (TDA pcar)
% Recorrido:
% Capacity (positive integer)
% Meta primaria: get_pcar_capacity/1

get_pcar_capacity([_, Capacity, _, _], Capacity).

% get_pcar_model: selecciona el modelo del pcar
% Dominio:
% Pcar (TDA pcar)
% Recorrido:
% Model (string)
% Meta primaria: get_pcar_model/1

get_pcar_model([_, _, Model, _], Model).

% get_pcar_cartype: selecciona el tipo de coche del pcar
% Dominio:
% Pcar (TDA pcar)
% Recorrido:
% Cartype (car-type)
get_pcar_cartype([_, _, _, Cartype], Cartype).