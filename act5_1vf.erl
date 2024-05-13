% Actividad 5.1 Programando en ERLANG
% Autor: Pedro Jesús Sotelo Arce y Hans Gerhard Moreno

-module(act5_1).
-export([mayor/3]).
-export([clima/1]).
-export([cuadrante/2]).
-export([sumapar/4]).
%

mayor(A, B, C) ->
    if 
        A > B, A > C -> A;
        B > A, B > C -> B;
        true -> C
    end.

clima(X) ->
    if 
        X =< 0 -> 'congelado';
        0 < X, X =< 10 -> 'helado';
        10 < X, X =< 20 -> 'frio';
        20 < X, X =< 30 -> 'normal';
        30 < X, X =< 40 -> 'caliente';
        40 < X -> 'hirviendo';
    end.

cuadrante(X, Y) ->
    if
        X == 0, Y == 0 -> 'Origen';
        X == 0, Y > 0 -> 'Eje Y positivo';
        X == 0, Y < 0 -> 'Eje Y negativo';
        X > 0, Y == 0 -> 'Eje X positivo';
        X < 0, Y == 0 -> 'Eje X negativo';
        X > 0, Y > 0 -> 'Primer cuadrante';
        X < 0, Y > 0 -> 'Segundo cuadrante';
        X < 0, Y < 0 -> 'Tercer cuadrante';
        X > 0, Y < 0 -> 'Cuarto cuadrante'
    end.

sumapar(A, B, C, D) ->
    SumaA = 
    if
        A rem 2 == 0 -> A;
        true -> 0 
    end,
        
    SumaB = 
    if 
        B rem 2 == 0 -> B;
        true -> 0 
    end,

    SumaC = 
    if C rem 2 == 0 -> C; 
        true -> 0 
    end,

    SumaD = 
    if 
        D rem 2 == 0 -> D; 
        true -> 0 
    end,
    SumaA + SumaB + SumaC + SumaD.  