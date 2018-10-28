import personaje.*

class PersonajeNoControladoPorHumano inherits Personaje{
	var property nivelDeDificultad
	
	override method habilidadDeLucha() = self.nivelDeDificultad().modificaUnaHabilidadDeLucha(super())
}

object dificultadFacil{
	method modificaUnaHabilidadDeLucha(unaHabilidadDeLucha) = unaHabilidadDeLucha
}

object dificultadModerada{
	method modificaUnaHabilidadDeLucha(unaHabilidadDeLucha) = unaHabilidadDeLucha*2
}

object dificultadDificil{
	method modificaUnaHabilidadDeLucha(unaHabilidadDeLucha) = unaHabilidadDeLucha*4
}