import Foundation

// Actividad propuesta 02: herencia y polimorfismo con clientes bancarios.

class Cliente {
    let codigo: String
    let direccion: String
    let fechaDeRegistro: String
    let numeroCuenta: String
    let montoMinimoApertura: Double

    init(
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }

    func mostrarDatos() {
        print("📄 Código: \(codigo)")
        print("📍 Dirección: \(direccion)")
        print("🗓️ Fecha de registro: \(fechaDeRegistro)")
        print("🏦 N.º Cuenta: \(numeroCuenta)")
        print(String(format: "💰 Monto mínimo de apertura: S/ %.2f", montoMinimoApertura))
    }
}

class ClienteNatural: Cliente {
    let nombreCompleto: String
    let dni: String

    init(
        nombreCompleto: String,
        dni: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.nombreCompleto = nombreCompleto
        self.dni = dni
        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {
        print("👤 CLIENTE NATURAL")
        print("Nombre: \(nombreCompleto)")
        print("DNI: \(dni)")
        super.mostrarDatos()
    }
}

class ClienteJuridico: Cliente {
    let razonSocial: String
    let ruc: String
    let representanteLegal: String

    init(
        razonSocial: String,
        ruc: String,
        representanteLegal: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal
        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {
        print("🏢 CLIENTE JURÍDICO")
        print("Razón social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante legal: \(representanteLegal)")
        super.mostrarDatos()
    }
}

// Casos de prueba
let clienteNatural = ClienteNatural(
    nombreCompleto: "Juan Pérez",
    dni: "12345678",
    codigo: "C001",
    direccion: "Av. Lima 123",
    fechaDeRegistro: "2025-04-03",
    numeroCuenta: "001-2025-000123",
    montoMinimoApertura: 500.00
)

let clienteJuridico = ClienteJuridico(
    razonSocial: "Soluciones SAC",
    ruc: "20123456789",
    representanteLegal: "María León",
    codigo: "C002",
    direccion: "Jr. Empresas 456",
    fechaDeRegistro: "2025-04-01",
    numeroCuenta: "001-2025-000456",
    montoMinimoApertura: 3_000.00
)

// El arreglo de tipo Cliente demuestra el polimorfismo.
let clientes: [Cliente] = [clienteNatural, clienteJuridico]

for (indice, cliente) in clientes.enumerated() {
    cliente.mostrarDatos()

    if indice < clientes.count - 1 {
        print(String(repeating: "-", count: 38))
    }
}
