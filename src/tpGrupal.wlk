//Se hicieron correcciones esteticas y estructurales el funcionamiento sigue siendo el mismo
class Capo {

	var property equipo = #{}
	var lucha = 3
	var hechiceria = 1
	var bando
	var property posicion = game.at(1, 1)
	var property estaVivo = true

	method darTodoEquipo(capo) {
		capo.equipo().addAll(self.equipo())
		self.equipo().clear()
	}

	method estoyMuerto() {
		estaVivo = false
		game.removeVisual(self)
	}

	method estoyVivo() {
		estaVivo = true
	}

	method enfrentamiento(capo) {
		if (capo.valorLucha() + capo.valorHechiceria() > self.valorLucha() + self.valorHechiceria()) {
			self.estoyMuerto()
		} else {
			capo.estoyMuerto()
		}
	}

	method efecto(capo) {
		if (self.bando() == capo.bando()) {
			self.darTodoEquipo(capo)
		} else {
			self.enfrentamiento(capo)
		}
	}

	method valorLuchaBase() = lucha

	method valorHechiceriaBase() = hechiceria

	method valorLucha() = equipo.sum({ objeto => objeto.valorLucha(self) }) + lucha

	method valorHechiceria() = equipo.sum({ objeto => objeto.valorHechiceria(self) }) + hechiceria

	method aumentarPuntosHechiceria(_numero) {
		hechiceria += _numero
	}

	method aumentarPuntosLucha(_numero) {
		lucha += _numero
	}

	method equipar(objeto) {
		equipo.add(objeto)
	}

	method encontrar(objeto) {
		objeto.efecto(self)
	}

	method bando() = bando

	method imagen() = "jugador.png"

}

class Artefacto {

	method efecto(_capo) {
		_capo.equipar(self)
	}

	method valorLucha(usuario)

	method valorHechiceria(usuario)

	method totalPoder(usuario) = self.valorLucha(usuario) + self.valorHechiceria(usuario)

}

class EspadaDelDestino inherits Artefacto {

	override method valorLucha(usuario) = 3

	override method valorHechiceria(usuario) = 0

}

class LibroDeHechizos inherits Artefacto {

	override method valorLucha(usuario) = 0

	override method valorHechiceria(usuario) = usuario.valorHechiceriaBase()

}

class CollarDivino inherits Artefacto {

	override method valorLucha(usuario) = 1

	override method valorHechiceria(usuario) = 1

}

class EspejoFantastico inherits Artefacto {

	method artefactosPosibles(capo) {
		return capo.equipo().filter({ artefacto => artefacto != self })
	}

	method mejorObjeto(capo) {
		return (self.artefactosPosibles(capo).max({ artefacto => artefacto.totalPoder(capo) }))
	}

	method capoSinArtefactos(capo) {
		return self.artefactosPosibles(capo).isEmpty()
	}

	override method valorLucha(_capo) {
		return (if (self.capoSinArtefactos(_capo)) {
			0
		} else {
			self.mejorObjeto(_capo).valorLucha(_capo)
		} )
	}

	override method valorHechiceria(_capo) {
		return (
		if (self.capoSinArtefactos(_capo)) {
			0
		} else {
			self.mejorObjeto(_capo).valorHechiceria(_capo)
		} )
	}



}

class CofrecitoDeOro {

	var property valor = 100

	method efecto(capo) {
		capo.bando().ganarOro(valor)
	}

}

class CumuloDeCarbon {

	var property valor = 50

	method efecto(capo) {
		capo.bando().ganarRecursos(valor)
	}

}

class ViejoSabio {

	var valorLucha = ayudanteDelSabio.valorDeLucha()
	var valorHechiceria = 1

	method efecto(capo) {
		capo.aumentarPuntosHechiceria(valorHechiceria)
		capo.aumentarPuntosLucha(valorLucha)
	}

	method imagen() = "pepona.png"

}

object ayudanteDelSabio {

	var property valorDeLucha = 1

}

class Bandos {

	var tesoro = 0
	var reservaDeMateriales = 0

	method tesoro() {
		return tesoro
	}

	method reservaDeMateriales() {
		return reservaDeMateriales
	}

	method ganarOro(_numero) {
		tesoro = tesoro + _numero
	}

	method ganarRecursos(_numero) {
		reservaDeMateriales = reservaDeMateriales + _numero
	}

}

class Armadura {

	var refuerzo = noReforzar
	var valorLuchaBase = 2
	var valorHechiceriaBase = 0

	method refuerzo(_refuerzo) {
		refuerzo = _refuerzo
	}

	method efecto(_capo) {
		_capo.equipar(self)
	}

	method valorLucha(_capo) = valorLuchaBase + refuerzo.valorLucha(_capo)

	method totalPoder(usuario) = self.valorLucha(usuario) + self.valorHechiceria(usuario)

	method valorHechiceria(_capo) = valorHechiceriaBase + refuerzo.valorHechiceria(_capo)

	method imagen() = "pepitaCanchera.png"

}

object cotaDeMalla {

	method valorLucha(_capo) = 1

	method valorHechiceria(_capo) = 0

}

object bendicion {

	method valorLucha(_capo) = 0

	method valorHechiceria(_capo) = 1

}

object hechizo {

	method valorLucha(_capo) = 0

	method valorHechiceria(_capo) = if (_capo.valorHechiceriaBase() > 3) 2 else 0

}

object noReforzar {

	method valorLucha(_capo) = 0

	method valorHechiceria(_capo) = 0

}

object artefactoNulo {

	method valorLucha(_capo) = 0

	method valorHechiceria(_capo) = 0

}

class Neblina {

	var interior = #{}

	method ocultar(_objeto) {
		interior.add(_objeto)
	}

	method efecto(_capo) {
		_capo.equipo().addAll(interior)
	}

}

