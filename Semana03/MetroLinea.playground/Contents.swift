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
let nombresL1 = [
    "Villa El Salvador", "Parque Industrial", "Pumacahua",
    "Villa María", "María Auxiliadora", "San Juan", "Atocongo",
    "Jorge Chávez", "Ayacucho", "Cabitos", "Angamos",
    "San Borja Sur", "La Cultura", "Arriola", "Gamarra", "Grau",
    "El Ángel", "Presbítero Maestro", "Caja de Agua",
    "Pirámide del Sol", "Los Jardines", "Los Postes", "San Carlos",
    "San Martín", "Santa Rosa", "Bayóvar"
]

let nombresL2 = [
    "Puerto del Callao", "Buenos Aires", "Juan Pablo II",
    "Insurgentes", "Carmen de la Legua", "Óscar R. Benavides",
    "San Marcos", "Elio", "La Alborada", "Tingo María",
    "Parque Murillo", "Plaza Bolognesi", "Estación Central",
    "Manco Cápac", "Cangallo", "28 de Julio", "Nicolás Ayllón",
    "Circunvalación", "San Juan de Dios", "Evitamiento",
    "Óvalo Santa Anita", "Colectora Industrial",
    "Hermilio Valdizán", "Mercado Santa Anita", "Vista Alegre",
    "Prolongación Javier Prado", "Municipalidad de Ate"
]

let nombresL3 = [
    "El Álamo", "Huandoy", "2 de Octubre", "Villa Sol", "Naranjal",
    "Carlos Izaguirre", "Tomás Valle", "Bartolomé de las Casas",
    "José Granda", "Caquetá", "Tacna", "Garcilaso de la Vega",
    "Estación Central", "Parque de la Reserva",
    "Museo de Historia Natural", "César Canevaro",
    "Conde de San Isidro", "Andrés Aramburú", "Huaca Pucllana",
    "Parque Central de Miraflores", "Parque Reducto",
    "República de Panamá", "Juana Alarco", "Cabitos",
    "Alejandro Velasco", "Las Gardenias", "Los Héroes", "Pedro Miotta"
]

let nombresL4 = [
    "Gambetta", "Canta Callao", "Bocanegra", "Aeropuerto",
    "El Olivar", "Quilca", "Morales Duárez", "Carmen de la Legua",
    "Venezuela", "Rafael Escardó", "Pando", "José de Sucre",
    "Brasil", "Felipe Salaverry", "Guillermo Prescott",
    "Las Palmeras", "Conde de San Isidro", "Rivera Navarrete",
    "Pablo Carriquiry", "La Cultura", "San Luis", "Monterrico",
    "Manuel Olguín", "Los Frutales", "La Molina", "Santa Patricia",
    "Mayorazgo", "Mercado Santa Anita"
]

let nombresMet = [
    "Jirón de la Unión", "Central", "Estadio Nacional", "México",
    "Canadá", "Javier Prado", "Canaval y Moreyra", "Aramburú",
    "Angamos", "Ricardo Palma", "Benavides", "28 de Julio"
]

let sinAscensor: Set<String> = [
    "Pumacahua", "Villa María", "María Auxiliadora", "San Borja Sur"
]

for nombre in nombresL1 {
    agregarEstacion(
        nombre,
        [.l1],
        .operativa,
        !sinAscensor.contains(nombre)
    )
}

for (i, nombre) in nombresL2.enumerated() {
    let estado: Estado = (20...24).contains(i + 1)
        ? .operativa
        : .construccion

    agregarEstacion(nombre, [.l2], estado)
}

for nombre in nombresL3 {
    if let estacion = estaciones[nombre] {
        estaciones[nombre] = Estacion(
            nombre: nombre,
            lineas: estacion.lineas + [.l3],
            estado: .proyectada,
            ascensor: true,
            accesible: true
        )
    } else {
        agregarEstacion(nombre, [.l3], .proyectada)
    }
}

for nombre in nombresL4 {
    if let estacion = estaciones[nombre] {
        estaciones[nombre] = Estacion(
            nombre: nombre,
            lineas: estacion.lineas + [.l4],
            estado: .construccion,
            ascensor: true,
            accesible: true
        )
    } else {
        agregarEstacion(nombre, [.l4], .construccion)
    }
}

for nombre in nombresMet {
    if let estacion = estaciones[nombre] {
        estaciones[nombre] = Estacion(
            nombre: nombre,
            lineas: estacion.lineas + [.met],
            estado: estacion.estado,
            ascensor: true,
            accesible: true
        )
    } else {
        agregarEstacion(nombre, [.met], .operativa)
    }
}
