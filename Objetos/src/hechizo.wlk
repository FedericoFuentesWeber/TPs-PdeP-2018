class Hechizo {

	var property nombre
	var property variableDePoder = 1

	method poder() = self.nombre().size() * self.variableDePoder()

	method precio() = self.poder()

	method precioParaLaArmadura(valorBase) = valorBase + self.precio()

	method unidadesDeLucha(duenio) = self.poder()

	method sosPoderoso() = self.poder() > 15
	
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

	method precio() = self.poder()

	method precioParaLaArmadura(valorBase) = valorBase + self.precio()

	method unidadesDeLucha(duenio) = self.poder()

}

