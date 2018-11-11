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

	override method poder() = super() * self.multiplicadorDePoder()

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

class LibroDeHechizos inherits Hechizo{

	const property hechizos = []

	method agregaHechizos(nuevosHechizos) {
		self.hechizos().addAll(nuevosHechizos)
	}

	method agregaHechizo(nuevoHechizo) {
		self.hechizos().add(nuevoHechizo)
	}
	override method asignate(persona)=persona.artefactos().add(self)

	override method precio(persona) = self.hechizos().size() * 10 + self.hechizos().sum({ magia => magia.poder() })

	override method poder() = self.hechizos().filter({ hechizo => hechizo.sosPoderoso() }).sum({ hechizo => hechizo.poder() })

}

//es necesario que haya muchos, porque cada libro de hechizos tendra su propia lista
//de hechizos (tienen estado interno)
//si el libro de hechizos tuviera un metodo para saber si es poderoso, podria un libro de hechizos incluir 
//a otro, ya que podria calcular el poder de cada hechizo de cada libro de hechizos al ser todos objetos distintos,
//sin producirse una recursividad infinita. Solo se produciria en el caso de que un libro de hechizos tenga
//como hechizo de vuelta al mismo libro de hechizos que los contiene 
