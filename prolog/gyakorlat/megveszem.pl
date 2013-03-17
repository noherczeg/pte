** szabaly */


tetszik(X) :-
    (piros(X), auto(X)
	;
    kek(X), motor(X)).

auto(vw_beatle).
auto(ford_escort).
motor(harley_davidson).
piros(vw_beatle).
piros(ford_escort).
kek(harley_davidson).
