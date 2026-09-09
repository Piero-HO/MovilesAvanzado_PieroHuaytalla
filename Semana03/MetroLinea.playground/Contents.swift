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
conectar(
    "28 de Julio",
    "Gamarra",
    .l1,
    .construccion,
    "Referencia temporal para el intercambio entre Línea 1 y Línea 2."
)

conectar(
    "Estación Central",
    "Central",
    .met,
    .construccion,
    "Conexión futura con el Metropolitano."
)

conectar(
    "Carmen de la Legua",
    "Carmen de la Legua",
    .l4,
    .construccion,
    "Futuro intercambio entre Línea 2 y Línea 4."
)

conectar(
    "Cabitos",
    "Cabitos",
    .l3,
    .proyectada,
    "Futuro intercambio entre Línea 1 y Línea 3."
)

conectar(
    "Estación Central",
    "Estación Central",
    .l3,
    .proyectada,
    "Futuro intercambio entre Línea 2 y Línea 3."
)

conectar(
    "Conde de San Isidro",
    "Conde de San Isidro",
    .l4,
    .proyectada,
    "Futuro intercambio entre Línea 3 y Línea 4."
)

conectar(
    "La Cultura",
    "La Cultura",
    .l4,
    .construccion,
    "Futuro intercambio entre Línea 1 y Línea 4."
)

let destinos: [String: Destino] = [
    "estadio nacional": Destino(
        nombre: "Estadio Nacional del Perú",
        estacion: "Estadio Nacional",
        detalle: "Usa el Metropolitano y baja en Estadio Nacional."
    ),

    "centro de lima": Destino(
        nombre: "Centro Histórico de Lima",
        estacion: "Jirón de la Unión",
        detalle: "Jirón de la Unión es una opción para el Centro de Lima."
    ),

    "miraflores": Destino(
        nombre: "Miraflores",
        estacion: "Ricardo Palma",
        detalle: "Ricardo Palma es una opción para llegar a Miraflores."
    ),

    "san isidro": Destino(
        nombre: "San Isidro",
        estacion: "Canaval y Moreyra",
        detalle: "Canaval y Moreyra es una opción para San Isidro."
    ),

    "gamarra": Destino(
        nombre: "Gamarra",
        estacion: "Gamarra",
        detalle: "Usa Línea 1 y baja en Gamarra."
    ),

    "aeropuerto": Destino(
        nombre: "Aeropuerto Internacional Jorge Chávez",
        estacion: "Aeropuerto",
        detalle: "La estación Aeropuerto pertenece a la Línea 4."
    )
]
func buscar(_ texto: String) -> [(String, Estacion)] {
    let consulta = normalizar(texto)

    return estaciones
        .filter {
            normalizar($0.key).contains(consulta)
        }
        .sorted {
            $0.key < $1.key
        }
}

func mostrarEstacion(_ nombre: String) {
    guard let estacion = estaciones[nombre] else {
        print("Estación no encontrada.")
        return
    }

    print("\n=== \(estacion.nombre) ===")
    print(
        "Línea(s): " +
        estacion.lineas.map { $0.rawValue }.joined(separator: ", ")
    )
    print("Estado: \(estacion.estado.rawValue)")
    print("Ascensor: \(estacion.ascensor ? "Sí" : "No")")
    print("Accesible: \(estacion.accesible ? "Sí" : "No")")

    if estacion.conexiones.isEmpty {
        print("Conexiones: no registradas.")
    } else {
        print("Conexiones:")

        for conexion in estacion.conexiones {
            print("- \(conexion.linea.rawValue): \(conexion.destino)")
            print("  Estado: \(conexion.estado.rawValue)")
            print("  \(conexion.detalle)")
        }
    }
}

func elegir(_ resultados: [(String, Estacion)]) -> String? {
    if resultados.count == 1 {
        return resultados[0].0
    }

    for (i, resultado) in resultados.enumerated() {
        print(
            "\(i + 1). \(resultado.1.nombre) - " +
            resultado.1.lineas.map { $0.rawValue }.joined(separator: ", ")
        )
    }

    guard
        let numero = Int(readLine() ?? ""),
        (1...resultados.count).contains(numero)
    else {
        return nil
    }

    return resultados[numero - 1].0
}

func opcionBuscar() {
    print("Ingrese el nombre de la estación:")

    let resultados = buscar(readLine() ?? "")

    guard !resultados.isEmpty,
          let nombre = elegir(resultados)
    else {
        print("No se encontraron estaciones.")
        return
    }

    mostrarEstacion(nombre)
}

