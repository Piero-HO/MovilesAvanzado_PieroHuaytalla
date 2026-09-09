// Piero Huaytalla
import Foundation

// METRO LIMA GO - Consola Swift
// Datos de red verificados a septiembre de 2026.
// Próximos servicios: SIMULADOS, no API real.

enum Linea: String {
    case l1 = "Línea 1"
    case l2 = "Línea 2"
    case l3 = "Línea 3"
    case l4 = "Línea 4"
    case met = "Metropolitano"
}

enum Estado: String {
    case operativa = "Operativa"
    case construccion = "En construcción"
    case proyectada = "Proyectada"
}

enum TipoConexion: String {
    case intercambio = "Intercambio"
    case metropolitano = "Conexión con Metropolitano"
}

struct Conexion {
    let tipo: TipoConexion
    let destino: String
    let estado: Estado
    let detalle: String
}

struct Estacion {
    let codigo: String
    let nombre: String
    let linea: Linea
    let estado: Estado
    let ascensor: Bool?
    let accesible: Bool
    let anio: Int?
    var conexiones: [Conexion] = []
    var nota: String = ""
}

struct Destino {
    let nombre: String
    let estacion: String
    let detalle: String
}

var estaciones: [String: Estacion] = [:]

func guardar(_ clave: String, _ e: Estacion) {
    estaciones[clave] = e
}
