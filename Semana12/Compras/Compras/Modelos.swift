import Foundation
import SwiftData

@Model final class Usuario {
    var nombre: String
    var usuario: String
    var clave: String
    var rol: String
    @Relationship(deleteRule: .deny, inverse: \Compra.comprador) var compras: [Compra] = []
    init(nombre: String, usuario: String, clave: String, rol: String) {
        self.nombre = nombre; self.usuario = usuario; self.clave = clave; self.rol = rol
    }
}

@Model final class Proveedor {
    var nombre: String
    var ruc: String
    @Relationship(deleteRule: .deny, inverse: \Compra.proveedor) var compras: [Compra] = []
    init(nombre: String, ruc: String) { self.nombre = nombre; self.ruc = ruc }
}

@Model final class Producto {
    var nombre: String
    var categoria: String
    var stock: Int
    var costoPromedio: Double
    @Relationship(deleteRule: .deny, inverse: \Compra.producto) var compras: [Compra] = []
    init(nombre: String, categoria: String, stock: Int, costoPromedio: Double) {
        self.nombre = nombre; self.categoria = categoria; self.stock = stock; self.costoPromedio = costoPromedio
    }
}

@Model final class Compra {
    var fecha: Date
    var cantidad: Int
    var costoUnitario: Double
    var igv: Double
    var total: Double
    var alCredito: Bool
    var vence: Date
    var estado: String
    var pagada: Bool
    var motivoRechazo: String?
    var comprador: Usuario?
    var proveedor: Proveedor?
    var producto: Producto?
    init(cantidad: Int, costoUnitario: Double, alCredito: Bool, comprador: Usuario, proveedor: Proveedor, producto: Producto, fecha: Date = .now) {
        self.fecha = fecha; self.cantidad = cantidad; self.costoUnitario = costoUnitario
        let impuesto = (Double(cantidad) * costoUnitario * 18).rounded() / 100
        let importe = (Double(cantidad) * costoUnitario * 100).rounded() / 100 + impuesto
        self.igv = impuesto
        self.total = importe
        self.alCredito = alCredito; self.vence = Calendar.current.date(byAdding: .day, value: 30, to: fecha) ?? fecha
        self.estado = importe >= 5000 ? "Pendiente" : "Aprobada"
        self.pagada = !alCredito; self.comprador = comprador; self.proveedor = proveedor; self.producto = producto
    }
    var vencida: Bool { estado == "Aprobada" && alCredito && !pagada && vence < .now }
    func aplicarInventario() {
        guard let producto else { return }
        let nuevoStock = producto.stock + cantidad
        guard nuevoStock > 0 else { return }
        producto.costoPromedio = (Double(producto.stock) * producto.costoPromedio + Double(cantidad) * costoUnitario) / Double(nuevoStock)
        producto.stock = nuevoStock
    }
}

@Observable final class Sesion {
    var usuario: Usuario?
}

func dinero(_ valor: Double) -> String { String(format: "S/ %.2f", valor) }
