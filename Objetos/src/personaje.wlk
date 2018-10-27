import artefactos.*
import hechizo.*
import mundo.*
import excepciones.*
import comerciante.*

class Personaje {

	var property valorBase = 3
	var property hechizoPreferido
	var property valorBaseDeLucha = 1
	var property monedas = 100
	const property artefactos = []

	const property pesoMaximoCargable = 20		//un valor por defecto cualquiera
	
	method pesoDeUnosArtefactos(unosArtefactos) = unosArtefactos.sum({artefacto => artefacto.pesoTotal()})
	method pesoCargado() = self.pesoDeUnosArtefactos(self.artefactos())
	
	method podesCargarElArtefacto(unArtefacto) = (unArtefacto.pesoTotal() + self.pesoCargado()) <= self.pesoMaximoCargable()
	method noPodesCargarElArtefacto(unArtefacto) = self.podesCargarElArtefacto(unArtefacto).negate()
	
	method podesCargarLosArtefactos(unosArtefactos) = (self.pesoDeUnosArtefactos(unosArtefactos) + self.pesoCargado()) <= self.pesoMaximoCargable()
	method noPodesCargarLosArtefactos(unosArtefactos) = self.podesCargarLosArtefactos(unosArtefactos).negate()
	
	method agregaUnArtefacto(unArtefacto) {
		if(self.noPodesCargarElArtefacto(unArtefacto)){
			throw new ExcepcionPorExcesoDePesoCargado(message = "El personaje no puede cargar el artefacto porque excede lo maximo de peso que puede cargar")
		}
		self.artefactos().add(unArtefacto)
	}
	method agregaUnosArtefactos(unosArtefactos){
		if(self.noPodesCargarLosArtefactos(unosArtefactos)){
			throw new ExcepcionPorExcesoDePesoCargado(message = "El personaje no puede cargar los artefacto porque exceden lo maximo de peso que puede cargar")
		}
		self.artefactos().addAll(unosArtefactos)
	}

	method eliminaUnArtefacto(unArtefacto) {
		self.artefactos().remove(unArtefacto)
	}

	method eliminaTodosLosArtefactos() {
		self.artefactos().clear()
	}

	method nivelDeHechiceria() = (self.valorBase() * self.hechizoPreferido().poder()) + mundo.fuerzaOscura()

	method poderDeLuchaTotalDeTodosLosArtefactos() = self.artefactos().sum({ artefacto => artefacto.poderDeLucha(self) })

	method habilidadDeLucha() = self.valorBaseDeLucha() + self.poderDeLuchaTotalDeTodosLosArtefactos()

	method tenesMasHabilidadDeLuchaQueNivelDeHechiceria() = self.habilidadDeLucha() > self.nivelDeHechiceria()

	method estasCargado() = self.artefactos().size() >= 5

	method mejorArtefacto() = self.artefactos().max({ artefacto => artefacto.poderDeLucha() })

	method soloContieneUnArtefacto(unArtefacto) = self.artefactos().contains(unArtefacto) && self.artefactos().size() == 1

	method maximoPoderSinEspejo() {
		return self.artefactos().filter({ artefacto => !artefacto.equals(espejoFantastico) }).max({ artefacto => artefacto.poderDeLucha(self) }).poderDeLucha(self)
	}

	method realizaUnObjetivo() {
		self.monedas(self.monedas() + 10)
	}

	method compraObjeto(objeto,comerciante) {
		self.monedas(self.monedas() - comerciante.cobrale(objeto))
		self.artefactos().add(objeto)
	}

	method puedoCostearUnHechizo(compra) = self.monedas() > (compra.precio() - self.hechizoPreferido().precio() / 2)

	method puedoCostearUnObjeto(objecto) = self.monedas() > objecto.precio()

	method compraHechizo(hechizo) {
		self.monedas(self.monedas() - (hechizo.precio() - self.hechizoPreferido().precio() / 2).max(0))
		self.hechizoPreferido(hechizo)
	}

}

