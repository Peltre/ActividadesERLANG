% Actividad 6.1 Programación Concurrente en Erlang
% Autor: Pedro Jesús Sotelo Arce 
% Ultima fecha de modificación 27/04/2024

-module(act6_1).
-export([suma/0, prueba_suma/0, registro/0, prueba_registro/0]).

% Función principal del proceso suma
suma() ->
    loop(0).

% Bucle principal que maneja el acumulador
loop(Acc) ->
    receive
        {suma, N, P} ->
            NewAcc = Acc + N,
            P ! {respuesta, NewAcc},
            loop(NewAcc);
        stop ->
            ok
    end.

% Función de prueba
prueba_suma() ->
    P = spawn(act6_1, suma, []),
    prueba_suma(5, P).

prueba_suma(N, P) when N > 0 ->
    P ! {suma, N, self()},
    receive
        {respuesta, S} ->
            io:format("Acumulado ~w~n", [S]),
            prueba_suma(N-1, P)
    end;
prueba_suma(_, _) ->
    io:format("Terminé mi trabajo~n").



% Función principal del proceso registro
registro() ->
    registro([]).

% Bucle principal que maneja la lista de nombres
registro(Nombres) ->
    receive
        {registra, Nombre} ->
            case lists:member(Nombre, Nombres) of
                true ->
                    registro(Nombres);
                false ->
                    registro([Nombre | Nombres])
            end;
        {elimina, Nombre} ->
            registro(lists:delete(Nombre, Nombres));
        {busca, Nombre, P} ->
            E = case lists:member(Nombre, Nombres) of
                    true -> si;
                    false -> no
                end,
            P ! {encontrado, E},
            registro(Nombres);
        {lista, P} ->
            P ! {registrados, Nombres},
            registro(Nombres)
    end.


% Función de prueba
prueba_registro() ->
    P = spawn(act6_1, registro, []),
    prueba_registro(P).

prueba_registro(P) ->
    P ! {registra, "Juan"},
    P ! {registra, "María"},
    P ! {registra, "Juan"}, 
    P ! {busca, "Juan", self()},
    receive
        {encontrado, E} ->
            io:format("Juan está ~w~n", [E])
    end,
    P ! {elimina, "María"}, % borra Maria, luego al busca. no debería encontrarla
    P ! {busca, "María", self()},
    receive
        {encontrado, E} ->
            io:format("María está ~w~n", [E])
    after 0 -> 
        io:format("María no está en el registro~n")
    end,
    P ! {lista, self()},
    receive
        {registrados, L} ->
            io:format("Lista de registrados: ~w~n", [L])
    end.