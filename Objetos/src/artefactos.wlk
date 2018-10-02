import personaje.*
import hechizo.*

object mundo {
	var property fuerzaOscura = 5

	method eclipse() {
		fuerzaOscura = fuerzaOscura * 2
	}
}

class ArmaDeFilo{

	method poderDeLucha(duenio) = 3
	method precio(duenio)= 5 * self.poderDeLucha(duenio)
}

object collarDivino{
	var property perlas = 5

	method poderDeLucha(duenio) = self.perlas()
	method precio(duenio) = 2 * self.perlas()
}

class Mascara{
	var property indiceDeOscuridad
	var property minimoValorDeLucha = 4

	method poderDeLucha(duenio) = ((mundo.fuerzaOscura()/2) * self.indiceDeOscuridad()).max(self.minimoValorDeLucha()) 
}

object espejoFantastico {

 	method soloMeContieneAMi(duenio) = duenio.soloContieneUnArtefacto(self)
 	method precio(duenio) = 90 
	
	method poderDeLucha(duenio){
		if(self.soloMeContieneAMi(duenio)){return 0} 
		else{return duenio.maximoPoderSinEspejo()}
	}
}

/*Si se modela al metodo que calcula su poder de lucha de manera que reciba como parametro al personaje que lo posee
 , no es necesario que haya muchos espejos* 
 */