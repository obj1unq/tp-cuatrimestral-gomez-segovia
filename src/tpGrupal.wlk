//CORRECCION: Nota Entrega 1: Regular.
//CORRECCION: La entrega está inmadura: test que no anda y muchas cosas sin test. Cosas que si estuvieran testeadas no andarían
//CORRECCION: Hay muchos errores conceptuales en la parte del espejo. El resto está bien

class Capo{
	var property equipo= #{}
	var lucha=3
	var hechiceria=1
	var bando
	var property estaVivo= true
	var property oculto=false
	//method equipo(){
	//	return equipo
	//}
	method darTodoEquipo(capo){
		capo.equipo().addAll(self.equipo())
	}
	method estoyMuerto(){
		estaVivo=false
	}
	method enfrentamiento(capo){
		if(capo.valorLucha()+capo.valorHechiceria()>self.valorLucha()+self.valorHechiceria()){
			estaVivo=false 
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
	method ocultar(){ oculto=true }
	
}

//Si es un return, se puede reemplazar por un igual
object espadaDelDestino{
	var property oculto=false
	method efecto(_capo){_capo.equipar(self)}
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
	//CORRECCION: Hay un doble checkeo de lo mismo. El equipamiento vacio se checkea ademas de aca en los metodos valorLuchaDado y valorHechiceriaDado
	//CORRECCION: Correccion: Además la estrategia es rebuscada y no anda. El find es útil cuando la condicion solo depende del elemento que se está evaluando. Cuando tenes problemas como max y min que
	//CORRECCION: el objeto buscado no depende de cada elemento individualmente, si no de todos los objetos de la coleccion (para saber si un obejto es maximo hay que evaluar todos los elementos, no solo el actual)
	//CORRECCION: no conviene usar un find. En este caso conviene usar el mensaje max(transformer) o una combinacion de map(transformer) y max().
	//CORRECCION: Previamente, podrías haber filtrado la coleccion con un filter para remover self 
	method mejorObjeto(usuario){
		var equipo= usuario.equipo().filter({artefacto=>!artefacto==self})
		
		return if(!equipo.isEmpty()){return equipo.max({equip=>equip.totalPoder()})} else {return artefactoNulo}
		
	}

	method valorLuchaDado(usuario){
		return self.mejorObjeto(usuario).valorLuchaDado(usuario)
	}
	method valorHechiceriaDado(usuario){
		return self.mejorObjeto(usuario).valorLuchaDado(usuario)
	}
	method efecto(_capo){_capo.equipar(self)}
	method ocultar(){ oculto=true }
}

class CofrecitoDeOro{
	var property valor=100
	var property oculto=false
	method efecto(capo){
		//CORRECCION: NO anda, hay que pasar el parametro
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
	method reservadeMateriales(){
		return reservaDeMateriales
	}
	method ganarOro(_numero){
		tesoro= tesoro+_numero
	}
	//CORRECCION: si le paso un parametro, supongo que quiero sumar ese parámetro y no hardcodear el 50.
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
}	

object cotaDeMalla{
	method valorLuchaDado(_capo) = 1
	method valorHechiceriaDado(_capo) = 0
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
		_objeto.ocultar() 
	}
	method efecto(_capo){_capo.equipo().addAll(interior)}
}





