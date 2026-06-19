/*Profesionales*/
class Profesional {
  const property universidadDondeEstudio 
}

class ProfesionalDeUnaUniversidad inherits Profesional{ 
  const property provinciasDondeTrabaja 
  const property honorarios = universidadDondeEstudio.honorariosRecomendados()

  method cantidadDeProvinciasDondeTrabaja() = 1
}

class ProfesionalDelLitoral inherits Profesional{
  const property provinciasDondeTrabaja = []
  const property honorarios = 3000

  method añadirProvincia(provincia){
    provinciasDondeTrabaja.add(provincia)
  }

  method quitarProvincia(provincia){
    provinciasDondeTrabaja.remove(provincia)
  }

  method cantidadDeProvinciasDondeTrabaja() = provinciasDondeTrabaja.size()
}

class ProfesionalLibre inherits Profesional{
  var property provinciasDondeTrabaja = []
  const property honorarios

  method añadirProvincia(provincia){
    provinciasDondeTrabaja.add(provincia)
  }

  method quitarProvincia(provincia){
    provinciasDondeTrabaja.remove(provincia)
  }

  method cantidadDeProvinciasDondeTrabaja() = provinciasDondeTrabaja.size()
}


/*Universidad*/
class Universidad {
  const property provincia
  const property honorariosRecomendados
}


/*Empresa*/
class Empresa {
  const profesionales = []
  const property honorarioReferencia

  method contratarProfesional(profesional){
    profesionales.add(profesional)
  }

  method despedirProfesional(profesional){
    profesionales.remove(profesional)
  }

  method despedirATodosLosProfesionales(){
    profesionales.clear()
  }
  
  method cuantosProfesionalesEstudiaronEn(unaUniversidad) = profesionales.count({p => p.universidadDondeEstudio() == unaUniversidad})
  method profesionalesCaros() = profesionales.filter({p => p.honorarios() > self.honorarioReferencia()}).asSet()
  method universidadesFormadoras() = profesionales.map({p => p.universidadDondeEstudio()}).asSet()
  method profesionalMasBarato() = profesionales.min({p => p.honorarios()})
  method esDeGenteAcotada() = profesionales.all({p => p.cantidadDeProvinciasDondeTrabaja() <= 3})

  method puedeSatisfacerAl(unSolicitante, unProfesional) = unSolicitante.puedeSerAtendidoPorProfesionalDeLaEmpresa(unProfesional)
  method puedeSerAtendidoPorProfesionalDeLaEmpresa(unProfesional) = profesionales.constains(unProfesional)
}


/*Provincia*/
class Provincia {
}


/* Solicitantes */

class Solicitante {
}

class Persona inherits Solicitante {
  const property provinciaDondeVive 
  method puedeSerAtendidoPor(unProfesional) = self.provinciaDondeVive() == unProfesional.provinciasDondeTrabaja() || unProfesional.provinciasDondeTrabaja().contains(self.provinciaDondeVive())
}

class Institucion inherits Solicitante{
  const property universidadesReconocidas = []

  method puedeSerAtendidoPor(unProfesional) = universidadesReconocidas.contains(unProfesional.provinciasDondeTrabaja()) 
}

class Club inherits Solicitante{
  const property provinciasDondeEsta = []

  method puedeSerAtendidoPor(unProfesional) = provinciasDondeEsta.contains(unProfesional.provinciasDondeTrabaja())
}