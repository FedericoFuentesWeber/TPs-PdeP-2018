
object espectroMalefico {
	var nombre = "espectro maléfico"
	method nombre() = nombre
	method nombre(unNombre){
		nombre = unNombre
	}
	method poder() = nombre.size()
	method sosPoderoso() = nombre.size() > 15
}

object hechizoComun{
	method poder() = 10
	method sosPoderoso() = false
}

object fuerzaOscura {
	var poder = 5

	method poder() = poder
	method poder(unPoder) {poder = unPoder}

	method eclipse() {
		poder = poder * 2
	}
}

object rolando{
	var valorBase = 3
	var hechizoPreferido = espectroMalefico
	var valorBaseDeLucha = 1
	const artefactos = []

	method valorBase() = valorBase
	method valorBase(unValorBase) {valorBase = unValorBase}

	method valorBaseDeLucha() = valorBaseDeLucha
	method valorBaseDeLucha(unValorBaseDeLucha){
		valorBaseDeLucha = unValorBaseDeLucha
	}

	method hechizoPreferido() = hechizoPreferido
	method hechizoPreferido(unHechizo){
		hechizoPreferido = unHechizo
	}

	method artefactos() = artefactos
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

	method nivelDeHechiceria() = (valorBase * hechizoPreferido.poder()) + fuerzaOscura.poder()

	method poderDeLuchaTotalDeTodosLosArtefactos() = artefactos.sum({artefacto => artefacto.poderDeLucha()})

	method habilidadDeLucha() = valorBaseDeLucha + self.poderDeLuchaTotalDeTodosLosArtefactos()

	method tenesMasHabilidadDeLuchaQueNivelDeHechiceria() = self.habilidadDeLucha() > self.nivelDeHechiceria()

	method estasCargado() = artefactos.size() >= 5

	method mejorArtefacto() = self.artefactos().max({ artefacto => artefacto.poderDeLucha() })
}

object espadaDelDestino{
	method poderDeLucha(unaFuerzaOscura) = 3
}

object collarDivino{
	var perlas = 5

	method poderDeLucha() = perlas
	method perlas(unasPerlas){
		perlas = unasPerlas
	}
}

object mascaraOscura{
	method poderDeLucha() = (fuerzaOscura/2).max(4)
}


object armadura{
	var refuerzo

	method refuerzo() = refuerzo
	method refuerzo(nuevoRefuerzo) { refuerzo = nuevoRefuerzo }

	method poderDeLucha(){
		if(refuerzo == null)
			return 2
			return 2 + refuerzo.unidadesDeLucha()
	}
}

object cotaDeMalla{
	var unidadesDeLucha = 1

	method unidadesDeLucha() = unidadesDeLucha
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

object espejoFantastico{
	var duenio = rolando

	method duenio() = duenio
	method duenio(nuevoDuenio) { duenio = nuevoDuenio }

	method soloMeContieneAMi() = duenio.artefactos().size() == 1
	method poderDeLucha(){
		if(self.soloMeContieneAMi())
			return 0
			return self.maximoPoder()
	}

	method maximoPoder(){
	return duenio.artefactos()
	.filter({artefacto => !artefacto.equals(self)})
	.max({artefacto => artefacto.poderDeLucha()}).poderDeLucha()
	}

}

object libroDeHechizos{
	const hechizos = []

	method hechizos() = hechizos
	method agregaHechizos(nuevosHechizos) { self.hechizos().addAll(nuevosHechizos) }
	method agregaHechizo(nuevoHechizo) { self.hechizos().add(nuevoHechizo) }

	method poder() = hechizos.filter({hechizo => hechizo.sosPoderoso()}).sum({hechizo => hechizo.poder()})
}

//Si solo se buscara agregarlo asi mismo no pasaria nada, pero en caso de querer averiguar cual seria el nivel de hechicería de Rolando cuando tenga este libro como hechizo
//preferido no podría hacerlo ya que no sabria como interpretar el method sosPoderoso()
