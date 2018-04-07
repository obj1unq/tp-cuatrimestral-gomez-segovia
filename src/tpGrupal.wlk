object capoRolando{
    //var equipo=[]
	var property equipo= []
	var lucha=3
	var hechiceria=1
	
	//method equipo(){
	//	return equipo
	//}
	
	method valorLuchaBase(){
		return lucha
	}
	method ValorHechiceriaBase(){
		return hechiceria
	}
	method valorLucha(){
		return equipo.sum({objeto=>objeto.valorLuchaDado(self)})+lucha
	}
	method valorHechiceria(){
		return equipo.sum({objeto=>objeto.valorHechiceriaDado(self)})+ hechiceria
	}
	method entrenarMente(){
		hechiceria+=1
	}
	method entrenarCuerpo(){
		lucha+=1
	}
	method equipar(objeto){
		equipo.add(objeto)
	}
}

//Si es un return, se puede reemplazar por un igual
object espadaDelDestino{
	method valorLuchaDado(usuario)=3
	method valorHechiceriaDado(usuario)=0
}

object libroDeHechizos{
	method valorLuchaDado(usuario)=0
	method valorHechiceriaDado(usuario)=usuario.ValorHechiceriaBase()
}

object collarDivino{
	method valorLuchaDado(usuario)=1
	method valorHechiceriaDado(usuario)=1
}

object espejoFantastico{
	var usuario
	var equipamiento=usuario.equipo()
	var maxPoder
	var elMejor
	
	method quienLoPosee(capo){
		usuario=capo
	}
	
	
	method mejorArtefacto(){
		elMejor=equipamiento.findOrDefault({artefacto=>!(artefacto==self)and maxPoder==artefacto.valorLuchaDado()+artefacto.valorHechiceriaDado()})
	}
	//suma las caracteristicas de los objetos o artefactos 
	method prueba(){
		maxPoder=equipamiento.max({objeto=>objeto.valorLuchaDado()+objeto.valorHechiceriaDado()})
	}
}

