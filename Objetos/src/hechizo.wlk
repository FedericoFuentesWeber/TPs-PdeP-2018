class Hechizo {
	var property nombre
	var property variableDePoder = 1
	
	method poder() = self.nombre().size() * self.variableDePoder()
	method sosPoderoso() = self.poder() > 15
	method precio()= self.poder()
	method precioParaLaArmadura(valor) = valor + self.precio()
	method unidadesDeLucha(duenio) = self.poder()  
}
/*
class HechizoBasico inherits Hechizo{
	
	override method poder() = 10
	override method sosPoderoso() = false
}
 */
 
 object hechizoBasico{
 	
 	method poder() = 10
 	method sosPoderoso() = false
 	method precio() = 10
 	method precioParaLaArmadura(valor) = valor + self.precio()
 	method unidadesDeLucha(duenio) = self.poder() 
 }