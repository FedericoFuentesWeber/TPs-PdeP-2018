import personaje.*
import hechizo.*
import mundo.*

class Artefacto{
	var property pesoOriginal = 1
	const property fechaDeCompra = new Date()
	method pesoTotal() = self.pesoOriginal() - self.desgaste()
	
	method desgaste() = (self.antiguedadEnDias() / 1000).min(1)
	method antiguedadEnDias() = new Date() - self.fechaDeCompra() 
	
}

class ArmaDeFilo inherits Artefacto{

	const property puntosAportados = 3

	method poderDeLucha(duenio) = self.puntosAportados()

	method precio() = 5 * self.pesoTotal()

}

class CollarDivino inherits Artefacto{

	var property perlas = 5

	method poderDeLucha(duenio) = self.perlas()

	method precio() = 2 * self.perlas()
	
	override method pesoTotal() = super() + self.pesoPerlas()
	method pesoPerlas() = self.perlas() * 0.5

}

class Mascara inherits Artefacto{

	var property indiceDeOscuridad
	var property minimoValorDeLucha = 4

	method poderDeLucha(duenio) = self.poderDeLucha()
	method poderDeLucha() = ((mundo.fuerzaOscura()/2) * self.indiceDeOscuridad()).max(self.minimoValorDeLucha())
	method precio() = 10 * self.indiceDeOscuridad() 
	
	override method pesoTotal() = super() + self.pesoDeLucha()
	method pesoDeLucha() = (self.poderDeLucha() - 3).max(0)

}

object espejoFantastico inherits Artefacto{

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
class Armadura inherits Artefacto{

	var property refuerzo = ninguno
	var property valorBase = 2

	method poderDeLucha(duenio) = self.valorBase() + self.refuerzo().unidadesDeLucha(duenio)

	method precio() = self.refuerzo().precioParaLaArmadura(self.valorBase())
	
	override method pesoTotal() = super() + refuerzo.peso()

}

object bendicion {

	method unidadesDeLucha(duenio) = duenio.nivelDeHechiceria()

	method precioParaLaArmadura(valorBase) = valorBase
	
	method peso() = 0

}

object ninguno {

	method unidadesDeLucha(duenio) = 0

	method precioParaLaArmadura(valorBase) = 2
	method peso() = 0

}

class CotaDeMalla {

	const property unidadesDeLucha

	method unidadesDeLucha(duenio) = self.unidadesDeLucha()

	method precioParaLaArmadura(valorBase) = self.unidadesDeLucha() / 2
	
	method peso() = 1

}

