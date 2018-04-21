//CORRECCION: Nota Entrega 1: Regular.
//CORRECCION: La entrega está inmadura: test que no anda y muchas cosas sin test. Cosas que si estuvieran testeadas no andarían
//CORRECCION: Hay muchos errores conceptuales en la parte del espejo. El resto está bien

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
	//CORRECCION: acá está el motivo por el cual el test no anda. el mensaje
	//CORRECCION: se debe llamar valorHechiceriaBase() (en minuscula)
	method valorHechiceriaDado(usuario)=usuario.ValorHechiceriaBase()
}

object collarDivino{
	method valorLuchaDado(usuario)=1
	method valorHechiceriaDado(usuario)=1
}

object espejoFantastico{
	//CORRECCION: La sumatoria es algo que se necesita como valor temporal. Entonces está mal que sea un atributo del objeto.
	//CORRECCION: Los atributos son cosas que el objeto debe acordarse a lo largo del tiempo.
	//CORRECCION: Ademas, cuando se actualiza? 
	var sumatoria=[]
	//CORRECCION: Esta variable podría no estar mal, pero como ustedes definieron que el capo que usa el artefacto se envía por parámetro cuando quiere obtener
	//CORRECCION: el valor de lucha dado y el valor de hechicería dado, está mal que se lo acuerde en un atributo. 
	//CORRECCION:  O los artefactos se acuerdan su dueño o lo reciben por parámetro cuando es usado. Ambas a la vez está mal
	var property usuario
	//CORRECCION: Esto es algo que se puede calcular a partir del capo, está mal que se lo acuerde el objeto.
	var equipamiento
	
	//CORRECCION: Hay un doble checkeo de lo mismo. El equipamiento vacio se checkea ademas de aca en los metodos valorLuchaDado y valorHechiceriaDado
	//CORRECCION: Correccion: Además la estrategia es rebuscada y no anda. El find es útil cuando la condicion solo depende del elemento que se está evaluando. Cuando tenes problemas como max y min que
	//CORRECCION: el objeto buscado no depende de cada elemento individualmente, si no de todos los objetos de la coleccion (para saber si un obejto es maximo hay que evaluar todos los elementos, no solo el actual)
	//CORRECCION: no conviene usar un find. En este caso conviene usar el mensaje max(transformer) o una combinacion de map(transformer) y max().
	//CORRECCION: Previamente, podrías haber filtrado la coleccion con un filter para remover self 
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
	
	//CORRECCION: Estos mensajes no son los polimórficos. El capo se manda como parametro. Si lo hubieran testeado se hubieran dado cuenta.
	//CORRECCION: hay que reescribir estos métodos recibiendo el capo por parámetro. Evitar las variables de instancia que se pueden calcular.
	method valorLuchaDado()=if(!equipamiento.isEmpty()) self.elMejor().valorLuchaDado() else 0
	method valorHechiceriaDado()=if(!equipamiento.isEmpty())self.elMejor().valorHechiceriaDado() else 0
	
	
}

object cofrecitoDeOro{
	method efecto(capo){
		//CORRECCION: NO anda, hay que pasar el parametro
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
	//CORRECCION: si le paso un parametro, supongo que quiero sumar ese parámetro y no hardcodear el 50.
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