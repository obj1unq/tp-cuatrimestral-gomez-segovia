//CORRECCION: Nota Entrega 1: Regular.
//CORRECCION: La entrega está inmadura: test que no anda y muchas cosas sin test. Cosas que si estuvieran testeadas no andarían
//CORRECCION: Hay muchos errores conceptuales en la parte del espejo. El resto está bien

// TODO GRAVE: Sigue habiendo tests rojos!
// TODO No puede estar todo el TP en un archivo.
class Capo{
	// TODO Hay que tener cuidado con la nomenclatura, la palabra equipo no aparece 
	// en la descripción del dominio, la inventaron ustedes. Salvo que haya una muy
	// buena justificación, debemos evitar esto. 
	var property equipo= #{}
	var lucha=3
	var hechiceria=1
	var bando
	var property posicion = game.at(1, 1)
	var property estaVivo= true
	var property oculto=false
	
	// TODO No dejar código comentado!
	//method posicion() = game.at(1, 1)
	
	method darTodoEquipo(capo){
		capo.equipo().addAll(self.equipo())
	}
	method estoyMuerto(){
		estaVivo=false
	}
	method enfrentamiento(capo){
		if(capo.valorLucha()+capo.valorHechiceria()>self.valorLucha()+self.valorHechiceria()){
			self.estoyMuerto()
		}
		else{
			estaVivo=true
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
	
	// TODO Nombres inventados
	method entrenarMente(_numero){
		hechiceria+=_numero
	}
	// TODO Nombres inventados
	method entrenarCuerpo(_numero){
		lucha+=_numero
	}
	// TODO Nombres inventados
	method equipar(objeto){
		equipo.add(objeto)
	}
	method encontrar(objeto){
		objeto.efecto(self)
	}
	method bando()= bando
	
	// TODO Imagino que esto se relaciona con la neblina, sin embargo la implementación es incorrecta
	// porque no permite relacionar una neblina con los elementos que oculta.
	method ocultar(){ oculto=true }
	
	method imagen() = "jugador.png"
	
}



object espadaDelDestino{
	var property oculto=false
	method efecto(_capo){_capo.equipar(self)}
	// TODO ¿Por qué "dado"?
	method valorLuchaDado(usuario)=3
	method valorHechiceriaDado(usuario)=0
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
	method ocultar(){ oculto=true }
}

object libroDeHechizos{
	var property oculto=false
	method efecto(_capo){_capo.equipar(self)}
	method valorLuchaDado(usuario)=0
	method valorHechiceriaDado(usuario)=usuario.valorHechiceriaBase()
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
	method ocultar(){ oculto=true }
}

object collarDivino{
	var property oculto=false
	method efecto(_capo){_capo.equipar(self)}
	method valorLuchaDado(usuario)=1
	method valorHechiceriaDado(usuario)=1
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
	method ocultar(){ oculto=true }
}

object espejoFantastico{

	var property oculto=false
	var capoQueLaPosee
	var lucha
	var hechiceria
	
	method artefactosPosibles(){
		return capoQueLaPosee.equipo().filter({artefacto=>!artefacto==self})
	}
	method mejorObjeto(){
		return(self.artefactosPosibles().max({artefacto=>artefacto.totalPoder(capoQueLaPosee)}))
	}
	method capoSinArtefactos(){
		return self.artefactosPosibles().isEmpty()
	}
	method efectoEspejo(){
		if(self.capoSinArtefactos()){
			lucha=0
			hechiceria=0
		}
		else{
			lucha=self.mejorObjeto().valorLuchaDado(capoQueLaPosee)
			hechiceria=self.mejorObjeto().valorHechiceriaDado(capoQueLaPosee)
		}
	}
		
		method duenho(capo){
			capoQueLaPosee=capo
		}
		method valorLuchaDado(_capo) = lucha
		method valorHechiceriaDado(_capo) = hechiceria
	method efecto(_capo){_capo.equipar(self) self.efectoEspejo()}
	method ocultar(){ oculto=true }
}

class CofrecitoDeOro{
	var property valor=100
	var property oculto=false
	method efecto(capo){
		capo.bando().ganarOro(valor)
	}
	method ocultar(){ oculto=true }
}
class CumuloDeCarbon{
	var property valor=50
	var property oculto=false
	method efecto(capo){
		capo.bando().ganarRecursos(valor)
	}
	method ocultar(){ oculto=true }
}

class ViejoSabio{
	var valorLuchaDado=ayudanteDelSabio.valorDeLucha()
	var property oculto=false
	var valorHechiceriaDado=1
	
	method efecto(capo){
		capo.entrenarMente(valorHechiceriaDado)
		capo.entrenarCuerpo(valorLuchaDado)
	}
	method ocultar(){ oculto=true }
	method imagen() = "pepona.png"
}

object ayudanteDelSabio {

 var property valorDeLucha = 1
 var property oculto=false
 method ocultar(){ oculto=true }

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
	var property oculto=false
	
	method refuerzo(_refuerzo){refuerzo=_refuerzo}
	method ocultar(){ oculto=true }
	method efecto(_capo){_capo.equipar(self)}
	method valorLuchaDado(_capo) = valorLuchaBase + refuerzo.valorLuchaDado(_capo)
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
	method valorHechiceriaDado(_capo) = valorHechiceriaBase + refuerzo.valorHechiceriaDado(_capo)
	method imagen() = "pepitaCanchera.png"
}	

object cotaDeMalla{
	method valorLuchaDado(_capo) = 1
	method valorHechiceriaDado(_capo) = 0
	// TODO ¿Cuándo se usa este método?
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}
	
object bendicion{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = 1
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}
	
object hechizo{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = if (_capo.valorHechiceriaBase()>3) 2 else 0
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}
	
object noReforzar{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = 0
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}
object artefactoNulo{
	method valorLuchaDado(_capo) = 0
	method valorHechiceriaDado(_capo) = 0
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}

class Neblina{
	var interior=#{}
	
	method ocultar(_objeto){
		interior.add(_objeto)
		
		// TODO ¿Para qué sirve esto?
		_objeto.ocultar() 
	}
	method efecto(_capo){_capo.equipo().addAll(interior)}
}





