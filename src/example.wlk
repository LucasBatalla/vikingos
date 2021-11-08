class Vikingo{
	var castaSocial
	var oro
	method puedeSubirAExpedicion(){
		if(self.esProductivo() and castaSocial.aceptadoParaExpedicion(self)){
			return true
		}
		
		throw new DomainException(message = "El vikingo no puede subirse a la expedicion")
	}
	
	method escalarSocialmene(){
		castaSocial = castaSocial.castaSuperior(self)
	}
	
	method ganarOro(cantidad){
		oro = oro + cantidad
	}
	
	method esProductivo()
	
	method poseeArmas()
	
	method cobrarVida()
	
	method beneficiosPorEscalarSocialmente()
}

class Soldado inherits Vikingo{
	var vidasCobradas
	var cantArmas
	
	override method esProductivo(){
		return vidasCobradas > 20 and self.poseeArmas()
	}
	
	override method poseeArmas(){
		return cantArmas > 0
	}
	
	override method cobrarVida(){
		vidasCobradas += 1
	}
	
	override method beneficiosPorEscalarSocialmente(){
		cantArmas += 10
	}
	
}

class Granjero inherits Vikingo{
	var cantHijos
	var hectareasParaHijos
	
	override method esProductivo(){
		return self.puedeAlimentarAHijos()
	}
	
	method puedeAlimentarAHijos(){
		return hectareasParaHijos >= 2 * cantHijos
	}
	
	override method beneficiosPorEscalarSocialmente(){
		cantHijos += 2
		hectareasParaHijos += 2
	}
	
	
}

class Expedicion{
	var vikingosEnExpedicion
	
	method valeLaPena()
	
	method botin()
	
	method invadir(){
		self.valeLaPena()
		self.dividirBotin()
	}
	
	method dividirBotin(){
	 vikingosEnExpedicion.forEach({vikingo => vikingo.ganarOro(self.botinParaCadaVikingo())})
	}
	
	method botinParaCadaVikingo(){
		return self.botin() / vikingosEnExpedicion.size()
	}
}


class InvasionCapital inherits Expedicion{
	var defensoresDerrotados
	var factorDeRiquezaTierra
	
	
	
	override method valeLaPena(){
		return self.botin() > 3 * vikingosEnExpedicion.size() 
	}
	
	override method botin() = defensoresDerrotados * factorDeRiquezaTierra
		
	
	method invadirCapital(){
		vikingosEnExpedicion.forEach({vikingo => vikingo.cobrarVida()})
	}
	
	
}

class InvasionAldeas inherits Expedicion{
	var aldeasAInvadir
	
	
	override method valeLaPena(){
	if((self.aldeasAmuralladas()).size() > 0){
	return self.saciaSedDeSaqueo() and self.puedeInvadirAldeasAmuralladas()
	}
	return self.saciaSedDeSaqueo()
	}
	
	
	method puedeInvadirAldeasAmuralladas(){
	return (self.aldeasAmuralladas()).forEach({aldeaAmurallada => aldeaAmurallada.vikingosNecesarios() <= vikingosEnExpedicion}) 	
	}
	
	
	
	method saciaSedDeSaqueo(){
		return aldeasAInvadir.all({aldea => self.botinPotencial(aldea) >= 15 })
	}
	
	
	method aldeasAmuralladas(){
		return aldeasAInvadir.filter({aldea => aldea.estaAmurallada()})
	}
	
	method botinPotencial(aldea){
		return aldea.cantidadTotalDeCrucifijos()
	}
	
}


class Aldea{
	var iglesias
	method cantidadTotalDeCrucifijos(){
		return (iglesias.forEach({iglesia => iglesia.cantCrucifijos()})).sum()
	}
	
	method estaAmurallada(){
		return false
	}
	
}

class AldeaAmurallada inherits Aldea{
	var property vikinosNecesarios
	
	
	override method estaAmurallada(){
		return true
	}
}

class Iglesia{
	var property cantCrucifijos
	
}



class CastaSocial{
	
	
	method aceptadoParaExpedicion(vikingo){
		return true
	}
	
	method castaSuperior(vikingo)
	
	
}


object jarl inherits CastaSocial{
	
	override method aceptadoParaExpedicion(vikingo){
		return !vikingo.poseeArmas()
	}
	
	override method castaSuperior(vikingo){
		return karl
	}
} 

object karl inherits CastaSocial{
	
	override method castaSuperior(vikingo){
		return thrall
	}
}

object thrall inherits CastaSocial{
	
	override method castaSuperior(vikingo){
		throw new DomainException(message = "La casta noble no puede escalar")
	}
	
}

