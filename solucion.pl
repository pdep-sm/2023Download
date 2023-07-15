% Download !

% libro(título, autor, edición)
recurso(amazingzone, host1, 0.1, libro(lordOfTheRings, jrrTolkien, 4)).
recurso(g00gle, ggle1, 0.04, libro(fundation, asimov, 3)).
recurso(g00gle, ggle1, 0.015, libro(estudioEnEscarlata, conanDoyle, 3)).

% musica(título, género, banda/artista)
recurso(spotify, spot1, 0.3, musica(theLastHero, hardRock, alterBridge)).
recurso(pandora, pand1, 0.3, musica(burn, hardRock, deepPurple)).
recurso(spotify, spot1, 0.3, musica(2, hardRock, blackCountryCommunion)).
recurso(spotify, spot2, 0.233, musica(squareUp, kpop, blackPink)).
recurso(pandora, pand1, 0.21, musica(exAct, kpop, exo)).
recurso(pandora, pand1, 0.28, musica(powerslave, heavyMetal, ironMaiden)).
recurso(spotify, spot4, 0.18, musica(whiteWind, kpop, mamamoo)).
recurso(spotify, spot2, 0.203, musica(shatterMe, dubstep, lindseyStirling)).
recurso(spotify, spot4, 0.22, musica(redMoon, kpop, mamamoo)).
recurso(g00gle, ggle1, 0.31, musica(braveNewWorld, heavyMetal, ironMaiden)).
recurso(pandora, pand1, 0.212, musica(loveYourself, kpop, bts)).
recurso(spotify, spot2, 0.1999, musica(aloneInTheCity, kpop, dreamcatcher)).

% serie(título, géneros)
recurso(netflix, netf1, 30, serie(strangerThings, [thriller, fantasia])).
recurso(fox, fox2, 500, serie(xfiles, [scifi])).
recurso(netflix, netf2, 50, serie(dark, [thriller, drama])).
recurso(fox, fox3, 127, serie(theMentalist, [drama, misterio])).
recurso(amazon, amz1, 12, serie(goodOmens, [comedia,scifi])).
recurso(netflix, netf1, 810, serie(doctorWho, [scifi, drama])).

% pelicula(título, género, año)
recurso(netflix, netf1, 2, pelicula(veronica, terror, 2017)).
recurso(netflix, netf1, 3, pelicula(infinityWar, accion, 2018)).
recurso(netflix, netf1, 3, pelicula(spidermanFarFromHome, accion, 2019)).


%descarga/2
descarga(mati1009, strangerThings).
descarga(mati1009, infinityWar).
descarga(leoOoOok, dark).
descarga(leoOoOok, powerslave).


% 1.a ---------------------------------------------
recurso(Contenido):-
    recurso(_, _, _, Contenido).

titulo(Contenido, Titulo):-
    recurso(Contenido),
    tituloContenido(Contenido, Titulo).

tituloContenido(libro(T, _, _), T).
tituloContenido(serie(T, _), T).
tituloContenido(pelicula(T, _, _), T).
tituloContenido(musica(T, _, _), T).

% 1.b ---------------------------------------------
descargaContenido(Usuario, Contenido):-
    descarga(Usuario, Titulo),
    titulo(Contenido, Titulo).

% 2 ---------------------------------------------
contenidoPopular(Contenido):-
    recurso(Contenido),
    findall(Usuario, descargaContenido(Usuario, Contenido), Usuarios),
    length(Usuarios, Cantidad),
    Cantidad > 10.

% 3 ---------------------------------------------
usuario(Usuario):-
    distinct(Usuario, descarga(Usuario, _)).

cinefilo(Usuario):-
    usuario(Usuario),
    forall(descargaContenido(Usuario, Contenido), esAudiovisual(Contenido)).

esAudiovisual(serie(_, _)).
esAudiovisual(pelicula(_, _, _)).

% 4 ---------------------------------------------
totalDescargado(Usuario, Total):-
    usuario(Usuario),
    findall(Peso, pesoDescargaUsuario(Usuario, _, Peso), Pesos),
    sum_list(Pesos, Total).

pesoDescargaUsuario(Usuario, Contenido, Peso):-
    descargaContenido(Usuario, Contenido),
    recurso(_, _, Peso, Contenido).

% 5 ---------------------------------------------
usuarioCool(Usuario):-
    usuario(Usuario),
    forall(descargaContenido(Usuario, Contenido), esCool(Contenido)).

esCool(musica(_, kpop, _)).
esCool(musica(_, hardRock, _)).
esCool(series(_, Generos)):- length(Generos, Cantidad), Cantidad > 1.
%esCool(series(_, [_, _| _])).
esCool(pelicula(_, _, Anio)):- Anio < 2010.
% Por universo cerrado, no es necesario agregar que el Libro no es Cool!

% 6 ---------------------------------------------
empresaHeterogenea(Empresa):-
    recurso(Empresa, _, _, Contenido1),
    recurso(Empresa, _, _, Contenido2),
    tipoContenido(Contenido1, Tipo1),
    tipoContenido(Contenido2, Tipo2),
    Tipo1 \= Tipo2.

%tipoContenido(libro(_,_,_), libro).
tipoContenido(Contenido, Tipo):-
    Contenido =.. [Tipo|_].

% 7.a ---------------------------------------------
empresaServidor(Empresa, Servidor):-
    distinct(Servidor, recurso(Empresa, Servidor, _ , _)).

cargaServidor(Empresa, Servidor, Carga):-
    empresaServidor(Empresa, Servidor),
    findall(Peso, recurso(Empresa, Servidor, Peso, _) ,Pesos),
    sum_list(Pesos, Carga).

% 7.b ---------------------------------------------
tieneMuchaCarga(Empresa, Servidor):-
    cargaServidor(Empresa, Servidor, Carga),
    Carga > 1000.

% 7.c ---------------------------------------------
servidorMasLiviano(Empresa, Servidor):-
    cargaServidor(Empresa, Servidor, Carga),
    not(tieneMuchaCarga(Empresa, Servidor)),
    not((cargaServidor(Empresa, _, OtraCarga), OtraCarga < Carga)).

% 7.d ---------------------------------------------
balancearServidor(Empresa, ServidorConCarga, ServidorLiviano):-
    tieneMuchaCarga(Empresa, ServidorConCarga),
    servidorMasLiviano(Empresa, ServidorLiviano).






