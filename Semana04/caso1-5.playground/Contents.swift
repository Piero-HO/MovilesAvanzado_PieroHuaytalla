// Piero Huaytalla

import Foundation

// ===== CASO 1.5: HERENCIA Y POLIMORFISMO — LA CADENA DE SUCURSALES =====
// Docente: Juan León
enum CategoriaElectro {
    case lineaBlanca, tecnologia, pequenos
}

struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}

// --- Ejemplo (ya resuelto): la base define el FLUJO; las hijas cambiaran las REGLAS ---
class Sucursal {
    let nombre: String
    let ciudad: String
    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }
    func descuento() -> Double {
        return 0.05
    }
    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }
    
    // REGLA 2: este metodo NO se sobreescribe en las subclases
    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio
        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/\(envio) = S/ \(total)")
    }
}

// --- TODO 14: SucursalLima ---
// override descuento() -> 0.10
// override costoEnvio(monto:): si monto >= 1500 devuelve 0.0; si no, 30.0 (usa un if)
class SucursalLima: Sucursal {
    override func descuento() -> Double {
        return 0.10
    }
    
    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500 {
            return 0.0
        } else {
            return 30.0
        }
    }
}

// --- TODO 15: SucursalProvincia ---

// NO sobreescribas descuento() (hereda el 5 % de la base)
// override costoEnvio(monto:): 8 % del monto, con un MINIMO de 50.0 (usa un if)
class SucursalProvincia: Sucursal {
    override func costoEnvio(monto: Double) -> Double {
        let envio = monto * 0.08
        if envio < 50.0 {
            return 50.0
        } else {
            return envio
        }
    }
}

// --- TODO 16: SucursalOutlet ---
// override descuento() -> 0.25
// override costoEnvio(monto:) -> 0.0 (solo recojo en tienda)
class SucursalOutlet: Sucursal {
    override func descuento() -> Double {
        return 0.25
    }
    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}

// --- TODO 17: El recorrido polimorfico (REGLA 4) ---
let refrigeradora = Electrodomestico(
    nombre: "Refrigeradora",
    marca: "Frost",
    precioLista: 2000.0,
    categoria: .lineaBlanca)

let licuadora = Electrodomestico(
    nombre: "Licuadora",
    marca: "Mix",
    precioLista: 250.0,
    categoria: .pequenos)

let sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima"),
    SucursalOnline(nombre: "Tienda Online", ciudad: "Web" )
    ]

print("===== Refrigeradora (S/ 2000.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}

print("===== Licuadora (S/ 250.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}

// --- TODO 18: La prueba del polimorfismo (REGLA 6) ---
// Agrega SucursalOnline con envio fijo de 15.0, sumala al array,
// y NO toques ni cotizar ni los for-in.
class SucursalOnline: Sucursal {
    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
}
// Responde en un comentario: cuantas lineas nuevas necesitaste?
// Se necesitaron 5 lineas para definir la clase y 1 línea para sumarla al array


// ===== FIX: Este codigo tiene 2 errores =====
// Docente: Juan León
class SucursalMall: Sucursal {
override func descuento() -> Double { // FIX 7: no compila. Que palabra clave falta y por que Swift la exige?
    // falta el override y lo exige ya que es un metodo heredado
    return 0.12
    }
}

class SucursalExpress: Sucursal {
    let radioKm: Int
    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm
        super.init(nombre: nombre, ciudad: ciudad)
    } // FIX 8: no compila. Que llamada falta al final del init?
}   // falta invocar al inicializador designado de la superclase

// ===== PREDICT: Que imprime? =====
// Docente: Juan León
let misteriosa: Sucursal = SucursalLima(nombre: "Lima Centro", ciudad: "Lima")
print(misteriosa.descuento()) // PREDICT 6: 0.05 o 0.1? Justifica: la variable es de tipo Sucursal...
    // 0.1, se usa el metodo de la instancia sucursalLima
let monto = 2000.0 * (1 - misteriosa.descuento())
print(misteriosa.costoEnvio(monto: monto)) // PREDICT 7: 0.0, como 1800 es el monto se activa el monto gratis
