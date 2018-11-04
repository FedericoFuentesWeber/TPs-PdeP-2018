class Comerciante{
	var property metodoDeCobro
	method cobrale(objeto,persona)= self.metodoDeCobro().calculaCostoDelObjeto(objeto,persona)
	method recategorizate() = self.metodoDeCobro().recategorizate(self)
	
}

class Comicion {
	var property valor
	method calculaCostoDelObjeto(objeto,persona) = objeto.precio(persona) + self.valor()
	method recategorizate(comerciante){
		self.valor(self.valor()*2)
		if (self.valor() > 2.1){
			comerciante.metodoDeCobro(impuestoAlValorAgregado)
		}
	}
}
object impuestoAlValorAgregado {
	method calculaCostoDelObjeto(objeto,persona)= objeto.precio(persona) + objeto.precio(persona)* 0.21
	method recategorizate(comerciante) = comerciante.metodoDeCobro(minimoNoImponible)
}
object minimoNoImponible{
	var property minimo = 5
	method calculaCostoDelObjeto(objeto,persona){
		if (objeto.precio(persona) < self.minimo()){
			return objeto.precio()
		}else{
			return objeto.precio(persona) + (objeto.precio(persona) - self.minimo()) * 0.35
		}
	}
	method recategorizate(comerciante){}
}

