class Hechizo {

	var property nombre
	var property variableDePoder = 1

	method poder() = self.nombre().size() * self.variableDePoder()

	method precioBase() = self.poder()
	
	method descuento(persona) = persona.hechizoPreferido().precioBase() / 2
	
	method precio(persona)=(self.precioBase() - self.descuento(persona)).max(0)

	method precioParaLaArmadura(valorBase) = valorBase + self.precioBase()

	method unidadesDeLucha(duenio) = self.poder()

	method sosPoderoso() = self.poder() > 15
	
	method asignate(persona) = persona.hechizoPreferido(self)
	
	method peso(){
		if (self.poder().even()) return 2
		else return 1
	} 

}

class Logos inherits Hechizo {

}

class HechizoComercial inherits Hechizo {

	var property porcentajeDePoder = 0.2
	var property multiplicadorDePoder = 2

	override method nombre() = "el hechizo comercial"

	override method poder() = (self.nombre().size() * self.porcentajeDePoder()) * self.multiplicadorDePoder()

}

object hechizoBasico {

	method poder() = 10

	method sosPoderoso() = false

	method precio(persona)=(self.precioBase() - persona.hechizoPreferido().precioBase() / 2).max(0)

	method precioBase() = self.poder()
	method asignate(persona) = persona.hechizoPreferido(self)

	method precioParaLaArmadura(valorBase) = valorBase + self.precioBase()

	method unidadesDeLucha(duenio) = self.poder()

}

