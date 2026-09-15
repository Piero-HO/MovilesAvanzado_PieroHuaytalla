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

    func mostrarFactura() {
        print("🎓 FACTURA DE CURSOS")
        print("Estudiante: \(alumno.nombre)")
        print("DNI: \(alumno.dni)")
        print("Alumno de Tecsup: \(alumno.esAlumnoTecsup ? "Sí ✅" : "No")")
        print(String(repeating: "-", count: 38))

        for curso in cursos {
            let detalle = "\(curso.nombre) x\(curso.cantidad)"
            print(String(format: "%-24@ - S/ %8.2f", detalle as NSString, curso.importe))
        }

        print(String(repeating: "-", count: 38))
        print(String(format: "Subtotal:                 S/ %8.2f", subtotal))
        print(String(format: "IGV (18%%):               S/ %8.2f", igv))
        print(String(format: "Total con IGV:            S/ %8.2f", totalConIGV))

        if cumpleCantidadMinima {
            print(String(format: "Descuento 10%% cantidad:  -S/ %8.2f ✅", descuentoPorCantidad))
        } else {
            print("Descuento 10% cantidad: no aplica")
        }

        if descuentoEspecialTecsup > 0 {
            print(String(format: "Descuento alumno Tecsup:  -S/ %8.2f ✅", descuentoEspecialTecsup))
        } else {
            print("Descuento alumno Tecsup: no aplica")
        }

        print(String(repeating: "-", count: 38))
        print(String(format: "💰 TOTAL FINAL A PAGAR:    S/ %8.2f", totalFinal))
    }
}

// Datos de prueba
let alumno = Alumno(
    nombre: "Juan León",
    dni: "78965412",
    esAlumnoTecsup: true
)

let cursosInscritos = [
    Curso(nombre: "Swift Avanzado", precio: 450.00, cantidad: 1),
    Curso(nombre: "IA con Python", precio: 650.00, cantidad: 2),
    Curso(nombre: "Diseño UX/UI", precio: 500.00, cantidad: 1)
]

let factura = FacturaCursos(alumno: alumno, cursos: cursosInscritos)
factura.mostrarFactura()
