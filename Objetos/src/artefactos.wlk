import personaje.*

object mundo {
	var property fuerzaOscura = 5

	method eclipse() {
		fuerzaOscura = fuerzaOscura * 2
	}
}

object espadaDelDestino{
	method poderDeLucha() = 3
}

object collarDivino{
	var property perlas = 5
	
	method poderDeLucha() = self.perlas()
}

object mascaraOscura{
	method poderDeLucha() = (mundo.fuerzaOscura()/2).max(4)
}


object armadura{
	var property duenio
	var property refuerzo = ninguno

	method poderDeLucha() = 2 + self.refuerzo().unidadesDeLucha(self.duenio())
}

object cotaDeMalla{
	method unidadesDeLucha(duenio) = 1
}

object bendicion{
	var property unidadesDeLucha

	method unidadesDeLucha(duenio) { unidadesDeLucha = duenio.nivelDeHechiceria()}
}

object hechizo{
	var property unidadesDeLucha
	var property hechizoDeRefuerzo

	method unidadesDeLucha(duenio) { unidadesDeLucha = self.hechizoDeRefuerzo().poder() }
}

object ninguno{
	method unidadesDeLucha(duenio) = 0
}

object espejoFantastico{
 	var property duenio
 	
 	method soloMeContieneAMi() = duenio.soloContieneUnArtefacto(self)
	
	method poderDeLucha(){
		if(self.soloMeContieneAMi()){return 0} 
		else{return duenio.maximoPoderSinEspejo()}
	}
}

object libroDeHechizos{
	const property hechizos = []

	method agregaHechizos(nuevosHechizos) { self.hechizos().addAll(nuevosHechizos) }
	method agregaHechizo(nuevoHechizo) { self.hechizos().add(nuevoHechizo) }

	method poder() = self.hechizos().filter({hechizo => hechizo.sosPoderoso()}).sum({hechizo => hechizo.poder()})
}

/*No seria posible para el libro de hechizos agregarse a si mismo a su lista de hechizos ya que el libro no reconoze el method sosPoderoso */