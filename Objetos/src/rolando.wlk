
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

object rolando{
	var valorBase = 3
	var hechizoPreferido = espectroMalefico
	var fuerzaOscura = 5
	var valorBaseDeLucha = 1
	const artefactos = []
	
	method valorBase() = valorBase
	
	method fuerzaOscura() = fuerzaOscura
	method fuerzaOscura(unaFuerzaOscura){
		fuerzaOscura = unaFuerzaOscura
	} 
	
	method hechizoPreferido() = hechizoPreferido
	method hechizoPreferido(unHechizo){
		hechizoPreferido = unHechizo
	} 
	method nivelDeHechizeria() = (self.valorBase() * self.hechizoPreferido().poder()) + self.fuerzaOscura()
	
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
	method poderDeLuchaTotalDeTodosLosArtefactos() = self.artefactos().sum({artefacto => artefacto.poderDeLucha(self.fuerzaOscura())})
	
	method valorBaseDeLucha() = valorBaseDeLucha
	method valorBaseDeLucha(unValorBaseDeLucha){
		valorBaseDeLucha = unValorBaseDeLucha
	}
	
	method habilidadDeLucha() = self.valorBaseDeLucha() + self.poderDeLuchaTotalDeTodosLosArtefactos()
	
	method tenesMasHabilidadDeLuchaQueNivelDeHechizeria() = self.habilidadDeLucha() > self.nivelDeHechizeria()
}

object espadaDelDestino{
	method poderDeLucha(unaFuerzaOscura) = 3
}

object collarDivino{
	var cantidadDePerlas 
	method cantidadDePerlas() = cantidadDePerlas
	method cantidadDePerlas(unaCantidadDePerlas){
		cantidadDePerlas = unaCantidadDePerlas
	}
	method poderDeLucha(unaFuerzaOscura) = self.cantidadDePerlas()
}

object mascaraOscura{
	method poderDeLucha(unaFuerzaOscura) = (unaFuerzaOscura/2).max(4)
}