% Actividad 5.2 Programacion recursiva en ERLANG
% Autor: Pedro Jesús Sotelo Arce y Hans Gerhard Moreno
% Ultima fecha de modificación 23/04/2024

-module(act5_2).
-export([armonica/1, baja_sube/1, fibo/1, fibot/1]).

% ================================================================

% Funcion que imitala funcionalidad de la funcion armonica que calcula
% La suma de X terminos

% Funcion Base 
armonica(0) -> 0;

% Funcion de Caso General
armonica(N) when N > 0 ->
    armonica(N, 1, 0).

% Función auxiliar para calcular la suma armónica
armonica(0, _, Suma) -> Suma; 
armonica(N, Actual, Suma) ->
    NuevoTermino = 1 / Actual, 
    armonica(N - 1, Actual + 1, Suma + NuevoTermino). % Llamada recursiva con el siguiente término y la suma actualizada.

% ================================================================

% Funcion baja_sube que muestre la escalera de numeros desde N a 1
% Y luego de regreso de 1 a N

% Funcion BASE
baja_sube(0) -> 0;
% Caso General: Llamada Recursiva 
baja_sube(N) when N > 0 ->
    io:format("~w ", [N]),
    baja_sube(N - 1),
    io:format("~w ", [N]).

% ================================================================

% Función fibo que regrese el n-ésimo elemento de la serie de
% Fibonacci: 1, 1, 2, 3, 5, 8, 13, 21, ... donde cada elemento después de los
% primeros 2 se calcula sumando sus 2 predecesores.

% Funcion Base 
fibo(1) -> 1;
fibo(2) -> 1;
fibo(N) -> fibo(N-1) + fibo(N-2).

% ================================================================

% Obtén la versión terminal de la función fibo como fibot. En este caso
% requerirás de 2 argumentos adicionales en la función auxiliar.

% Funcion Base 
fibot(N) ->
    fibot_iter(N, 0, 1).

% Funcion Iterativa 
fibot_iter(0, A, _B) ->
    A;
fibot_iter(N, A, B) ->
    fibot_iter(N - 1, B, A + B).