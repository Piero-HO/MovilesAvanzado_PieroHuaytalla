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
func norm(_ s: String) -> String {
    s.folding(
        options: [.diacriticInsensitive, .caseInsensitive],
        locale: Locale(identifier: "es_PE")
    )
    .lowercased()
    .trimmingCharacters(in: .whitespacesAndNewlines)
}

func l2(_ s: String) -> String {
    "\(s) (L2)"
}

func l3(_ s: String) -> String {
    "\(s) (L3)"
}

func l4(_ s: String) -> String {
    "\(s) (L4)"
}

func met(_ s: String) -> String {
    "\(s) (Metropolitano)"
}

func siNo(_ b: Bool) -> String {
    b ? "Sí" : "No"
}

func datoAscensor(_ b: Bool?) -> String {
    b.map { $0 ? "Sí" : "No" } ?? "No verificado"
}

let totalLineasMetro = 5

let referenciaMetL1: [String: (paradero: String, detalle: String)] = [
    "Cabitos": (
        "Benavides",
        "Referencia aproximada por el eje Benavides/Higuereta; requiere transporte complementario."
    ),
    "Angamos": (
        "Angamos",
        "Referencia aproximada por la avenida Angamos; requiere transporte complementario."
    ),
    "La Cultura": (
        "Javier Prado",
        "Referencia aproximada por el corredor Javier Prado; requiere transporte complementario."
    ),
    "Grau": (
        "Central",
        "Integración prevista mediante la Vía Expresa Grau; todavía no es un intercambio directo operativo."
    )
]

let enlacesSuperficieL1Met = [
    ("Cabitos", met("Benavides")),
    ("Angamos", met("Angamos")),
    ("La Cultura", met("Javier Prado"))
]

let recomendacionClave: [String: String] = [
    l2("28 de Julio"):
        "Referencia temporal: Gamarra (Línea 1) mediante traslado peatonal propuesto; el intercambio definitivo L1-L2 será en 28 de Julio.",
    l2("Estación Central"):
        "Al culminar las obras, conecta directamente con Central del Metropolitano mediante una galería subterránea de ~180 m.",
    "Grau":
        "No es cruce directo. Como alternativa futura, Ositrán propuso Central (L2/Metropolitano) -> bus -> Grau (L1)."
]
