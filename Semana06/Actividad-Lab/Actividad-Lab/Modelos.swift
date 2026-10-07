// Desarrollado por: Piero Huaytalla
import UIKit

class Producto {
    let nombre: String
    let precio: Double
    var stock: Int

    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

class ItemCarrito {
    let producto: Producto
    var cantidad: Int

    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }

    // Ejemplo resuelto: cada línea sabe calcular su propio subtotal
    func subtotal() -> Double {
        return producto.precio * Double(cantidad)
    }
}

class CarritoModel {
    var items: [ItemCarrito] = []

    // A1: agregar sin superar el stock ni repetir líneas
    func agregar(producto: Producto, cantidad: Int) -> Bool {
        if cantidad <= 0 {
            return false
        }

        for item in items {
            if item.producto === producto {
                if item.cantidad + cantidad > producto.stock {
                    return false
                }

                item.cantidad += cantidad
                return true
            }
        }

        if cantidad > producto.stock {
            return false
        }

        items.append(
            ItemCarrito(producto: producto, cantidad: cantidad)
        )
        return true
    }

    // A2: suma de los subtotales de cada línea
    func subtotal() -> Double {
        var monto = 0.0

        for item in items {
            monto += item.subtotal()
        }

        return monto
    }

    // A3: descuento según el subtotal
    func porcentajeDescuento() -> Double {
        let monto = subtotal()

        if monto >= 5000 {
            return 0.15
        } else if monto >= 2000 {
            return 0.10
        } else if monto >= 500 {
            return 0.05
        } else {
            return 0.0
        }
    }

    // A4: suma de las unidades del carrito
    func cantidadTotal() -> Int {
        var cantidad = 0

        for item in items {
            cantidad += item.cantidad
        }

        return cantidad
    }

    // A5: elimina todas las líneas
    func vaciar() {
        items.removeAll()
    }

    func descuento() -> Double {
        return subtotal() * porcentajeDescuento()
    }

    func base() -> Double {
        return subtotal() - descuento()
    }

    func igv() -> Double {
        return base() * 0.18
    }

    func total() -> Double {
        return base() + igv()
    }

    func categoria() -> String {
        switch Int(subtotal()) {
        case ..<500:
            return "Regular"
        case 500..<2000:
            return "Frecuente"
        case 2000..<5000:
            return "VIP"
        default:
            return "Premium"
        }
    }

    func boleta(cliente: ClienteModel) -> String {
        var texto = "=========== BOLETA DE COMPRA ===========\n"
        texto += "Cliente: \(cliente.nombres) \(cliente.apellidos) (\(categoria()))\n"
        texto += "DNI: \(cliente.dni)\n"
        texto += "----------------------------------------\n"

        for item in items {
            texto += "\(item.producto.nombre) x\(item.cantidad) "
            texto += String(format: "S/ %.2f\n", item.subtotal())
        }

        texto += "----------------------------------------\n"
        texto += String(format: "Subtotal: S/ %.2f\n", subtotal())
        texto += String(format: "Descuento (%.0f%%): -S/ %.2f\n", porcentajeDescuento() * 100, descuento())
        texto += String(format: "IGV (18%%): S/ %.2f\n", igv())
        texto += String(format: "TOTAL: S/ %.2f\n", total())
        texto += "========================================"
        return texto
    }

    func confirmarCompra() {
        for item in items {
            item.producto.stock -= item.cantidad
        }
        vaciar()
    }
}

class ClienteModel {
    let nombres: String
    let apellidos: String
    let dni: String

    init(nombres: String, apellidos: String, dni: String) {
        self.nombres = nombres
        self.apellidos = apellidos
        self.dni = dni
    }
}
