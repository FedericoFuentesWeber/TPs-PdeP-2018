class Hechizo {

	var property nombre
	var property variableDePoder = 1

	method poder() = self.nombre().size() * self.variableDePoder()

	method precio() = self.poder()

	method precioParaLaArmadura(valorBase) = valorBase + self.precio()

	method unidadesDeLucha(duenio) = self.poder()

}

class Logos inherits Hechizo {

	method sosPoderoso() = self.poder() > 15

}

object hechizoBasico {

	method poder() = 10

	method sosPoderoso() = false

	method precio() = 10

	method precioParaLaArmadura(valorBase) = valorBase + self.precio()

	method unidadesDeLucha(duenio) = self.poder()

}

