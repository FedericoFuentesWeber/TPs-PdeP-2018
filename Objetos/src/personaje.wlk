import artefactos.*
import hechizo.*


class Personaje{
	var property valorBase = 3
	var property hechizoPreferido
	var property valorBaseDeLucha = 1
	var property monedas = 100
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

	method poderDeLuchaTotalDeTodosLosArtefactos() = self.artefactos().sum({artefacto => artefacto.poderDeLucha(self)})

	method habilidadDeLucha() = self.valorBaseDeLucha() + self.poderDeLuchaTotalDeTodosLosArtefactos()

	method tenesMasHabilidadDeLuchaQueNivelDeHechiceria() = self.habilidadDeLucha() > self.nivelDeHechiceria()

	method estasCargado() = self.artefactos().size() >= 5

	method mejorArtefacto() = self.artefactos().max({ artefacto => artefacto.poderDeLucha() })
	
	method soloContieneUnArtefacto(unArtefacto) = self.artefactos().contains(unArtefacto) && self.artefactos().size() == 1
	
	method maximoPoderSinEspejo(){
	return self.artefactos()
	.filter({artefacto => !artefacto.equals(espejoFantastico)})
	.max({artefacto => artefacto.poderDeLucha(self)}).poderDeLucha(self)
	}
	
	method compraHechizo(hechizo){
		self.monedas(self.monedas() - (hechizo.precio() - self.hechizoPreferido().precio()).max(0))
		self.hechizoPreferido(hechizo)
	}
}
