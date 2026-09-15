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
