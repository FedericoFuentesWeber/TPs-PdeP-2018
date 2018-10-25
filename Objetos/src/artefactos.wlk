import personaje.*
import hechizo.*
import mundo.*

class ArmaDeFilo {

	const property puntosAportados = 3

	method poderDeLucha(duenio) = self.puntosAportados()

	method precio() = 5 * self.puntosAportados()

}

class CollarDivino {

	var property perlas = 5

	method poderDeLucha(duenio) = self.perlas()

	method precio() = 2 * self.perlas()

}

class Mascara {

	var property indiceDeOscuridad
	var property minimoValorDeLucha = 4

	method poderDeLucha(duenio) = ((mundo.fuerzaOscura() / 2) * self.indiceDeOscuridad()).max(self.minimoValorDeLucha())

}

object espejoFantastico {

	method soloMeContieneAMi(duenio) = duenio.soloContieneUnArtefacto(self)

	method precio() = 90

	method poderDeLucha(duenio) {
		if (self.soloMeContieneAMi(duenio)) {
			return 0
		} else {
			return duenio.maximoPoderSinEspejo()
		}
	}

}

/*Si se modela al metodo que calcula su poder de lucha de manera que reciba como parametro al personaje que lo posee
 *  , no es necesario que haya muchos espejos* 
 */
class Armadura {

	var property refuerzo = ninguno
	var property valorBase = 2

	method poderDeLucha(duenio) = self.valorBase() + self.refuerzo().unidadesDeLucha(duenio)

	method precio() = self.refuerzo().precioParaLaArmadura(self.valorBase())

}

object bendicion {

	method unidadesDeLucha(duenio) = duenio.nivelDeHechiceria()

	method precioParaLaArmadura(valorBase) = valorBase

}

object ninguno {

	method unidadesDeLucha(duenio) = 0

	method precioParaLaArmadura(valorBase) = 2

}

class CotaDeMalla {

	const property unidadesDeLucha

	method unidadesDeLucha(duenio) = self.unidadesDeLucha()

	method precioParaLaArmadura(valorBase) = self.unidadesDeLucha() / 2

}

