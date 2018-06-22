:- begin_tests(que_series_miran).
	test(juan_mira_GameOfThrones, nondet) :- quienMira(juan,got).
	test(nico_mira_starWars, nondet) :- quienMira(nico,starWars).
:- end_tests(que_series_miran).

:- begin_tests(que_series_planean_ver).
	test(juan_quiere_ver_HouseOfCards, nondet) :- quiereMirar(juan,hoc).
	test(aye_quiere_ver_GameOfThrones, nondet) :- quiereMirar(aye,got).
:- end_tests(que_series_planean_ver).

:- begin_tests(episodios_y_temporadas_de_las_series).
	test(la_temporada_3_de_GameOfThrones_tiene_12_episodios, nondet) :- cantidadDeEpisodios(got,3,12).
	test(la_temporada_8_de_DrHouse_tiene_16_episodios, nondet) :- cantidadDeEpisodios(drHouse,8,16).
:- end_tests(episodios_y_temporadas_de_las_series).

:- begin_tests(que_cosas_pasaron_en_las_series).
	test(en_el_episodio_3_de_la_temporada_2_de_futurama_murio_seymourDiera, nondet) :- paso(futurama, 2, 3, muerte(seymourDiera)).
	test(en_el_episodio_2_de_la_temporada_1_de_starWars_se_dio_una_relacion_de_parentesco_entre_anakin_y_rey, nondet) :- paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
:- end_tests(que_cosas_pasaron_en_las_series).

:- begin_tests(que_cosas_le_dijo_una_persona_a_otra_acerca_de_una_serie).
	test(nico_le_dijo_a_juan_la_muerte_de_tyrion_en_GameOfThrones, nondet) :-leDijo(nico, juan, got, muerte(tyrion)).
	test(aye_le_dijo_a_maiu_la_relacion_de_amistad_entre_tyrion_y_john_en_GameOfThrones, nondet) :- leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
:- end_tests(que_cosas_le_dijo_una_persona_a_otra_acerca_de_una_serie).

:- begin_tests(hechos_spoilers).

	test(la_muerte_de_emperor_es_spoiler_para_starWars, nondet) :- esSpoiler(starWars,muerte(emperor)).
	test(la_muerte_de_pedro_no_es_spoiler_para_starWars, fail) :- esSpoiler(starWars,muerte(pedro)).
	test(la_relacion_de_parentesco_entre_anakin_y_rey_es_spoiler_para_starWars, nondet) :- esSpoiler(starWars,relacion(parentesco,anakin,rey)).
	test(la_relacion_de_parentesco_entre_anakin_y_lavezzi_no_es_spoiler_para_starWars, fail) :- esSpoiler(starWars,relacion(parentesco,anakin,lavezzi)).

:- end_tests(hechos_spoilers).

:- begin_tests(quienes_spoilean).

	test(gaston_le_spoileo_a_maiu_algo_de_gameOfThrones, nondet) :- leSpoileo(gaston, maiu, got).
	test(nico_le_spoileo_a_maiu_algo_de_starWars, nondet) :- leSpoileo(nico,maiu,starWars).

:- end_tests(quienes_spoilean).

:- begin_tests(televidentes_responsables).

	test(televidentes_que_son_responsables, set(TelevidentesResponsables == [juan,maiu,aye])) :- televidenteResponsable(TelevidentesResponsables).
	test(televidentes_que_no_son_responsables, set(TelevidentesResponsables == [gaston,nico]), fail) :- televidenteResponsable(TelevidentesResponsables).

:- end_tests(televidentes_responsables).

:- begin_tests(vienen_zafando).

	test(maiu_no_viene_zafando_de_ninguna_serie, fail) :- vieneZafando(maiu, _).
	test(juan_viene_zafando_con_himym_got_y_hoc, set(Serie == [himym,got,hoc])) :- vieneZafando(juan,Serie).
	test(nico_viene_zafando_con_starWars, set(Persona == [nico])) :- vieneZafando(Persona,starWars).

:- end_tests(vienen_zafando).

quienMira(juan,himym).
quienMira(juan,futurama).
quienMira(juan,got).
quienMira(nico,starWars).
quienMira(maiu,starWars).
quienMira(maiu,onePiece).
quienMira(maiu,got).
quienMira(nico,got).
quienMira(gaston,hoc).

%no se agrega a Alf porque al no poner que mira alguna serie en la base de conocimientos, se asume que este no ve
%ninguna por el principio de universo cerrado.

esPopular(got).
esPopular(hoc).
esPopular(starWars).

quiereMirar(juan,hoc).
quiereMirar(aye,got).
quiereMirar(gaston,himym).

cantidadDeEpisodios(got,3,12).
cantidadDeEpisodios(got,2,10).
cantidadDeEpisodios(himym,1,23).
cantidadDeEpisodios(drHouse,8,16).

%no se puso la serie madMen porque no se sabe cuántos episodios tiene la segunda temporada
%entonces, al no ponerlo se asume que esto no se conoce (Principio de universo cerrado)

paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion(amistad, tyrion, dragon)).

leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).

esSpoiler(Serie, CosaQuePaso) :- paso(Serie, _, _, CosaQuePaso).
%se pueden hacer las dos consultas porque es inversible
%podemos hacer consultas individuales como: "esSpoiler(starWars,muerte(emperor)).". Muestra si cumple o no la regla
%O consultas existenciales como: "esSpoiler(starWars,Spoilers).". Muestra todos los Spoilers de starWars

miraOQuiereMirar(Persona, Serie):- quienMira(Persona, Serie).
miraOQuiereMirar(Persona, Serie):- quiereMirar(Persona, Serie).

leSpoileo(PersonaQueSpoilea, Victima, Serie) :-
	miraOQuiereMirar(Victima, Serie),
	leDijo(PersonaQueSpoilea,Victima,Serie,UnHecho),
	esSpoiler(Serie, UnHecho).

%Lo mismo. Es inversible, por lo tanto admite consultas individuales ("leSpoileo(gaston, maiu, got).")
%y existenciales ("leSpoileo(gaston, Victimas, got)." (personas a las que spoileo gaston)).

televidenteResponsable(BuenTelevidente) :-
 miraOQuiereMirar(BuenTelevidente, _),
 not(leSpoileo(BuenTelevidente,_,_)).

pasoAlgoFuerteEnTemporada(Serie,Temporada):-
 paso(Serie,Temporada,_,muerte(_)).
pasoAlgoFuerteEnTemporada(Serie, Temporada):-
 paso(Serie,Temporada,_,relacion(amorosa,_,_)).
pasoAlgoFuerteEnTemporada(Serie, Temporada):-
 paso(Serie,Temporada,_,relacion(parentesco,_,_)).

vieneZafando(Persona,Serie):-
 miraOQuiereMirar(Persona,Serie),
 not(leSpoileo(_,Persona,Serie)),
 cantidadDeEpisodios(Serie,_,_),
 forall(cantidadDeEpisodios(Serie,Temporada,_), pasoAlgoFuerteEnTemporada(Serie, Temporada)).

vieneZafando(Persona,Serie):-
 miraOQuiereMirar(Persona,Serie),
 not(leSpoileo(_,Persona,Serie)),
 esPopular(Serie).

malaGente(Persona) :-
miraOQuiereMirar(Persona, _),
leSpoileo(Persona, _, Serie),
not(quienMira(Persona, Serie)).

malaGente(Persona) :-
miraOQuiereMirar(Persona, _),
leDijo(Persona, _, _, _),
forall(leDijo(Persona, Victima, _, _), leSpoileo(Persona, Victima, _)).