func listar(_ linea: Linea) {
    let lista = estaciones.values
        .filter { $0.lineas.contains(linea) }
        .sorted { $0.nombre < $1.nombre }

    print("\n=== \(linea.rawValue) ===")

    for estacion in lista {
        print(
            "- \(estacion.nombre) | " +
            "\(estacion.estado.rawValue) | " +
            "Ascensor: \(estacion.ascensor ? "Sí" : "No")"
        )
    }

    print("Total: \(lista.count)")
}

func opcionLinea() {
    print("""
    
    1. Línea 1
    2. Línea 2
    3. Línea 3
    4. Línea 4
    5. Metropolitano
    """)

    switch readLine() {
    case "1": listar(.l1)
    case "2": listar(.l2)
    case "3": listar(.l3)
    case "4": listar(.l4)
    case "5": listar(.met)
    default: print("Opción inválida.")
    }
}

func opcionDestino() {
    print("Ingrese destino:")

    let consulta = normalizar(readLine() ?? "")

    guard let destino =
        destinos[consulta] ??
        destinos.first(where: {
            consulta.contains($0.key)
        })?.value
    else {
        print("Destino no registrado.")
        return
    }

    print("\nDestino: \(destino.nombre)")
    print("Estación recomendada: \(destino.estacion)")
    print(destino.detalle)

    if let estacion = estaciones[destino.estacion],
       estacion.estado != .operativa {
        print("ADVERTENCIA: infraestructura aún no operativa.")
    }
}

func cruces() {
    print("""
    
    === CONEXIONES PRINCIPALES ===
    
    28 de Julio:
    Línea 1 <-> Línea 2
    
    Estación Central:
    Línea 2 <-> Metropolitano
    
    Carmen de la Legua:
    Línea 2 <-> Línea 4
    
    Cabitos:
    Línea 1 <-> Línea 3
    
    Estación Central:
    Línea 2 <-> Línea 3
    
    Conde de San Isidro:
    Línea 3 <-> Línea 4
    
    La Cultura:
    Línea 1 <-> Línea 4
    
    Grau:
    Pertenece a Línea 1.
    No es un intercambio directo con Línea 2.
    """)
}
typealias Grafo = [String: [String]]

func crearGrafo() -> Grafo {
    var grafo: Grafo = [:]

    func unir(_ a: String, _ b: String) {
        grafo[a, default: []].append(b)
        grafo[b, default: []].append(a)
    }

    for lista in [
        nombresL1,
        nombresL2,
        nombresL3,
        nombresL4,
        nombresMet
    ] {
        for i in 0..<(lista.count - 1) {
            unir(lista[i], lista[i + 1])
        }
    }

    for estacion in estaciones.values {
        for conexion in estacion.conexiones {
            unir(estacion.nombre, conexion.destino)
        }
    }

    return grafo
}

func bfs(
    _ origen: String,
    _ destino: String,
    _ grafo: Grafo
) -> [String]? {

    var cola = [origen]
    var visitados: Set<String> = [origen]
    var anterior: [String: String] = [:]

    while !cola.isEmpty {
        let actual = cola.removeFirst()

        if actual == destino {
            break
        }

        for vecino in grafo[actual, default: []] {
            if !visitados.contains(vecino) {
                visitados.insert(vecino)
                anterior[vecino] = actual
                cola.append(vecino)
            }
        }
    }

    guard visitados.contains(destino) else {
        return nil
    }

    var ruta = [destino]
    var actual = destino

    while let padre = anterior[actual] {
        ruta.append(padre)
        actual = padre
    }

    return ruta.reversed()
}

func opcionRuta() {
    print("Estación de origen:")

    let origenTexto = readLine() ?? ""

    guard let origen = buscar(origenTexto).first?.0 else {
        print("Origen no encontrado.")
        return
    }

    print("Destino:")

    let destinoTexto = normalizar(readLine() ?? "")

    let destino =
        destinos[destinoTexto]?.estacion ??
        buscar(destinoTexto).first?.0

    guard let destino else {
        print("Destino no encontrado.")
        return
    }

    guard let ruta = bfs(
        origen,
        destino,
        crearGrafo()
    ) else {
        print("No se encontró una ruta.")
        return
    }

    print("\n=== RUTA ===")

    for (i, estacion) in ruta.enumerated() {
        print("\(i + 1). \(estacion)")
    }

    print(
        "Paradas aproximadas: " +
        "\(max(0, ruta.count - 1))"
    )
}
