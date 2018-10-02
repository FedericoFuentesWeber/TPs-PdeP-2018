import CotaDeMalla.*

class Armadura {

	var property refuerzo = ninguno
	var property valorBase = 2

	method poderDeLucha(duenio) = self.valorBase() + self.refuerzo().unidadesDeLucha(duenio)
	method precio(duenio) = self.refuerzo().precio(self.valorBase())
}

object bendicion{

	method unidadesDeLucha(duenio) = duenio.nivelDeHechiceria()
	method precio(valor) = valor
}

object ninguno{
	method unidadesDeLucha(duenio) = 0
	method precio(valor) = 2
}
