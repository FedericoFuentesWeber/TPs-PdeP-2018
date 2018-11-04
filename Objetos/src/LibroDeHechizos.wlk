class LibroDeHechizos {

	const property hechizos = []

	method agregaHechizos(nuevosHechizos) {
		self.hechizos().addAll(nuevosHechizos)
	}

	method agregaHechizo(nuevoHechizo) {
		self.hechizos().add(nuevoHechizo)
	}
	method asignate(persona)=persona.artefactos().add(self)

	method precio(persona) = self.hechizos().size() * 10 + self.hechizos().sum({ magia => magia.poder() })

	method poder() = self.hechizos().filter({ hechizo => hechizo.sosPoderoso() }).sum({ hechizo => hechizo.poder() })

}

//es necesario que haya muchos, porque cada libro de hechizos tendra su propia lista
//de hechizos (tienen estado interno)
//si el libro de hechizos tuviera un metodo para saber si es poderoso, podria un libro de hechizos incluir 
//a otro, ya que podria calcular el poder de cada hechizo de cada libro de hechizos al ser todos objetos distintos,
//sin producirse una recursividad infinita. Solo se produciria en el caso de que un libro de hechizos tenga
//como hechizo de vuelta al mismo libro de hechizos que los contiene 