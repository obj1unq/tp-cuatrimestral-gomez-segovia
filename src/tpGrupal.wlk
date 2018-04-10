object capoRolando{
    //var equipo=[]
	var property equipo= []
	var lucha=3
	var hechiceria=1
	var bando=bandoDelSur
	//method equipo(){
	//	return equipo
	//}
	
	method valorLuchaBase(){
		return lucha
	}
	method valorHechiceriaBase(){
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
	method encontrar(objeto){
		objeto.efecto(self)
	}
	method bando(){
		return bando
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
	var sumatoria=[]
	var property usuario
	var equipamiento
	
	method elMejor()=if(!self.equipamiento().isEmpty()){equipamiento.find({artefacto=>!(artefacto==self) and self.elMasAlto()==artefacto.valorLuchaDado()+artefacto.valorHechiceriaDado()})}
	
	method equipamiento(){
		return equipamiento
	}
	method quienLoPosee(capo){
		usuario=capo
	}
	method equipos(unCapo){
		equipamiento=unCapo.equipo()
	}
	
	method maximoPoder(){
		self.equipamiento().forEach({obj=>sumatoria.add(obj.valorLuchaDado()+obj.valorHechiceriaDado())})
	}
	method elMasAlto(){
		return sumatoria.max()
	}
	method valorLuchaDado()=if(!equipamiento.isEmpty()) self.elMejor().valorLuchaDado() else 0
	method valorHechiceriaDado()=if(!equipamiento.isEmpty())self.elMejor().valorHechiceriaDado() else 0
	
	
}

object cofrecitoDeOro{
	method efecto(capo){
		capo.bando().ganarOro()
	}
}
object cumuloDeCarbon{
	method efecto(capo){
		capo.bando().ganarRecursos(50)
	}
}

object viejoSabio{
	method efecto(capo){
		capo.entrenarMente()
		capo.entrenarCuerpo()
	}
}

object bandoDelSur{
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
	method ganarRecursos(_numero){
		reservaDeMateriales= reservaDeMateriales+50
	}
}

object armadura{
	var property refuerzo = noReforzar
	
	method valorLuchaDado(_capo) = 2 + refuerzo.valorLuchaDado(_capo)
	
	method valorHechiceriaDado(_capo) = 0 + refuerzo.valorHechiceriaDado(_capo)
	
	method reforzar(_refuerzo){
		refuerzo = _refuerzo
	}
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