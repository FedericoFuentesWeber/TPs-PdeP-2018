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

:- begin_tests(segunda_entrega).

	% Punto A - malaGente
	test(malaGente, set(Malos = [nico, gaston])):- malaGente(Malos).
    test(buenaGente, set(Buenos = [aye, maiu, pedro, juan]), fail):- malaGente(Buenos).

	% Punto B - esUnSucesoFuerte
 	test(la_muerte_de_seymourDiera_en_Futurama_es_algo_fuerte, nondet):- esUnSucesoFuerte(futurama, muerte(seymourDiera)).
    test(la_muerte_de_emperor_es_algo_fuerte, nondet):- esUnSucesoFuerte(starWars, muerte(emperor)).
    test(la_relacion_de_parentesco_de_anakin_y_el_rey_en_starWars_es_algo_fuerte, nondet):- esUnSucesoFuerte(starWars, relacion(parentesco, anakin, rey)).
    test(la_relacion_de_parentesco_de_darthVader_y_luke_es_algo_fuerte, nondet):- esUnSucesoFuerte(starWars, relacion(parentesco, vader, luke)).
    test(la_relacion_amorosa_de_ted_y_robin_en_hymym_es_algo_fuerte, nondet):- esUnSucesoFuerte(himym, relacion(amorosa, ted, robin)).
    test(la_relacion_amorosa_de_swarley_y_robin_en_himym_es_algo_fuerte, nondet):- esUnSucesoFuerte(himym, relacion(amorosa, swarley, robin)).
    test(el_plotTwist_que_contiene_las_palabras_fuegoYBoda_en_got_es_fuerte, nondet):- esUnSucesoFuerte(got, plotTwist([fuego, boda])).
    test(el_plotTwist_que_contiene_la_palabra_suenio_en_got_no_es_algo_fuerte, nondet):- not(esUnSucesoFuerte(got, plotTwist([suenio]))).
    test(el_plotTwist_que_contiene_las_palabras_coma_y_pastillas_en_drHouse_no_es_algo_fuerte, nondet):- not(esUnSucesoFuerte(drHouse, plotTwist([coma, pastillas]))).
        
    % Punto C - popularidad
    test(popularidad_series_populares, set(Populares = [got, starWars, hoc])):- popular(Populares).
    
    % Punto D - fullSpoil
    test(a_Quienes_hace_fullSpoil_nico, set(Quienes = [gaston, aye, juan, maiu])):- fullSpoil(nico, Quienes).
    test(a_Quienes_hace_fullSpoil_gaston, set(Quienes = [aye, juan, maiu])):-fullSpoil(gaston, Quienes).
    test(maiu_no_le_hace_fullSpoil_a_nadie, fail):- fullSpoil(maiu, _).

:- end_tests(segunda_entrega).

quienMira(juan,himym).
quienMira(juan,futurama).
quienMira(juan,got).
quienMira(nico,starWars).
quienMira(maiu,starWars).
quienMira(maiu,onePiece).
quienMira(maiu,got).
quienMira(nico,got).
quienMira(gaston,hoc).
quienMira(pedro,got).

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

paso(got, 3, 2, plotTwist([suenio,sinpiernas])).
paso(got, 3, 12, plotTwist([fuego,boda])).
paso(supercampeones, 9, 9, plotTwist([suenio,coma,sinpiernas])).
paso(drHouse,8,7,plotTwist([coma,pastillas])).

leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).

leDijo(nico,juan, futurama, muerte(seymourDiera)).
leDijo(pedro, aye,got, relacion(amistad, tyrion, dragon)).
leDijo(pedro, nico, got, relacion(parentesco, tyrion, dragon)).


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
 esUnSucesoFuerte(Serie, Suceso),
 paso(Serie,Temporada,_,Suceso).

vieneZafando(Persona,Serie):-
 miraOQuiereMirar(Persona,Serie),
 not(leSpoileo(_,Persona,Serie)),
 cantidadDeEpisodios(Serie,_,_),
 forall(cantidadDeEpisodios(Serie,Temporada,_), pasoAlgoFuerteEnTemporada(Serie, Temporada)).

vieneZafando(Persona,Serie):-
 miraOQuiereMirar(Persona,Serie),
 not(leSpoileo(_,Persona,Serie)),
 esPopular(Serie).

%2da entrega

malaGente(Persona) :-
miraOQuiereMirar(Persona, _),
leSpoileo(Persona, _, Serie),
not(quienMira(Persona, Serie)).

malaGente(Persona) :-
miraOQuiereMirar(Persona, _),
leDijo(Persona, _, _, _),
forall(leDijo(Persona, Victima, _, _), leSpoileo(Persona, Victima, _)).



cantidadTotalQueMira(Serie, TotalQueMira) :-
 findall(Persona, quienMira(Persona, Serie), Personas),
 length(Personas, TotalQueMira).

cantidadTotalQueHablaSobre(Serie, TotalQueHabloSobre) :-
 findall(Persona, leDijo(Persona, _, Serie, _), Personas),
 length(Personas, TotalQueHabloSobre).

popularidad(Serie, Popularidad) :-
 miraOQuiereMirar(_, Serie),
 cantidadTotalQueMira(Serie, TotalQueMira),
 cantidadTotalQueHablaSobre(Serie, TotalQueHabloSobre),
 Popularidad is TotalQueMira * TotalQueHabloSobre.

popular(Serie) :-
 popularidad(Serie, PopularidadSerie),
 popularidad(starWars, PopularidadStarWars),
 PopularidadSerie >= PopularidadStarWars.

popular(hoc).

amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).


fullSpoil(PersonaQueSpoilea, Victima) :-
leSpoileo(PersonaQueSpoilea, Victima, _).

fullSpoil(PersonaQueSpoilea, AmigoDeLaVictima) :-
miraOQuiereMirar(PersonaQueSpoilea, _),
amigo(Victima, AmigoDeLaVictima),
not(leSpoileo(PersonaQueSpoilea, AmigoDeLaVictima, _)),
PersonaQueSpoilea \= AmigoDeLaVictima,
fullSpoil(PersonaQueSpoilea, Victima).



escliche(plotTwist(Laspalabras)):-
 paso(Serie,_,_,plotTwist(Laspalabras)),
 paso(OtraSerie,_,_,plotTwist(Otraspalabras)),
 Serie \= OtraSerie,
 forall(member(Palabra,Laspalabras),member(Palabra,Otraspalabras)).

esUnSucesoFuerte(Serie, plotTwist(Laspalabras)):-
  paso(Serie, Temporada, Capitulo, plotTwist(Laspalabras)),
  cantidadDeEpisodios(Serie,Temporada,Capitulo),
  not(escliche(plotTwist(Laspalabras))).

esUnSucesoFuerte(Serie, muerte(Persona)):-
	paso(Serie,_,_,muerte(Persona)).
esUnSucesoFuerte(Serie, relacion(amorosa,Persona1,Persona2)):-
	paso(Serie,_,_,relacion(amorosa,Persona1,Persona2)).
esUnSucesoFuerte(Serie, relacion(parentesco,Persona1,Persona2)):-
	paso(Serie,_,_,relacion(parentesco,Persona1,Persona2)).




