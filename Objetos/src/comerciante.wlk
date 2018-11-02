class Comerciante{
	var property metodo
	method cobrale(objeto,persona)= self.metodo().calcula(objeto,persona)
	method recategorizate() = self.metodo().recategorizate(self)
	
}

class Comicion {
	var property valor
	method calcula(objeto,persona) = objeto.precio(persona) + self.valor()
	method recategorizate(comerciante){
		self.valor(self.valor()*2)
		if (self.valor() > 2.1){
			comerciante.metodo(impuestoAlValorAgregado)
		}
	}
}
object impuestoAlValorAgregado {
	method calcula(objeto,persona)= objeto.precio(persona) + objeto.precio(persona)* 0.21
	method recategorizate(comerciante) = comerciante.metodo(minimoNoImponible)
}
object minimoNoImponible{
	var property minimo = 5
	method calcula(objeto,persona){
		if (objeto.precio(persona) < self.minimo()){
			return objeto.precio()
		}else{
			return objeto.precio(persona) + (objeto.precio(persona) - self.minimo()) * 0.35
		}
	}
	method recategorizate(comerciante){}
}

