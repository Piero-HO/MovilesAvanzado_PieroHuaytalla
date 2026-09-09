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

let nombresL1 = [
    "Villa El Salvador",
    "Parque Industrial",
    "Pumacahua",
    "Villa María",
    "María Auxiliadora",
    "San Juan",
    "Atocongo",
    "Jorge Chávez",
    "Ayacucho",
    "Cabitos",
    "Angamos",
    "San Borja Sur",
    "La Cultura",
    "Arriola",
    "Gamarra",
    "Grau",
    "El Ángel",
    "Presbítero Maestro",
    "Caja de Agua",
    "Pirámide del Sol",
    "Los Jardines",
    "Los Postes",
    "San Carlos",
    "San Martín",
    "Santa Rosa",
    "Bayóvar"
]

let sinAscensor: Set<String> = [
    "Pumacahua",
    "Villa María",
    "María Auxiliadora",
    "San Borja Sur"
]

for (i, n) in nombresL1.enumerated() {
    var nota = "Estación operativa de Línea 1."

    if sinAscensor.contains(n) {
        nota += " Usa salvaescaleras para accesibilidad."
    }

    if n == "Grau" {
        nota += " Grau NO conecta directamente con Línea 2; el intercambio L1-L2 corresponde a 28 de Julio."
    }

    guardar(
        n,
        Estacion(
            codigo: "L1-\(String(format: "%02d", i + 1))",
            nombre: n,
            linea: .l1,
            estado: .operativa,
            ascensor: !sinAscensor.contains(n),
            accesible: true,
            anio: nil,
            nota: nota
        )
    )
}

guardar(
    "28 de Julio (L1 futura)",
    Estacion(
        codigo: "L1-FUT-28J",
        nombre: "28 de Julio",
        linea: .l1,
        estado: .proyectada,
        ascensor: true,
        accesible: true,
        anio: nil,
        nota: "Futura estación de intercambio con Línea 2. No está operativa."
    )
)

let nombresL2 = [
    "Puerto del Callao",
    "Buenos Aires",
    "Juan Pablo II",
    "Insurgentes",
    "Carmen de la Legua",
    "Óscar R. Benavides",
    "San Marcos",
    "Elio",
    "La Alborada",
    "Tingo María",
    "Parque Murillo",
    "Plaza Bolognesi",
    "Estación Central",
    "Manco Cápac",
    "Cangallo",
    "28 de Julio",
    "Nicolás Ayllón",
    "Circunvalación",
    "San Juan de Dios",
    "Evitamiento",
    "Óvalo Santa Anita",
    "Colectora Industrial",
    "Hermilio Valdizán",
    "Mercado Santa Anita",
    "Vista Alegre",
    "Prolongación Javier Prado",
    "Municipalidad de Ate"
]

for (i, n) in nombresL2.enumerated() {
    let num = i + 1
    let operativa = (20...24).contains(num)
    let etapa1B = (12...19).contains(num) || (25...27).contains(num)

    let nota = operativa
        ? "Etapa 1A habilitada. Horario habitual: 06:00-23:00; usa Tarjeta Interoperable de Transporte (TIT)."
        : etapa1B
            ? "Etapa 1B en construcción; operación prevista para 2029."
            : "Etapa 2 en construcción; operación prevista para octubre de 2030."

    guardar(
        l2(n),
        Estacion(
            codigo: "L2-E\(String(format: "%02d", num))",
            nombre: n,
            linea: .l2,
            estado: operativa ? .operativa : .construccion,
            ascensor: true,
            accesible: true,
            anio: operativa ? nil : (etapa1B ? 2029 : 2030),
            nota: nota
        )
    )
}

let nombresL4Ramal = [
    "Gambetta",
    "Canta Callao",
    "Bocanegra",
    "Aeropuerto",
    "El Olivar",
    "Quilca",
    "Morales Duárez",
    "Carmen de la Legua"
]

let nombresL4Troncal = [
    "Venezuela",
    "Rafael Escardó",
    "Pando",
    "José de Sucre",
    "Brasil",
    "Felipe Salaverry",
    "Guillermo Prescott",
    "Las Palmeras",
    "Conde de San Isidro",
    "Rivera Navarrete",
    "Pablo Carriquiry",
    "La Cultura",
    "San Luis",
    "Monterrico",
    "Manuel Olguín",
    "Los Frutales",
    "La Molina",
    "Santa Patricia",
    "Mayorazgo",
    "Mercado Santa Anita"
]

let nombresL4 = nombresL4Ramal + nombresL4Troncal

for (i, n) in nombresL4.enumerated() {
    let esRamal = i < nombresL4Ramal.count

    let nota = esRamal
        ? "Ramal Faucett-Gambetta: ya construido; pendiente de entrar en operación."
        : "Tramo troncal de Línea 4: en etapa inicial de construcción."

    guardar(
        l4(n),
        Estacion(
            codigo: "L4-\(String(format: "%02d", i + 1))",
            nombre: n,
            linea: .l4,
            estado: .construccion,
            ascensor: true,
            accesible: true,
            anio: 2030,
            nota: nota
        )
    )
}

let nombresL3 = [
    "El Álamo",
    "Huandoy",
    "2 de Octubre",
    "Villa Sol",
    "Naranjal",
    "Carlos Izaguirre",
    "Tomás Valle",
    "Bartolomé de las Casas",
    "José Granda",
    "Caquetá",
    "Tacna",
    "Garcilaso de la Vega",
    "Estación Central",
    "Parque de la Reserva",
    "Museo de Historia Natural",
    "César Canevaro",
    "Conde de San Isidro",
    "Andrés Aramburú",
    "Huaca Pucllana",
    "Parque Central de Miraflores",
    "Parque Reducto",
    "República de Panamá",
    "Juana Alarco",
    "Cabitos",
    "Alejandro Velasco",
    "Las Gardenias",
    "Los Héroes",
    "Pedro Miotta"
]

for (i, n) in nombresL3.enumerated() {
    guardar(
        l3(n),
        Estacion(
            codigo: "L3-\(String(format: "%02d", i + 1))",
            nombre: n,
            linea: .l3,
            estado: .proyectada,
            ascensor: true,
            accesible: true,
            anio: nil,
            nota: "Línea 3: proyecto aprobado, aún sin inicio de construcción."
        )
    )
}

let nombresMet = [
    "Jirón de la Unión",
    "Central",
    "Estadio Nacional",
    "México",
    "Canadá",
    "Javier Prado",
    "Canaval y Moreyra",
    "Aramburú",
    "Angamos",
    "Ricardo Palma",
    "Benavides",
    "28 de Julio"
]

for (i, n) in nombresMet.enumerated() {
    guardar(
        met(n),
        Estacion(
            codigo: "MET-\(String(format: "%02d", i + 1))",
            nombre: n,
            linea: .met,
            estado: .operativa,
            ascensor: nil,
            accesible: true,
            anio: nil,
            nota: "Estación operativa del Metropolitano incluida como punto estratégico del prototipo."
        )
    )
}
