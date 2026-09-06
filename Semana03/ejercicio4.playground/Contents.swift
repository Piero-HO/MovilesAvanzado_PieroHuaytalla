// Desarrollado por: Piero Huaytalla

import Foundation

// Pide N productos con nombre, precio y stock
// Calcula valor total y muestra stock bajo
var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]

print("¿Cuántos productos?")
let n = Int(readLine() ?? "") ?? 0
for i in 1...n {
    print("Producto \(i) - Nombre:")
    let nombre = readLine() ?? ""
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0
    print("Stock:")
    let stock = Int(readLine() ?? "") ?? 0
    precios[nombre] = precio
    stocks[nombre] = stock
}
// TODO: Calcular valor total (precio × stock)
// TODO: Mostrar productos con stock < 5
var valorTotalInventario = 0.0
print("\n===== Inventario =====")
for (nombre, precio) in precios {
    if let stock = stocks[nombre] {
        let subtotal = precio * Double(stock)
        valorTotalInventario += subtotal
        print("\(nombre) | Precio: S/. \(precio) | Stock: \(stock) | Subtotal: S/. \(subtotal)")    }
}

print("\nValor total del inventario: S/. \(valorTotalInventario)")

print("\n==== productos con stock bajo ====")
var hayStockBajo = false
for (nombre, stock) in stocks{
    if stock < 5 {
        print("Alerta: \(nombre) tiene solo \(stock) unidades")
    }
}
if !hayStockBajo {
    print("Todos los productos tienen stock suficiente")
}
