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
	
	method valorLuchaBase()= lucha
	
	method valorHechiceriaBase()= hechiceria
	
	method valorLucha()= equipo.sum({objeto=>objeto.valorLuchaDado(self)})+lucha
	
	method valorHechiceria()= equipo.sum({objeto=>objeto.valorHechiceriaDado(self)})+ hechiceria
	
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
	method bando()= bando
	
}

//Si es un return, se puede reemplazar por un igual
object espadaDelDestino{
	method valorLuchaDado(usuario)=3
	method valorHechiceriaDado(usuario)=0
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}

object libroDeHechizos{
	method valorLuchaDado(usuario)=0
	method valorHechiceriaDado(usuario)=usuario.valorHechiceriaBase()
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}

object collarDivino{
	method valorLuchaDado(usuario)=1
	method valorHechiceriaDado(usuario)=1
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
}

object espejoFantastico{
	//CORRECCION: La sumatoria es algo que se necesita como valor temporal. Entonces está mal que sea un atributo del objeto.
	//CORRECCION: Los atributos son cosas que el objeto debe acordarse a lo largo del tiempo.
	//CORRECCION: Ademas, cuando se actualiza? 
//var sumatoria=[]
	
	
	//CORRECCION: Hay un doble checkeo de lo mismo. El equipamiento vacio se checkea ademas de aca en los metodos valorLuchaDado y valorHechiceriaDado
	//CORRECCION: Correccion: Además la estrategia es rebuscada y no anda. El find es útil cuando la condicion solo depende del elemento que se está evaluando. Cuando tenes problemas como max y min que
	//CORRECCION: el objeto buscado no depende de cada elemento individualmente, si no de todos los objetos de la coleccion (para saber si un obejto es maximo hay que evaluar todos los elementos, no solo el actual)
	//CORRECCION: no conviene usar un find. En este caso conviene usar el mensaje max(transformer) o una combinacion de map(transformer) y max().
	//CORRECCION: Previamente, podrías haber filtrado la coleccion con un filter para remover self 
//method elMejor(usuario)=if(!self.equipamiento(usuario).isEmpty()){self.equipamiento(usuario).find({artefacto=>!(artefacto==self) and self.elMasAlto()==artefacto.valorLuchaDado()+artefacto.valorHechiceriaDado()})}
	
	method mejorObjeto(usuario){
		return 
	}
	method equipamiento(usuario){
		return usuario.equipamiento()
	}

	
	method maximoPoder(usuario){
		/*var sumatoria=[]
		if(usuario.equipo().isEmpty()){return sumatoria.add(0)}
		else{
		usuario.equipo().forEach({obj=>sumatoria.add(obj.valorLuchaDado()+obj.valorHechiceriaDado())})
		return sumatoria
		*/
		return usuario.equipo().max({equip=>equip.totalPoder()})
		
	}
	/*method elMasAlto(usuario){
		return self.maximoPoder(usuario).max()
	}
	* 
	*/
	
	//CORRECCION: Estos mensajes no son los polimórficos. El capo se manda como parametro. Si lo hubieran testeado se hubieran dado cuenta.
	//CORRECCION: hay que reescribir estos métodos recibiendo el capo por parámetro. Evitar las variables de instancia que se pueden calcular.
	method valorLuchaDado(usuario){
		return self.maximoPoder(usuario).valorLuchaDado(usuario)
	}
	method valorHechiceriaDado(usuario){
		return self.maximoPoder(usuario).valorLuchaDado(usuario)
	}
	
	
}

object cofrecitoDeOro{
	method efecto(capo){
		//CORRECCION: NO anda, hay que pasar el parametro
		capo.bando().ganarOro(100)
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
		reservaDeMateriales= reservaDeMateriales+_numero
	}
}

object armadura{
	var property refuerzo = noReforzar
	
	method valorLuchaDado(_capo) = 2 + refuerzo.valorLuchaDado(_capo)
	method totalPoder(usuario)=self.valorLuchaDado(usuario)+self.valorHechiceriaDado(usuario)
	method valorHechiceriaDado(_capo) = 0 + refuerzo.valorHechiceriaDado(_capo)
	
	method reforzar(_refuerzo){
		refuerzo = _refuerzo
	}
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