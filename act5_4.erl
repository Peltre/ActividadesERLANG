% Actividad 5.4 Listas y Estructuras de Datos en Erlang
% Autor: Pedro Jesús Sotelo Arce y Hans Gerhard Moreno
% Ultima fecha de modificación 15/05/2024

-module(act5_4).
-export([filtra/2, mapea/2, compon/2, hay_pares/1, impares/1, empareja/1]).

% 1. Función filtra
filtra(Predicado, Lista) ->
    filtra_aux(Predicado, Lista, []).

filtra_aux(_Predicado, [], Acum) ->
    lists:reverse(Acum);
filtra_aux(Predicado, [Cabeza|Cola], Acum) ->
    case Predicado(Cabeza) of
        true ->
            filtra_aux(Predicado, Cola, [Cabeza|Acum]);
        false ->
            filtra_aux(Predicado, Cola, Acum)
    end.

% 2. Función mapea
mapea(Funcion, Lista) ->
    mapea_aux(Funcion, Lista, []).

mapea_aux(_Funcion, [], Acum) ->
    lists:reverse(Acum);
mapea_aux(Funcion, [Cabeza|Cola], Acum) ->
    Resultado = Funcion(Cabeza),
    mapea_aux(Funcion, Cola, [Resultado|Acum]).

% 3. Función compon
compon(F, G) ->
    fun(X) -> F(G(X)) end.

% 4. Función hay_pares
hay_pares(Listas) ->
    lists:any(fun(SubLista) -> lists:any(fun(X) -> X rem 2 == 0 end, SubLista) end, Listas).

% 5. Función impares
impares(Listas) ->
    lists:map(fun(SubLista) -> lists:filter(fun(X) -> X rem 2 =/= 0 end, SubLista) end, Listas).

% 6. Función empareja
empareja(Lista) ->
    lists:flatmap(fun(X) -> lists:map(fun(Y) -> {X, Y} end, Lista) end, Lista).