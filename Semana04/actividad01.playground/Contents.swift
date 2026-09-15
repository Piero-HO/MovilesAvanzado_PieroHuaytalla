import Foundation

// Actividad propuesta 01: facturación de cursos libres de Tecsup.

struct Alumno {
    let nombre: String
    let dni: String
    let esAlumnoTecsup: Bool
}

struct Curso {
    let nombre: String
    let precio: Double
    let cantidad: Int

    var importe: Double {
        precio * Double(cantidad)
    }
}

struct FacturaCursos {
    let alumno: Alumno
    let cursos: [Curso]

    private let porcentajeIGV = 0.18
    private let porcentajeDescuentoCantidad = 0.10
    private let descuentoAlumnoTecsup = 400.00

    var cantidadCursos: Int {
        cursos.reduce(0) { $0 + $1.cantidad }
    }

    var subtotal: Double {
        cursos.reduce(0) { $0 + $1.importe }
    }

    var igv: Double {
        subtotal * porcentajeIGV
    }

    var totalConIGV: Double {
        subtotal + igv
    }

    var cumpleCantidadMinima: Bool {
        cantidadCursos >= 3
    }

    var descuentoPorCantidad: Double {
        cumpleCantidadMinima ? totalConIGV * porcentajeDescuentoCantidad : 0
    }

    var descuentoEspecialTecsup: Double {
        cumpleCantidadMinima && alumno.esAlumnoTecsup ? descuentoAlumnoTecsup : 0
    }

    var totalFinal: Double {
        max(0, totalConIGV - descuentoPorCantidad - descuentoEspecialTecsup)
    }
}
