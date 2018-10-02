class Armadura {

	var property refuerzo = ninguno
	var property valorBase = 2

	method poderDeLucha(duenio) = self.valorBase() + self.refuerzo().unidadesDeLucha(duenio)
}

object bendicion{

	method unidadesDeLucha(duenio) = duenio.nivelDeHechiceria()
}

object ninguno{
	method unidadesDeLucha(duenio) = 0
}
