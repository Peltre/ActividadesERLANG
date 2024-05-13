% Actividad 5.3 Listas y Estructuras de Datos en Erlang
% Autores: Pedro Jesús Sotelo Arce y Hans Gerhard Moreno
% Ultima fecha de modificación 03/05/2024

-module(act5_3).
-export([palindromo/1,profundidad/1,elimina/2,agrega_valor/3,cuenta_nivel/2,elimina_nodo/2]).


% Programar la función recursiva palíndromo(N) que regresa una lista que
% represente un palíndromo que resulta de anidar los números enteros de 0 a N.

palindromo(0) -> [0, 0];
palindromo(N) when N > 0 ->
    List = lists:seq(0, N),
    List ++ lists:reverse(List).


% Programar la función recursiva profundidad(Lista) que determine y regrese el
% nivel máximo de anidación dentro de una lista posiblemente imbricada

profundidad(Lista) ->
    profundidad(Lista, 0).

profundidad([], Depth) ->
    Depth;
profundidad([H|T], Depth) when is_list(H) ->
    MaxDepth = profundidad(H, Depth + 1),
    profundidad(T, MaxDepth);
profundidad([_|T], Depth) ->
    profundidad(T, Depth).


% Programar la función recursiva elimina(Dato, Lista) que reduzca una lista
% posiblemente imbricada eliminando todos los elementos que coincidan con un
% dato especificado por su primer argumento

elimina(_, []) -> [];
elimina(Dato, [Head|Tail]) ->
    NewHead = if
        is_list(Head) ->
            [elimina(Dato, Head)];
        Head == Dato ->
            [];
        true ->
            [Head]
    end,
    NewTail = elimina(Dato, Tail),
    NewHead ++ NewTail.


% Funcion para agregar valor siguiendo la estructura de valor, posicion y matriz
% PARA PRUEBAS ES VALOR, {POS1,POS2}, [[X,X,X],[X,X,X]]
% Caso base: si la posición P está fuera de los límites de la matriz, añadir renglones y/o columnas.
agrega_valor(V, P, M) when element(1, P) > length(M) ->
    FilasFaltantes = element(1, P) - length(M),
    NuevasFilas = lists:duplicate(FilasFaltantes, lists:duplicate(length(hd(M)), 0)),
    NuevaMatriz = M ++ NuevasFilas,
    agrega_valor(V, P, NuevaMatriz);
agrega_valor(V, P, M) when element(2, P) > length(hd(M)) ->
    ColumnasFaltantes = element(2, P) - length(hd(M)),
    NuevasColumnas = lists:duplicate(ColumnasFaltantes, 0),
    NuevaMatriz = lists:map(fun(Fila) -> Fila ++ NuevasColumnas end, M),
    agrega_valor(V, P, NuevaMatriz);
% Caso base: si la posición P está dentro de los límites de la matriz, sustituir el valor.
agrega_valor(V, {Fila, Columna}, M) ->
    NuevaMatriz = lists:sublist(M, Fila-1) ++ [reemplazar_en_fila(V, Columna, lists:nth(Fila, M))] ++ lists:sublist(M, Fila+1, length(M)-Fila),
    NuevaMatriz.

reemplazar_en_fila(Nuevo, Indice, Lista) ->
    lists:sublist(Lista, Indice-1) ++ [Nuevo] ++ lists:sublist(Lista, Indice+1, length(Lista)-Indice).


% Programar la función cuenta_nivel(Nivel,Arbol) que regrese la cantidad de
% nodos en cierto nivel de un árbol binario. La raíz se encuentra en el nivel 0.

% EN VEZ DE LLAMAR FUNCION, PRIMERO CORRE ESTO:
% Abb = {8,{5,{2,nil,nil},{7,nil,nil}},{9,nil,{15,{11,nil,nil},nil}}}.

cuenta_nivel(Nivel, Arbol) ->
    cuenta_nivel(Nivel, Arbol, 0).

cuenta_nivel(_, nil, _) ->
    0;
cuenta_nivel(Nivel, {_, Izq, Der}, NivelActual) ->
    case NivelActual of
        Nivel ->
            1 + cuenta_nivel(Nivel, Izq, NivelActual + 1) + cuenta_nivel(Nivel, Der, NivelActual + 1);
        _ ->
            cuenta_nivel(Nivel, Izq, NivelActual + 1) + cuenta_nivel(Nivel, Der, NivelActual + 1)
    end.


% Funcion para eliminar un nodo del Grafo implementado
%Grafo = [
%    [a,{b,2},{d,10}],
%    [b,{c,9},{e,5}],
%    [c,{a,12},{d,6}],
%    [d,{e,7}],
%    [e,{c,3}]
% ].
% Elimina un nodo y los arcos dirigidos hacia él del grafo dado
elimina_nodo(Grafo, Nodo) ->
    lists:map(fun([NodoOrigen | Arcos]) ->
        case NodoOrigen of
            Nodo -> []; % Si es el nodo a eliminar, devolver lista vacía (eliminar el nodo y sus arcos)
            _ -> [NodoOrigen | lists:filter(fun({Destino, _}) -> Destino /= Nodo end, Arcos)]
        end
    end, Grafo).