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
    
}

// --- TODO 15: SucursalProvincia ---

// NO sobreescribas descuento() (hereda el 5 % de la base)
// override costoEnvio(monto:): 8 % del monto, con un MINIMO de 50.0 (usa un if)
// --- TODO 16: SucursalOutlet ---
// override descuento() -> 0.25
// override costoEnvio(monto:) -> 0.0 (solo recojo en tienda)
// --- TODO 17: El recorrido polimorfico (REGLA 4) ---
// let refrigeradora = Electrodomestico(nombre: "Refrigeradora", marca: "Frost", precioLista: 2000.0, categoria: .lineaBlanca)
// let licuadora = Electrodomestico(nombre: "Licuadora", marca: "Mix", precioLista: 250.0, categoria: .pequenos)
// let sucursales: [Sucursal] = [SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
// SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
// SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima")]
// print("===== Refrigeradora (S/ 2000.0) =====")
// for sucursal in sucursales { ___ }
// print("===== Licuadora (S/ 250.0) =====")
// for sucursal in sucursales { ___ }
// --- TODO 18: La prueba del polimorfismo (REGLA 6) ---
// Agrega SucursalOnline con envio fijo de 15.0, sumala al array,
// y NO toques ni cotizar ni los for-in.
// Responde en un comentario: cuantas lineas nuevas necesitaste?
