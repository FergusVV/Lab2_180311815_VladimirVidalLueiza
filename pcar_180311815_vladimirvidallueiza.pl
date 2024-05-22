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
is_pcar([Id, Capacity, Model, Cartype]) :-
    integer(Id),
    integer(Capacity),
    Capacity > 0,
    string(Model),
    member(Cartype, ["tr", "ct"]). 

% Selectores
get_pcar_id([Id, _, _, _], Id).
get_pcar_capacity([_, Capacity, _, _], Capacity).
get_pcar_model([_, _, Model, _], Model).
get_pcar_cartype([_, _, _, Cartype], Cartype).