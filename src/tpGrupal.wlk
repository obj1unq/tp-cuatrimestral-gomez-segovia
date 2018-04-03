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
		hechiceria=hechiceria + 1
	}
	method entrenarCuerpo(){
		lucha=lucha + 1
	}
	method equipar(objeto){
		equipo.add(objeto)
	}
}

object espadaDelDestino{
	method valorLuchaDado(usuario){
		return 3
	}
	method valorHechiceriaDado(usuario){
		return 0
	}
}

object libroDeHechizos{
	method valorLuchaDado(usuario){
		return 0
	}
	method valorHechiceriaDado(usuario){
		return usuario.hechiceriaBase()
	}
}

object collarDivino{
	method valorLuchaDado(){
		return 1
	}
	method valorHechiceriaDado(){
		return 1
	}
}



