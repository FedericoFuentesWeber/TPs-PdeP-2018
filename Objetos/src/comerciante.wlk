class ComercianteIndependiente  {
	var property metodo
	method cobrale(objeto)= self.metodo().calcula(objeto)
	method recategorizate(){
		self.metodo().valor(metodo.valor()*2)
		if (self.metodo().valor() > 2.1){
			self.metodo(impuestoAlValorAgregado)
		}
	}
	
}
class ComercianteRegistrado{
	var property metodo = impuestoAlValorAgregado
	method cobrale(objeto)= self.metodo().calcula(objeto)
	method recategorizate(){
		self.metodo(minimoNoImponible)
	}
}
class ComercianteConImpuestoALasGanancias{
	var property metodo = minimoNoImponible
	method cobrale(objeto)= metodo.calcula(objeto)
	method recategorizate(){}
}

class Comicion {
	var property valor
	method calcula(objeto) = objeto.precio() + self.valor()
}
object impuestoAlValorAgregado {
	method calcula(objeto)= objeto.precio() + objeto.precio()* 0.21
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
}