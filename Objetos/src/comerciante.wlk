class Comerciante{
	var property metodo
	method cobrale(objeto)= self.metodo().calcula(objeto)
	method recategorizate() = self.metodo().recategorizate(self)
	
}

class Comicion {
	var property valor
	method calcula(objeto) = objeto.precio() + self.valor()
	method recategorizate(comerciante){
		self.valor(self.valor()*2)
		if (self.valor() > 2.1){
			comerciante.metodo(impuestoAlValorAgregado)
		}
	}
}
object impuestoAlValorAgregado {
	method calcula(objeto)= objeto.precio() + objeto.precio()* 0.21
	method recategorizate(comerciante) = comerciante.metodo(minimoNoImponible)
}
object minimoNoImponible{
	var property minimo = 5
	method calcula(objeto){
		if (objeto.precio() < self.minimo()){
			return objeto.precio()
		}else{
			return objeto.precio() + (objeto.precio() - self.minimo()) * 0.35
		}
	}
	method recategorizate(comerciante){}
}

