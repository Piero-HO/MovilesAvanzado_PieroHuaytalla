// Piero Huaytalla
import Foundation

enum Linea: String {
    case l1 = "Línea 1", l2 = "Línea 2", l3 = "Línea 3"
    case l4 = "Línea 4", met = "Metropolitano"
}

enum Estado: String {
    case operativa = "Operativa"
    case construccion = "En construcción"
    case proyectada = "Proyectada"
}

struct Conexion {
    let destino: String
    let linea: Linea
    let estado: Estado
    let detalle: String
}

struct Estacion {
    let nombre: String
    let lineas: [Linea]
    let estado: Estado
    let ascensor: Bool
    let accesible: Bool
    var conexiones: [Conexion] = []
}

struct Destino {
    let nombre: String
    let estacion: String
    let detalle: String
}

func normalizar(_ texto: String) -> String {
    texto
        .folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: Locale(identifier: "es_PE")
        )
        .lowercased()
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

var estaciones: [String: Estacion] = [:]

func agregarEstacion(
    _ nombre: String,
    _ lineas: [Linea],
    _ estado: Estado,
    _ ascensor: Bool = true
) {
    estaciones[nombre] = Estacion(
        nombre: nombre,
        lineas: lineas,
        estado: estado,
        ascensor: ascensor,
        accesible: true
    )
}

func conectar(
    _ origen: String,
    _ destino: String,
    _ linea: Linea,
    _ estado: Estado,
    _ detalle: String
) {
    guard var estacion = estaciones[origen] else { return }

    estacion.conexiones.append(
        Conexion(
            destino: destino,
            linea: linea,
            estado: estado,
            detalle: detalle
        )
    )

    estaciones[origen] = estacion
}
