
object espectroMalefico {
	var property nombre = "espectro maléfico"
	
	method poder() = nombre.size()
	method sosPoderoso() = self.poder() > 15
}

object hechizoComun{
	method poder() = 10
	method sosPoderoso() = false
}

object mundo {
	var property fuerzaOscura = 5

	method eclipse() {
		fuerzaOscura = fuerzaOscura * 2
	}
}

object rolando{
	var property valorBase = 3
	var property hechizoPreferido = espectroMalefico
	var property valorBaseDeLucha = 1
	const property artefactos = []

	method agregaUnArtefacto(unArtefacto) {
		self.artefactos().add(unArtefacto)
	}
	method agregaUnosArtefactos(unosArtefactos){
		self.artefactos().addAll(unosArtefactos)
	}
	method eliminaUnArtefacto(unArtefacto){
		self.artefactos().remove(unArtefacto)
	}
	method eliminaTodosLosArtefactos(){
		self.artefactos().clear()
	}

	method nivelDeHechiceria() = (self.valorBase() * self.hechizoPreferido().poder()) + mundo.fuerzaOscura()

	method poderDeLuchaTotalDeTodosLosArtefactos() = self.artefactos().sum({artefacto => artefacto.poderDeLucha()})

	method habilidadDeLucha() = self.valorBaseDeLucha() + self.poderDeLuchaTotalDeTodosLosArtefactos()

	method tenesMasHabilidadDeLuchaQueNivelDeHechiceria() = self.habilidadDeLucha() > self.nivelDeHechiceria()

	method estasCargado() = self.artefactos().size() >= 5

	method mejorArtefacto() = self.artefactos().max({ artefacto => artefacto.poderDeLucha() })
}

object espadaDelDestino{
	method poderDeLucha() = 3
}

object collarDivino{
	var property perlas = 5
}

object mascaraOscura{
	method poderDeLucha() = (mundo.fuerzaOscura()/2).max(4)
}


object armadura{
	var property refuerzo = ninguno

	method poderDeLucha() = 2 + self.refuerzo().unidadesDeLucha()
}

object cotaDeMalla{
	method unidadesDeLucha() = 1
}

object bendicion{
	var unidadesDeLucha

	method unidadesDeLucha() = unidadesDeLucha
	method unidadesDeLucha(nivelDeHechiceria) { unidadesDeLucha = nivelDeHechiceria}
}

object hechizo{
	var unidadesDeLucha

	method unidadesDeLucha() = unidadesDeLucha
	method unidadesDeLucha(tipoHechizo) { unidadesDeLucha = tipoHechizo.poder() }
}

object ninguno{
	method unidadesDeLucha() = 0
}

object espejoFantastico{
	var property duenio = rolando

	method soloMeContieneAMi() = self.duenio().artefactos().size() == 1
	method poderDeLucha(){
		if(self.soloMeContieneAMi())
			return 0
			return self.maximoPoder()
	}

	method maximoPoder(){
	return self.duenio().artefactos()
	.filter({artefacto => !artefacto.equals(self)})
	.max({artefacto => artefacto.poderDeLucha()}).poderDeLucha()
	}

}

object libroDeHechizos{
	const property hechizos = []

	method agregaHechizos(nuevosHechizos) { self.hechizos().addAll(nuevosHechizos) }
	method agregaHechizo(nuevoHechizo) { self.hechizos().add(nuevoHechizo) }

	method poder() = self.hechizos().filter({hechizo => hechizo.sosPoderoso()}).sum({hechizo => hechizo.poder()})
}

/*No seria posible para el libro de hechizos agregarse a si mismo a su lista de hechizos ya que el libro no reconoze el method sosPoderoso */