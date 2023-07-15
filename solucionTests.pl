:- include(solucion).

:- begin_tests(tituloDelContenido).

test("Relación de un libro con su título"):-
    titulo(libro(fundation, asimov, 3), fundation).
test("Relación de un disco con su título", fail):-
    titulo(musica(theLastHero, hardRock, alterBridge), theFirstHero).

:- end_tests(tituloDelContenido).

:- begin_tests(descargaDelContenido).

test("Descarga de Contenido de un usuario", 
    set(Contenido = 
        [serie(strangerThings, [thriller, fantasia]),
        pelicula(infinityWar, accion, 2018)])
    ):-
    descargaContenido(mati1009, Contenido).

:- end_tests(descargaDelContenido).