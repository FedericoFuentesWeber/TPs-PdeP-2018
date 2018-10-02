class LibroDeHechizos {
	
	const property hechizos = []

	method agregaHechizos(nuevosHechizos) { self.hechizos().addAll(nuevosHechizos) }
	method agregaHechizo(nuevoHechizo) { self.hechizos().add(nuevoHechizo) }

	method poder() = self.hechizos().filter({hechizo => hechizo.sosPoderoso()}).sum({hechizo => hechizo.poder()})
}

//es necesario que haya muchos, porque cada libro de hechizos tendra su propia lista
//de hechizos (tienen estado interno)

//si el libro de hechizos tuviera un metodo para saber si es poderoso, podria un libro de hechizos incluir 
//a otro, pero como no lo tiene, no es posible hacer esto