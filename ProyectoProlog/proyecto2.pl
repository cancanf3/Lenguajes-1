



tableroValido([_|[]]).
tableroValido([X,Y|XS]) :- length(X, N), length(Y, N), tableroValido([Y|XS]).