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
		return equipo.sum({objeto=>objeto.valorLuchaDado()})+lucha
	}
	method valorHechiceria(){
		return equipo.sum({objeto=>objeto.valorHechiceriaDado()})+ hechiceria
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


