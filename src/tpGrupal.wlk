class Ocultable{
	var property oculto=false
	method ocultar(){ oculto=true }
}

class Capo inherits Ocultable{
	var property nombreCapo
	var property imagen = "jugador.png"
	var property equipo= #{}
	var lucha=3
	var hechiceria=1
	var property bando
	var property posicion = game.at(1, 1)
	var property estaVivo= true
	
	method darTodoEquipo(capo){
		capo.equipo().addAll(self.equipo())
		self.equipo().removeAll(self.equipo())
	}
	
	method estoyMuerto(){
		estaVivo=false
		game.removeVisual(self)
	}
	
	method enfrentamiento(capo){
		if((capo.valorLucha()+capo.valorHechiceria())>(self.valorLucha()+self.valorHechiceria())){
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
	
	method valorHechiceria()= equipo.sum({objeto=>objeto.valorHechiceriaDado(self)})+hechiceria
	
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
	
}

class Artefacto inherits Ocultable{
	var property nombreArtefacto
	var property imagen = "pepitaCanchera.png" //"item.png"
	method efecto(_capo){_capo.equipar(self)}
	method valorLuchaDado(usuario) = 0
	method valorHechiceriaDado(usuario) = 0
	method totalPoder(usuario) = self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}

class EspadaDelDestino inherits Artefacto{
	override method valorLuchaDado(usuario)=3
}

class LibroDeHechizos inherits Artefacto{
	override method valorHechiceriaDado(usuario)=usuario.valorHechiceriaBase()
}

class CollarDivino inherits Artefacto{
	override method valorLuchaDado(usuario)=1
	override method valorHechiceriaDado(usuario)=1
}

class Armadura inherits Artefacto{
	var property sinRefuerzo = new Artefacto()
	var property cotaDeMalla = new CotaDeMalla()
	var property bendicion = new Bendicion()
	var property hechizo = new Hechizo()
	var property refuerzo = sinRefuerzo
	method reforzar(_refuerzo){ refuerzo=_refuerzo }
	override method valorLuchaDado(_capo) = 2 + refuerzo.valorLuchaDado(_capo)
	override method valorHechiceriaDado(_capo) = 0 + refuerzo.valorHechiceriaDado(_capo)
}	

class CotaDeMalla inherits Artefacto{
	override method valorLuchaDado(_capo) = 1
}

class Bendicion inherits Artefacto{
	override method valorHechiceriaDado(_capo) = 1
}

class Hechizo inherits Artefacto{
	override method valorHechiceriaDado(_capo) = if (_capo.valorHechiceriaBase()>3) 2 else 0
}

class EspejoFantastico inherits Artefacto{

	method mejorObjeto(usuario){
		var artefactoNulo = new Artefacto()
		var equipo = usuario.equipo().add(artefactoNulo) //filter({ _artefacto => _artefacto == self})
		return if (equipo.remove(self).isEmpty()) artefactoNulo else equipo.max({equip=>equip.totalPoder()})	
	}
	
	override method valorLuchaDado(usuario){
		return self.mejorObjeto(usuario).valorLuchaDado(usuario)
	}
	
	override  method valorHechiceriaDado(usuario){
		return self.mejorObjeto(usuario).valorHechiceriaDado(usuario)
	}

}

class ViejoSabio inherits Ocultable{
	var property imagen = "pepona.png"
	var valorLuchaDado=ayudanteDelSabio.valorDeLucha()
	var valorHechiceriaDado=1
	
	method efecto(capo){
		capo.entrenarMente(valorHechiceriaDado)
		capo.entrenarCuerpo(valorLuchaDado)
	}
}

object ayudanteDelSabio inherits Ocultable{
	var property valorDeLucha = 1
}

class Bandos{
	var property tesoro=0
	var property reservaDeMateriales=0
	
	method ganarOro(_numero){
		tesoro+=_numero
	}
	method ganarRecursos(_numero){
		reservaDeMateriales+=_numero
	}
}


class CofrecitoDeOro inherits Ocultable{
	method efecto(capo){
		capo.bando().ganarOro(100)
	}
}

class CumuloDeCarbon inherits Ocultable{
	method efecto(capo){
		capo.bando().ganarRecursos(50)
	}
}

class Neblina{
	var property posicion
	var interior=#{}
	method ocultar(_objeto){
		interior.add(_objeto)
		_objeto.ocultar() 
	}
	method efecto(_capo){_capo.equipo().addAll(interior)}
}





