class Hechizo {
	var property nombre
	var property variableDePoder = 1
	
	method poder() = self.nombre().size() * self.variableDePoder()
	method sosPoderoso() = self.poder() > 15
<<<<<<< HEAD
	method precio()= self.poder()
=======
	
	method unidadesDeLucha(duenio) = self.poder() 
	
>>>>>>> master
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
<<<<<<< HEAD
 	method precio() = 10
=======
 	method unidadesDeLucha(duenio) = self.poder() 
>>>>>>> master
 }