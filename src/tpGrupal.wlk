//Se hicieron correcciones esteticas y estructurales el funcionamiento sigue siendo el mismo

class Capo{
	var property equipo= #{}
	var lucha=3
	var hechiceria=1
	var bando
	var property posicion = game.at(1, 1)
	var property estaVivo= true

	
	method darTodoEquipo(capo){
		capo.equipo().addAll(self.equipo())
		self.equipo().clear()
	}
	method estoyMuerto(){
		estaVivo=false
		game.removeVisual(self)
	}
	method estoyVivo(){
		estaVivo=true
	}
	method enfrentamiento(capo){
		if(capo.valorLucha()+capo.valorHechiceria()>self.valorLucha()+self.valorHechiceria()){
			self.estoyMuerto()
		}
		else{
			capo.estoyMuerto()
		}
	}
	
	method efecto(capo){
		if(self.bando()==capo.bando()){
			self.darTodoEquipo(capo)
		}
		else{
			self.enfrentamiento(capo)
		}
	}
	
	method valorLuchaBase()= lucha
	
	method valorHechiceriaBase()= hechiceria
	 
	method valorLucha()= equipo.sum({objeto=>objeto.valorLuchaDado(self)})+lucha
	
	method valorHechiceria()= equipo.sum({objeto=>objeto.valorHechiceriaDado(self)})+ hechiceria
	

	method entrenarMente(_numero){
		hechiceria+=_numero
	}
	
	method entrenarCuerpo(_numero){
		lucha+=_numero
	}

	method equipar(objeto){
		equipo.add(objeto)
	}
	method encontrar(objeto){
		objeto.efecto(self)
	}
	method bando()= bando
	

	
	
	method imagen() = "jugador.png"
	
}
class Artefacto{
	method efecto(_capo){_capo.equipar(self)}
	method valorLuchaDado(usuario)
	method valorHechiceriaDado(usuario)
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
	
}



class EspadaDelDestino inherits Artefacto{
	

	override method valorLuchaDado(usuario)=3
	override method valorHechiceriaDado(usuario)=0
	
}

class LibroDeHechizos inherits Artefacto {
	
	
	override method valorLuchaDado(usuario)=0
	override method valorHechiceriaDado(usuario)=usuario.valorHechiceriaBase()

}

class CollarDivino inherits Artefacto{
	
	
	override method valorLuchaDado(usuario)=1
	override method valorHechiceriaDado(usuario)=1
	
}

class EspejoFantastico inherits Artefacto{


	
	method artefactosPosibles(capo){
		return capo.equipo().filter({artefacto=>!artefacto==self})
	}
	method mejorObjeto(capo){
		return(self.artefactosPosibles(capo).max({artefacto=>artefacto.totalPoder(capo)}))
	}
	method capoSinArtefactos(capo){
		return self.artefactosPosibles(capo).isEmpty()
	}
	
		
		override method valorLuchaDado(_capo){
			return(if(self.capoSinArtefactos(_capo)){
			0
			
			
		}
		else{
			self.mejorObjeto(_capo).valorLuchaDado(_capo)
			
		})
		}
		
		
		override method valorHechiceriaDado(_capo){
			return(
		if(self.capoSinArtefactos(_capo)){
			0
			
		}
		else{
			
			self.mejorObjeto(_capo).valorHechiceriaDado(_capo)
			
		})
		}
	    override method efecto(_capo){_capo.equipar(self)}
	
}

class CofrecitoDeOro{
	var property valor=100
	
	method efecto(capo){
		capo.bando().ganarOro(valor)
	}
	
}
class CumuloDeCarbon{
	var property valor=50

	method efecto(capo){
		capo.bando().ganarRecursos(valor)
	}

}

class ViejoSabio{
	var valorLuchaDado=ayudanteDelSabio.valorDeLucha()

	var valorHechiceriaDado=1
	
	method efecto(capo){
		capo.entrenarMente(valorHechiceriaDado)
		capo.entrenarCuerpo(valorLuchaDado)
	}

	method imagen() = "pepona.png"
}

object ayudanteDelSabio {

 var property valorDeLucha = 1

 

}

class Bandos{
	var tesoro=0
	var reservaDeMateriales=0
	method tesoro(){
		return tesoro
	}
	method reservaDeMateriales(){
		return reservaDeMateriales
	}
	method ganarOro(_numero){
		tesoro= tesoro+_numero
	}

	method ganarRecursos(_numero){
		reservaDeMateriales= reservaDeMateriales+_numero
	}
}

class Armadura{
	var refuerzo = noReforzar
	var valorLuchaBase=2
	var valorHechiceriaBase=0

	
	method refuerzo(_refuerzo){refuerzo=_refuerzo}

	method efecto(_capo){_capo.equipar(self)}
	method valorLuchaDado(_capo) = valorLuchaBase + refuerzo.valorLuchaDado(_capo)
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
	method valorHechiceriaDado(_capo) = valorHechiceriaBase + refuerzo.valorHechiceriaDado(_capo)
	method imagen() = "pepitaCanchera.png"
}	

object cotaDeMalla{
	method valorLuchaDado(_capo) = 1
	method valorHechiceriaDado(_capo) = 0
	
	
}
	
object bendicion{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = 1
	
}
	
object hechizo{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = if (_capo.valorHechiceriaBase()>3) 2 else 0

}
	
object noReforzar{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = 0
	
}
object artefactoNulo{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = 0
	
}

class Neblina{
	var interior=#{}
	
	method ocultar(_objeto){
		interior.add(_objeto)
		
	
		
	}
	method efecto(_capo){_capo.equipo().addAll(interior)}
}





