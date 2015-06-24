% Proyecto de programacion en Prolog
% Laboratorio de Lenguajes de Programacion
% Autores: Jose Peña (11-10775) Amin Arria(11-10053)




% Predicado que unifica un valor ubicado en una posicion especifica en un tablero.
obtenerValor(T,X,Y,V) :- obtener(T, X, FX), obtener(FX, Y, V).

% Predicado auxiliar usado por obtenerValor.
obtener([X|_], 0, X).
obtener([_|XS], N, FX) :- N1 is N-1, obtener(XS, N1, FX).


% Predicado que unifica una solucion a partir de un 
% tablero, una cantidad de saltos y una ubicacion inicial.

saltoEnPosicion(T, 0, X, Y, solucion([V], X, Y, [])) :- obtenerValor(T, X, Y, V),!.

saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [norte|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, X1 is X-1, X>=0, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).

saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [sur|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, X1 is X+1, X>=0, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).

saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [este|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, Y1 is Y+1, X>=0, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).

saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [oeste|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, Y1 is Y-1, Y1 >= 0, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).


% Predicado auxiliar de saltoEnPosicion que unifica una solucion a partir de un 
% tablero, una cantidad de saltos y una ubicacion inicial.
aux(T, 0, X, Y, solucion([V], X, Y, [])) :- obtenerValor(T, X, Y, V),!.

aux(T, N, X, Y, solucion([L|LS], X, Y, [norte|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, X1 is X-1, X1 >= 0, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).
aux(T, N, X, Y, solucion([L|LS], X, Y, [sur|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, X1 is X+1, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).
aux(T, N, X, Y, solucion([L|LS], X, Y, [este|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, Y1 is Y+1, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).
aux(T, N, X, Y, solucion([L|LS], X, Y, [oeste|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, Y1 is Y-1, Y1 >= 0, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).


% Predicado que unifica una solucion a partir de un tablero,
% calculando por backtracking todas las posiciones iniciales.

salto([T|TS], N, S) :- length([T|TS],Xtam),length(T,Ytam),!, between(0, Xtam, X), between(0,Ytam,Y),  saltoEnPosicion([T|TS], N, X, Y, S).


% Predicado que determina se las filas del tablero son validas.
listaValida([]).
listaValida([X|XS]) :- X >= 0, X =< 10, listaValida(XS).

% Predicado que determina si un tablero dado es valido.
tableroValido([_|[]]).
tableroValido([X,Y|XS]) :- listaValida(X), length(X, N), length(Y, N), tableroValido([Y|XS]).


