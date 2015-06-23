


%% cosa(X,Y) :- between(0,9,X), between(0,9,Y).

%% saltoEnPosicion(T, N, X, Y, S) :- 

listaValida([]).
listaValida([X|XS]) :- X >= 0, X =< 10, listaValida(XS).

tableroValido([_|[]]).
tableroValido([X,Y|XS]) :- listaValida(X), length(X, N), length(Y, N), tableroValido([Y|XS]).


