import Foundation

print("Nombre del Producto")
let producto = readLine() ?? ""
print("Ingrese el Precio")
let precio = Double(readLine() ?? "") ?? 0
print("Ingrese la Cantidad")
let cantidad = Int(readLine() ?? "") ?? 0
let montoTotal = precio * Double(cantidad)
print("\nNombre del producto: \(producto)")
print("Precio unit: \(precio)")
print("Cantidad: \(cantidad)")
print("Monto total de la compra: \(montoTotal)")

print("Elige el plan de pago:")
print("6 (20%)")
print("12 (40%)")
print("24 (60%)")

