class ComercianteIndependiente  {
	var property comicion
	method comicionRecategotizada() =  2 * self.comicion()
	method cobrale(objeto)= objeto.precio() +  self.comicion()
	
}
class ComercianteRegistrado{
	var property iva = 0.21
	method cobrale(objeto)= objeto.precio() + objeto.precio() * self.iva()
}
class ComercianteConImpuestoALasGanancias{
	var property minimoNoImponible
	method cobrale(objeto){
		if (objeto.precio() < self.minimoNoImponible()){
			return objeto.precio()
		}else{
			return objeto.precio() + (objeto.precio() - self.minimoNoImponible()) * 0.35
		}
	}
	method recategorizate(){}
}