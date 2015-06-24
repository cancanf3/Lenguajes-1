

%% saltoEnPosicion([[1,4,5,8],[7,4,1,9],[2,5,5,6],[9,8,3,8]], 3, 0, 0, solucion([1,4], 0,0, [este])).

/*cosa(0,0).
cosa(X,Y) :- cosa(X2,Y), X is X2+1.
cosa(X,Y) :- cosa(X,Y2), Y is Y2+1.
cosa(X,Y) :- cosa(X2,Y2), X is X2+1, Y is Y2+1.

crap(0).
crap(X) :- between(0,2,X).
*/
obtener([X|_], 0, X).
obtener([_|XS], N, FX) :- N1 is N-1, obtener(XS, N1, FX).

obtenerValor(T,X,Y,V) :- obtener(T, X, FX), obtener(FX, Y, V).

aux(T, 0, X, Y, solucion([V], X, Y, [])) :- obtenerValor(T, X, Y, V),!.

aux(T, N, X, Y, solucion([L|LS], X, Y, [norte|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, X1 is X-1, X1 >= 0, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).
aux(T, N, X, Y, solucion([L|LS], X, Y, [sur|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, X1 is X+1, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).
aux(T, N, X, Y, solucion([L|LS], X, Y, [este|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, Y1 is Y+1, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).
aux(T, N, X, Y, solucion([L|LS], X, Y, [oeste|PS])) :- obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, Y1 is Y-1, Y1 >= 0, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).


saltoEnPosicion(T, 0, X, Y, solucion([V], X, Y, [])) :- obtenerValor(T, X, Y, V).
saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [norte|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, X1 is X-1, X1 >= 0, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).
saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [sur|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, X1 is X+1, aux(T, N1, X1, Y, solucion(LS, X1, Y, PS)).
saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [este|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, Y1 is Y+1, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).
saltoEnPosicion(T, N, X, Y, solucion([L|LS], X, Y, [oeste|PS])) :- tableroValido(T), obtenerValor(T, X, Y, L), 
         N1 is N-1, N1 >= 0, Y1 is Y-1, Y1 >= 0, aux(T, N1, X, Y1, solucion(LS, X, Y1, PS)).


listaValida([]).
listaValida([X|XS]) :- X >= 0, X =< 10, listaValida(XS).

tableroValido([_|[]]).
tableroValido([X,Y|XS]) :- listaValida(X), length(X, N), length(Y, N), tableroValido([Y|XS]).


